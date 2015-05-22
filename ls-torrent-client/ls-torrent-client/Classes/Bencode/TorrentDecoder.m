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

// Torrent metadata information keys
// Ref.: https://wiki.theory.org/BitTorrentSpecification
NSString * kTorrentPathDictKey = @"path";
NSString * kTorrentNameDictKey = @"name";
NSString * kTorrentPiecesDictKey = @"pieces";
NSString * kTorrentLengthDictKey = @"length";
NSString * kTorrentCreationClientDictKey = @"created by";
NSString * kTorrentCreationDateDictKey = @"creation date";
NSString * kTorrentFilesDictKey = @"files";
NSString * kTorrentAnnounceDictKey = @"announce";
NSString * kTorrentFileMD5ChecksumDictKey = @"md5sum";
NSInteger  kTorrentSHA1Lenght = 20;

@implementation TorrentDecoder

- (Torrent*)decodeTorrent:(NSString*)filePath {
    // Retreive torrent informations.
    NSError * error = [NSError new];
    NSString * fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    NSMutableDictionary * dict = [self decodedContentFromString:fileContent];
    
    return [self torrentFromDictionary:dict];
}


#pragma mark - String -> Dictionary

// NSString -> NSDictionary
- (NSMutableDictionary *)decodedContentFromString:(NSString*)string {
    NSString * content = [string copy];
    NSString * firstChar = [content substringWithRange:NSMakeRange(0, 1)];
    
    Type * newDecodedValue = nil;
 
    // Dictionary
    if ([firstChar isEqualToString:@"d"]) {
        TypeDictionary * dictionary = [[TypeDictionary alloc] initWithString:content];
        newDecodedValue = dictionary;
        return dictionary.decodedDictionary;
    }
    
    return nil;
}

#pragma mark - NSDictonary -> Torrent

// NSDictonary -> Torrent
- (Torrent*)torrentFromDictionary:(NSDictionary*)dictionary {
    // Torrent files.
    NSArray * fileList = [self torrentFileListFrom:dictionary];
    
    // Other information.
    NSInteger creationDate = [TypeHelper intForKey:kTorrentCreationDateDictKey inDictionaryTree:dictionary].decodedValue;
    NSString * creationClient = [TypeHelper stringForKey:kTorrentCreationClientDictKey inDictionaryTree:dictionary].decodedValue;
    NSString * announce = [TypeHelper stringForKey:kTorrentAnnounceDictKey inDictionaryTree:dictionary].decodedValue;
    
    Torrent * newTorrent = [[Torrent alloc] initWithFileList:fileList andCreationClient:creationClient andCreationDate:creationDate andAnnounce:announce];
    return newTorrent;
}

#pragma mark - NSDictionary -> File list

// NSDictionary -> File list
- (NSArray*)torrentFileListFrom:(NSDictionary*)dictionary {
    NSMutableArray * fileList = [NSMutableArray new];
    
    // Many files (nested under 'files')
    Type * filesType = [TypeHelper typeForKey:kTorrentFilesDictKey inDictionaryTree:dictionary];
    if (filesType) {
        
        if ([filesType isKindOfClass:[TypeArray class]]) {
            TypeArray * filesTypeArray = (TypeArray*)filesType;
            NSString * pieces = [TypeHelper stringForKey:kTorrentPiecesDictKey inDictionaryTree:dictionary].decodedValue;
            
            for (int i=0; i < filesTypeArray.decodedArray.count; i++) {
                TypeDictionary * dict = [filesTypeArray.decodedArray objectAtIndex:i];
                [fileList addObject:[self fileFromDictionary:dict.decodedDictionary atIndex:i andPieces:pieces]];
            }
        }
    }
    
    // Single file (trying : 'name' or 'path')
    else {
        NSString * pieces = [TypeHelper stringForKey:kTorrentPiecesDictKey inDictionaryTree:dictionary].decodedValue;
        NSString * path = [TypeHelper stringForKey:kTorrentPathDictKey inDictionaryTree:dictionary].decodedValue;
        
        if (path == nil) {
            path = [TypeHelper stringForKey:kTorrentNameDictKey inDictionaryTree:dictionary].decodedValue;
        }
        
        [fileList addObject:[self fileFromDictionary:dictionary atIndex:0 andPieces:pieces]];
    }
    
    return fileList;
}

#pragma mark - NSDictionary -> File

// NSDictionary -> File
- (File*)fileFromDictionary:(NSDictionary*)dictionary atIndex:(NSInteger)index andPieces:(NSString*)pieces {
    NSString * path = [TypeHelper stringForKey:kTorrentPathDictKey inDictionaryTree:dictionary].decodedValue;
    NSInteger length = [TypeHelper intForKey:kTorrentLengthDictKey inDictionaryTree:dictionary].decodedValue;
    
    // Extract SHA1 (multiple of 20 bytes)
    NSString * hash = [pieces substringWithRange:NSMakeRange(index * kTorrentSHA1Lenght, kTorrentSHA1Lenght)];
    
    // Checksum is optional in the bittorrent specification.
    NSString * checksum = [TypeHelper stringForKey:kTorrentFileMD5ChecksumDictKey inDictionaryTree:dictionary].decodedValue;
    
    return [[File alloc] initWithName:path andLength:length andHash:hash andChecksum:checksum];
}

@end
