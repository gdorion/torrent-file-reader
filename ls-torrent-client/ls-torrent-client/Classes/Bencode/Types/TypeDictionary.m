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
        
        // Removing 'd'
        self.remainingContent = [self.remainingContent substringWithRange:NSMakeRange(1, self.remainingContent.length - 1)];
        
        while (self.remainingContent.length > 0) {
            
            // End delimiter reached.
            if ([[self.remainingContent substringToIndex:1] isEqualToString:@"e"]) {
                break;
            }
            
            // Key
            TypeString * newKey = [[TypeString alloc] initWithString:self.remainingContent];
            self.remainingContent = newKey.remainingContent;
            
            // Value
            NSString * firstChar = [self.remainingContent substringWithRange:NSMakeRange(0, 1)];
            Type * newValue = [TypeFactory typeFromTypeIdentifier:firstChar andString:self.remainingContent];
            self.remainingContent = newValue.remainingContent;
            
            // Save
            if (newKey.decodedValue) {
                [self.decodedDictionary setValue:newValue forKey:newKey.decodedValue];
            }
            else {
                break;
            }
        }
        
        // removing 'e' end delimiter
        self.remainingContent = [self.remainingContent substringWithRange:NSMakeRange(1, self.remainingContent.length - 1)];
    }
    
    return self;
}

@end
