//
//  TypeInteger.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeInteger.h"

@implementation TypeInteger

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    
    if (self) {
        // Ie : Parsing i42e      i : integer       42 : Actual desired value      e : end delimiter
        //
        NSString * intDelimiter = [string substringWithRange:NSMakeRange(0, 1)];

        if ([intDelimiter isEqualToString:@"i"]) {
            NSString * content = [string substringWithRange:NSMakeRange(1, string.length - 1)];
            
            for(int i = 0; i < content.length; i++) {
                if ([[content substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"e"]) {
                    // End delimiter was hit. Desired content found.

                    if (i > 0) {
                        // Discarding empty integer.
                        content = [content substringWithRange:NSMakeRange(0, i - 1)];
                        self.decodedValue = [content integerValue];
                    }
                    
                    break;
                }
            }
        }
    }
    
    return self;
}


@end
