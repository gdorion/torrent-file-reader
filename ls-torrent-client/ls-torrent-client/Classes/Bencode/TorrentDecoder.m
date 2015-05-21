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

#import "Torrent.h"
#import "File.h"


NSString * kTorrentNameDictKey = @"name";
NSString * kTorrentLengthDictKey = @"length";
NSString * kTorrentChecksumDictKey = @"checksum";
NSString * kTorrentCreationClientDictKey = @"created by";
NSString * kTorrentCreationDateDictKey = @"creation date";
NSString * kTorrentFilesDictKey = @"files";

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
    NSString * creationDate = [self stringForKey:kTorrentCreationDateDictKey inDictionaryTree:dictionary];
    NSString * creationClient = [self stringForKey:kTorrentCreationClientDictKey inDictionaryTree:dictionary];
    
    NSDictionary * files = [self typeForKey:kTorrentFilesDictKey inDictionaryTree:dictionary];
    
//    NSString * name   = [self valueForKey:kTorrentNameDictKey inDictionaryTree:dictionary];
//    NSString * length = [self valueForKey:kTorrentLengthDictKey inDictionaryTree:dictionary];
//    NSString * checksum = [self valueForKey:kTorrentChecksumDictKey inDictionaryTree:dictionary];
    
    Torrent * newTorrent = [[Torrent alloc] initWithFileList:@[] andCreationClient:creationClient andCreationDate:creationDate];
    return newTorrent;
}

#pragma mark - Dictionary to Torrent Objects

- (NSString*)stringForKey:(NSString*)key inDictionaryTree:(NSDictionary*)dictionary {
    NSString * resultValue = nil;
    
    for (NSString * dictKey in [dictionary allKeys]) {
        Type * dictValue = [dictionary objectForKey:dictKey];
        
        if ([dictKey isEqualToString:key]) {
            return [dictValue stringValue];
        }
        else if ([dictValue isKindOfClass:[TypeDictionary class]]) {
            TypeDictionary * nestedDictionary = (TypeDictionary*)dictValue;
            resultValue = [self stringForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
            
            if (resultValue.length > 0) {
                return resultValue;
            }
        }
        else if ([dictValue isKindOfClass:[TypeArray class]]) {
            TypeArray * nestedArray = (TypeArray*)dictValue;
            
            for (Type * nestedValue in nestedArray.decodedArray) {
                if ([nestedValue isKindOfClass:[TypeDictionary class]]) {
                    TypeDictionary * nestedDictionary = (TypeDictionary*)dictValue;
                    resultValue = [self stringForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
                    
                    if (resultValue.length > 0) {
                        return resultValue;
                    }
                }
            }
        }
    }
    
    return nil;
}

- (Type*)typeForKey:(NSString*)key inDictionaryTree:(NSDictionary*)dictionary {
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
                    TypeDictionary * nestedDictionary = (TypeDictionary*)dictValue;
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
        [self.torrentInformations setValue:dictionary.decodedDictionary forKey:@"info"];
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
