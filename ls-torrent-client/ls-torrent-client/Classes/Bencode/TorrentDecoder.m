//
//  TorrentDecoder.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentDecoder.h"

#import "TypeDictionary.h"
#import "TypeArray.h"

@interface TorrentDecoder()

@property (nonatomic) NSMutableDictionary * torrentInformations;

@end

@implementation TorrentDecoder

- (NSDictionary*)decodeTorrent:(NSString*)filePath {
    self.torrentInformations = [NSMutableDictionary new];
    
    // Retreive torrent informations.
    NSError * error = [NSError new];
    NSString * fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    [self decodedContentFromString:fileContent];
    
    return self.torrentInformations;
}

#pragma mark - Private methods

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
