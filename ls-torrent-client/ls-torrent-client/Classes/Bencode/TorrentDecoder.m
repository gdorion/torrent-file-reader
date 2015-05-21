//
//  TorrentDecoder.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentDecoder.h"

#import "Type.h"
#import "TypeDictionary.h"
#import "TypeArray.h"
#import "TypeInteger.h"
#import "TypeString.h"

#import "Torrent.h"
#import "File.h"

NSString * kTorrentPathDictKey = @"path";
NSString * kTorrentNameDictKey = @"name";
NSString * kTorrentPiecesDictKey = @"pieces";
NSString * kTorrentLengthDictKey = @"length";
NSString * kTorrentChecksumDictKey = @"checksum";
NSString * kTorrentCreationClientDictKey = @"created by";
NSString * kTorrentCreationDateDictKey = @"creation date";
NSString * kTorrentFilesDictKey = @"files";

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

- (Torrent*)torrentFromDictionary:(NSDictionary*)dictionary {
    NSMutableArray * fileList = [NSMutableArray new];
    
    // Many files in folder
    Type * filesType = [self typeForKey:kTorrentFilesDictKey inDictionaryTree:dictionary];
    if (filesType) {
        if ([filesType isKindOfClass:[TypeArray class]]) {
            TypeArray * filesTypeArray = (TypeArray*)filesType;
            
            // Extracting checksum
            NSString * pieces = [self stringForKey:kTorrentPiecesDictKey inDictionaryTree:dictionary].decodedValue;
            
            for (TypeDictionary * dict in filesTypeArray.decodedArray) {
                NSString * path = [self stringForKey:kTorrentPathDictKey inDictionaryTree:dict.decodedDictionary].decodedValue;
                NSInteger length = [self intForKey:kTorrentPathDictKey inDictionaryTree:dict.decodedDictionary].decodedValue;
                NSString * checksum = [pieces substringWithRange:NSMakeRange(0, kTorrentSHA1Lenght)];
                
                File * newFile = [[File alloc] initWithName:path andLength:length andChecksum:checksum];
                [fileList addObject:newFile];
            }
        }
    }
    
    // Single file
    else {
        NSString * path = [self stringForKey:kTorrentPathDictKey inDictionaryTree:dictionary].decodedValue;
        if (path == nil) {
            // Try name value
            path = [self stringForKey:kTorrentNameDictKey inDictionaryTree:dictionary].decodedValue;
        }
        
        NSInteger length = [self intForKey:kTorrentLengthDictKey inDictionaryTree:dictionary].decodedValue;
        NSString * pieces = [self stringForKey:kTorrentPiecesDictKey inDictionaryTree:dictionary].decodedValue;
        NSString * checksum = [pieces substringWithRange:NSMakeRange(0, kTorrentSHA1Lenght)];
        
        File * newFile = [[File alloc] initWithName:path andLength:length andChecksum:checksum];
        [fileList addObject:newFile];
    }
    
    // Other informations.
    NSInteger creationDate = [self intForKey:kTorrentCreationDateDictKey inDictionaryTree:dictionary].decodedValue;
    NSString * creationClient = [self stringForKey:kTorrentCreationClientDictKey inDictionaryTree:dictionary].decodedValue;
    
    Torrent * newTorrent = [[Torrent alloc] initWithFileList:fileList andCreationClient:creationClient andCreationDate:creationDate];
    return newTorrent;
}

- (TypeString*)stringForKey:(NSString*)key inDictionaryTree:(id)dictionary {
    Type * resultValue = [self typeForKey:key inDictionaryTree:dictionary];
    
    if ([resultValue isKindOfClass:[TypeArray class]]) {
        TypeArray * nestedArray = (TypeArray*)resultValue;
        return [nestedArray.decodedArray firstObject];
    }
    else if ([resultValue isKindOfClass:[TypeArray class]]) {
        TypeDictionary * nestedDictionary = (TypeDictionary*)resultValue;
        resultValue = [self intForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
    }
    else if ([resultValue isKindOfClass:[TypeString class]]) {
        return (TypeString*)resultValue;
    }
    
    return (TypeString*)resultValue;

}
                
- (TypeInteger*)intForKey:(NSString*)key inDictionaryTree:(id)dictionary {
    Type * resultValue = [self typeForKey:key inDictionaryTree:dictionary];
    
    if ([resultValue isKindOfClass:[TypeArray class]]) {
        TypeArray * nestedArray = (TypeArray*)resultValue;
        return [nestedArray.decodedArray firstObject];
    }
    else if ([resultValue isKindOfClass:[TypeArray class]]) {
        TypeDictionary * nestedDictionary = (TypeDictionary*)resultValue;
        resultValue = [self intForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
    }
    else if ([resultValue isKindOfClass:[TypeInteger class]]) {
        return (TypeInteger*)resultValue;
    }
    
    return (TypeInteger*)resultValue;
}


- (Type*)typeForKey:(NSString*)key inDictionaryTree:(id)dictionary {
    Type * resultValue = nil;
    
    for (NSString * dictKey in [dictionary allKeys]) {
        Type * dictValue = [dictionary objectForKey:dictKey];
        
        if ([dictKey isEqualToString:key]) {
            return dictValue;
        }
        else if ([dictValue isKindOfClass:[TypeDictionary class]]) {
            TypeDictionary * nestedDictionary = (TypeDictionary*)dictValue;
            resultValue = [self typeForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
            
            if (resultValue) {
                return resultValue;
            }
        }
        else if ([dictValue isKindOfClass:[TypeArray class]]) {
            TypeArray * nestedArray = (TypeArray*)dictValue;
            
            for (Type * nestedValue in nestedArray.decodedArray) {
                if ([nestedValue isKindOfClass:[TypeDictionary class]]) {
                    TypeDictionary * nestedDictionary = (TypeDictionary*)nestedValue;
                    resultValue = [self typeForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
                    
                    if (resultValue) {
                        return resultValue;
                    }
                }
            }
        }
    }
    
    return nil;
}

#pragma mark - Decoding String to Dictionary

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
    
    // Array
    else if ([firstChar isEqualToString:@"l"]) {
        TypeArray * array = [[TypeArray alloc] initWithString:content];
        newDecodedValue = array;
        [self.torrentInformations setValue:array.decodedArray forKey:@"info"];
    }
    
    // No base structure, create an array
    else {
        // TODO
        TypeArray * array = [[TypeArray alloc] initWithString:content];
        newDecodedValue = array;
        [self.torrentInformations setValue:array.decodedArray forKey:@"info"];
    }
}

@end
