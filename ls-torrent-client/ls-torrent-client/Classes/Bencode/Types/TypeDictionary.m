//
//  TypeDictionary.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeDictionary.h"
#import "TypeString.h"
#import "TypeInteger.h"

@implementation TypeDictionary

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    
    if (self) {
        self.decodedDictionary = [NSMutableDictionary new];
        NSString * firstChar = [string substringWithRange:NSMakeRange(0, 1)];
        
        if ([firstChar isEqualToString:@"d"]) {
            
            // Removing the 'd' delimiter for dictionary.
            self.rawValue = [self.rawValue substringWithRange:NSMakeRange(1, self.rawValue.length - 1)];
            
            // Dictionary Decoding loop.
            while (self.rawValue.length > 0) {
                
                // Key processing
                TypeString * newKey = [[TypeString alloc] initWithString:self.rawValue];
                self.rawValue = [self.rawValue substringFromIndex:[newKey rawValueLength] - 1];
                
                // Value processing
                Type * newValue = nil;
                NSString * firstChar = [self.rawValue substringWithRange:NSMakeRange(0, 1)];
                
                // Dictionary
                if ([firstChar isEqualToString:@"i"]) {
                    newValue = [[TypeInteger alloc] initWithString:self.rawValue];
                }
                else {
                    newValue = [[TypeString alloc] initWithString:self.rawValue];
                }
                
                [self.decodedDictionary setValue:newValue forKey:newKey.decodedValue];
                
                // Removing processed data.
                self.rawValue = [self.rawValue substringFromIndex:[newValue rawValueLength]];
            }
        }
    }
    
    return self;
}

- (NSInteger)rawValueLength {
    NSInteger totalLength = 0;
    
    for (NSString * key in [self.decodedDictionary allKeys]) {
        Type * type = [self.decodedDictionary objectForKey:key];
        
        if (type) {
            totalLength += [type rawValueLength];
        }
    }
    
    return totalLength;
}

@end
