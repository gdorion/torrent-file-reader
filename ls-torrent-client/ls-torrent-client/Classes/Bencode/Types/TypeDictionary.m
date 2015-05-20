//
//  TypeDictionary.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

// Types
#import "TypeDictionary.h"
#import "TypeString.h"
#import "TypeInteger.h"

// Factory
#import "TypeFactory.h"

@implementation TypeDictionary

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    
    if (self) {
        self.decodedDictionary = [NSMutableDictionary new];
        
        // Removing the 'd' delimiter for dictionary.
        self.rawValue = [self.rawValue substringWithRange:NSMakeRange(1, self.rawValue.length - 1)];
        
        while (self.rawValue.length > 0) {
            
            if ([[self.rawValue substringToIndex:1] isEqualToString:@"e"]) {
                break;
            }
            
            // Key
            TypeString * newKey = [[TypeString alloc] initWithString:self.rawValue];
            self.rawValue = [newKey removeDecodedValuefromString:self.rawValue];
            
            // Value
            NSString * firstChar = [self.rawValue substringWithRange:NSMakeRange(0, 1)];
            Type * newValue = [TypeFactory typeFromTypeIdentifier:firstChar andString:self.rawValue];
            self.rawValue = [newValue removeDecodedValuefromString:self.rawValue];
            
            // Save 
            [self.decodedDictionary setValue:newValue forKey:newKey.decodedValue];
        }
        
        self.rawValue = [self removeDecodedValuefromString:string];
    }
    
    return self;
}

- (NSInteger)rawValueLength {
    NSInteger totalLength = 2; // "d" + values.length + "e"
    
    for (NSString * key in [self.decodedDictionary allKeys]) {
        Type * type = [self.decodedDictionary objectForKey:key];
        
        if (type) {
            totalLength += [type rawValueLength];
        }
    }
    
    return totalLength + 1;
}

@end
