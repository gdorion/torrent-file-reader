//
//  TorrentDecoder.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentDecoder.h"

// Types
#import "Type.h"
#import "TypeDictionary.h"
#import "TypeArray.h"
#import "TypeInteger.h"
#import "TypeString.h"
#import "TypeHelper.h"

// Model
#import "Torrent.h"
#import "File.h"

NSString * kTorrentPathDictKey = @"path";
NSString * kTorrentNameDictKey = @"name";
NSString * kTorrentPiecesDictKey = @"pieces";
NSString * kTorrentLengthDictKey = @"length";
NSString * kTorrentCreationClientDictKey = @"created by";
NSString * kTorrentCreationDateDictKey = @"creation date";
NSString * kTorrentFilesDictKey = @"files";
NSString * kTorrentAnnounceDictKey = @"announce";

NSInteger kTorrentSHA1Lenght = 20;

@interface TorrentDecoder()

@property (nonatomic) NSMutableDictionary * torrentInformations;

@end

@implementation TorrentDecoder

- (Torrent*)decodeTorrent:(NSString*)filePath {
    self.torrentInformations = [NSMutableDictionary new];
    
    // Retreive torrent informations.
    NSError * error = [NSError new];
    NSString * fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    [self decodedContentFromString:fileContent];
    
    return [self torrentFromDictionary:self.torrentInformations];
}


#pragma mark - String -> Dictionary

- (void)decodedContentFromString:(NSString*)string {
    NSString * content = [string copy];
    NSString * firstChar = [content substringWithRange:NSMakeRange(0, 1)];
    
    Type * newDecodedValue = nil;
 
    // Dictionary
    if ([firstChar isEqualToString:@"d"]) {
        TypeDictionary * dictionary = [[TypeDictionary alloc] initWithString:content];
        newDecodedValue = dictionary;
        self.torrentInformations = dictionary.decodedDictionary;
    }
}

#pragma mark - Dictionary -> Torrent

- (Torrent*)torrentFromDictionary:(NSDictionary*)dictionary {
    
    // Torrent files.
    NSArray * fileList = [self torrentFileListFrom:dictionary];
    
    // Other informations.
    NSInteger creationDate = [TypeHelper intForKey:kTorrentCreationDateDictKey inDictionaryTree:dictionary].decodedValue;
    NSString * creationClient = [TypeHelper stringForKey:kTorrentCreationClientDictKey inDictionaryTree:dictionary].decodedValue;
    NSString * announce = [TypeHelper stringForKey:kTorrentAnnounceDictKey inDictionaryTree:dictionary].decodedValue;
    
    Torrent * newTorrent = [[Torrent alloc] initWithFileList:fileList andCreationClient:creationClient andCreationDate:creationDate andAnnounce:announce];
    return newTorrent;
}

#pragma mark - Torrent files

- (NSArray*)torrentFileListFrom:(NSDictionary*)dictionary {
    NSMutableArray * fileList = [NSMutableArray new];
    
    // Many files (nested under 'files')
    Type * filesType = [TypeHelper typeForKey:kTorrentFilesDictKey inDictionaryTree:dictionary];
    if (filesType) {
        if ([filesType isKindOfClass:[TypeArray class]]) {
            TypeArray * filesTypeArray = (TypeArray*)filesType;
            
            // Extracting checksum
            NSString * pieces = [TypeHelper stringForKey:kTorrentPiecesDictKey inDictionaryTree:dictionary].decodedValue;
            
            for (int i=0; i < filesTypeArray.decodedArray.count; i++) {
                TypeDictionary * dict = [filesTypeArray.decodedArray objectAtIndex:i];
                
                NSString * path = [TypeHelper stringForKey:kTorrentPathDictKey inDictionaryTree:dict.decodedDictionary].decodedValue;
                NSInteger length = [TypeHelper intForKey:kTorrentLengthDictKey inDictionaryTree:dict.decodedDictionary].decodedValue;
                NSString * checksum = [pieces substringWithRange:NSMakeRange(i * kTorrentSHA1Lenght, kTorrentSHA1Lenght)];
                
                File * newFile = [[File alloc] initWithName:path andLength:length andChecksum:checksum];
                [fileList addObject:newFile];
            }
        }
    }
    
    // Single file (trying : 'name' or 'path')
    else {
        NSString * path = [TypeHelper stringForKey:kTorrentPathDictKey inDictionaryTree:dictionary].decodedValue;
        if (path == nil) {
            // Try name value
            path = [TypeHelper stringForKey:kTorrentNameDictKey inDictionaryTree:dictionary].decodedValue;
        }
        
        NSInteger length = [TypeHelper intForKey:kTorrentLengthDictKey inDictionaryTree:dictionary].decodedValue;
        NSString * pieces = [TypeHelper stringForKey:kTorrentPiecesDictKey inDictionaryTree:dictionary].decodedValue;
        NSString * checksum = [pieces substringWithRange:NSMakeRange(0, kTorrentSHA1Lenght)];
        
        File * newFile = [[File alloc] initWithName:path andLength:length andChecksum:checksum];
        [fileList addObject:newFile];
    }
    
    return fileList;
}

@end
