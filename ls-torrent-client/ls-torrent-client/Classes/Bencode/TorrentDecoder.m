//
//  TorrentDecoder.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentDecoder.h"

@interface TorrentDecoder()

@property (nonatomic) NSMutableDictionary * torrentInformations;

@end

@implementation TorrentDecoder

- (NSDictionary*)decodeTorrent:(NSString*)filePath {
    self.torrentInformations = [NSMutableDictionary new];
    
    // Retreive torrent informations.
    NSString * fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self delimiterContentFromString:fileContent];
    
    return self.torrentInformations;
}

#pragma mark - Private methods

- (NSDictionary*)delimiterContentFromString:(NSString*)string {
    NSString * delimiterContent = [string copy];

    // Decoding loop.
    while (delimiterContent.length > 0) {
        NSString * firstChar = [delimiterContent substringWithRange:NSMakeRange(0, 1)];
        delimiterContent = [delimiterContent substringWithRange:NSMakeRange(1, delimiterContent.length - 1)];
        
        switch ([firstChar characterAtIndex:0]) {
            case 100: // ASCII : d
                [self dictionaryFromString:delimiterContent];
                break;

            case 105: // ASCII : i
                [self integerFromString:delimiterContent];
                break;
                
            case 108: // ASCII : l
                [self arrayFromString:delimiterContent];
                break;
                
            default: // Byte string
                [self stringFromByteString:delimiterContent];
                break;
        }
    }
    
    return nil;
}

- (NSDictionary*)dictionaryFromString:(NSString*)string {
    
    NSString * firstChar = [delimiterContent substringWithRange:NSMakeRange(0, 1)];
    
    switch ([firstChar characterAtIndex:0]) {
        case 100: // ASCII : d
            [self dictionaryFromString:delimiterContent];
            break;
            
        case 105: // ASCII : i
            [self integerFromString:delimiterContent];
            break;
            
        case 108: // ASCII : l
            [self arrayFromString:delimiterContent];
            break;
            
        default: // Byte string
            [self stringFromByteString:delimiterContent];
            break;
    }

    return nil;
}

- (NSArray*)arrayFromString:(NSString*)string {
    return nil;
}

- (NSInteger)integerFromString:(NSString*)string {
    return 0;
}

- (NSString*)stringFromByteString:(NSString*)string {
    NSInteger length = 0;
    NSString * content = nil;
    
    NSArray * components = [string componentsSeparatedByString:@":"];
    
    // String length
    if (components.count > 0) {
        length = [[components firstObject] integerValue];
    }
    
    if (components.count > 1) {
        content = [components objectAtIndex:1];
        content = [content substringWithRange:NSMakeRange(0, length)];
    }
}

@end
