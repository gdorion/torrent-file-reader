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
            self.rawValue = [string substringWithRange:NSMakeRange(1, string.length - 1)];
            
            for(int i = 1; i < self.rawValue.length; i++) {
                if ([[self.rawValue substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"e"]) {
                    // End delimiter was hit. Desired content found.

                    if (i > 0) {
                        // Discarding empty integer.
                        self.rawValue = [self.rawValue substringWithRange:NSMakeRange(0, i)];
                        self.decodedValue = [self.rawValue integerValue];
                    }
                    
                    break;
                }
            }
        }
    }
    
    return self;
}

- (NSInteger)rawValueLength {
    return self.rawValue.length + 2; // i42e -> 1 + 2 + 1;
}


@end
