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
        NSString * integerString = [string substringWithRange:NSMakeRange(1, string.length - 1)];
        
        for(int i = 1; i < integerString.length; i++) {
            if ([[integerString substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"e"]) {
                // End delimiter was hit. Desired content found.

                if (i > 0) { // Discarding empty integer.
                    NSString * decodedString = [string substringWithRange:NSMakeRange(1, i)];
                    
                    NSDecimalNumber * result = [NSDecimalNumber decimalNumberWithString:decodedString];
                    self.decodedValue = [result integerValue];
                    
                    self.remainingContent = [string substringFromIndex:[self decodedValueSize]];
                }
                
                break;
            }
        }
    }
    
    return self;
}

- (NSInteger)decodedValueSize {
    // Value length + "i" + "e"
    return [self stringValue].length + 2;
}

- (NSString*)stringValue {
    return [NSString stringWithFormat:@"%ld", self.decodedValue];
}

@end
