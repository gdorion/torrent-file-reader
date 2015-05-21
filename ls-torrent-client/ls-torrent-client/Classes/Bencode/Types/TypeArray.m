//
//  TypeArray.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

// Types
#import "TypeArray.h"
#import "Type.h"
#import "TypeInteger.h"
#import "TypeString.h"

// Factory
#import "TypeFactory.h"

@implementation TypeArray

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    
    if (self) {
        self.decodedArray = [NSMutableArray new];
    
        // Removing the 'l' delimiter for dictionary.
        self.rawValue = [self.rawValue substringWithRange:NSMakeRange(1, self.rawValue.length - 1)];
        
        // Array Decoding loop.
        while (self.rawValue.length > 0) {
            if ([[self.rawValue substringToIndex:1] isEqualToString:@"e"]) {
                break;
            }
            
            // Value
            NSString * firstChar = [self.rawValue substringWithRange:NSMakeRange(0, 1)];
            Type * newValue = [TypeFactory typeFromTypeIdentifier:firstChar andString:self.rawValue];
            self.rawValue = [newValue removeDecodedValuefromString:self.rawValue];

            [self.decodedArray addObject:newValue];
        }
        
        // Remove 'e' end delimiter
        self.rawValue = [self removeDecodedValuefromString:string];
    }
    
    return self;
}

- (NSInteger)rawValueLength {
    NSInteger totalLength = 2; // 'l' + 'e".
    
    for (Type * type in self.decodedArray) {
        totalLength += [type rawValueLength];
    }
    
    return totalLength;

}


@end
