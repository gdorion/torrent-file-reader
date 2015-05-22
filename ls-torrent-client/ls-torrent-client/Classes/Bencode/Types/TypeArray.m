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
        self.remainingContent = [self.remainingContent substringWithRange:NSMakeRange(1, self.remainingContent.length - 1)];
        
        // Array Decoding loop.
        while (self.remainingContent.length > 0) {
            if ([[self.remainingContent substringToIndex:1] isEqualToString:@"e"]) {
                break;
            }
            
            // Value
            NSString * firstChar = [self.remainingContent substringWithRange:NSMakeRange(0, 1)];
            Type * newValue = [TypeFactory typeFromTypeIdentifier:firstChar andString:self.remainingContent];
            self.remainingContent = newValue.remainingContent;

            [self.decodedArray addObject:newValue];
        }
        
        // Remove 'e' end delimiter
        self.remainingContent = [self.remainingContent substringWithRange:NSMakeRange(1, self.remainingContent.length - 1)];
    }
    
    return self;
}

@end
