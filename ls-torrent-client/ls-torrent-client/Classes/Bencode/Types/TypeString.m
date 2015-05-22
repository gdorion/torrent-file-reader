//
//  TypeString.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeString.h"

@interface TypeString()

@property (nonatomic) NSInteger startIndex;

@end

@implementation TypeString

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    
    if (self) {
        // Parsing length
        for (int i = 1; i < string.length; i++) {
            NSString * possibleLength = [string substringToIndex:i];
            
            if ([self stringIsNumeric:possibleLength]) {
                self.startIndex = possibleLength.length;
                self.length = [possibleLength integerValue];
            }
            else {
                break;
            }
        }
        
        // Parsing content value
        if (self.length > 0) {

            // Skip ":" delimiter
            self.startIndex++;
            self.decodedValue = [string substringWithRange:NSMakeRange(self.startIndex, self.length)];
            
            // Rmeove from remaining content.
            self.remainingContent = [string substringFromIndex:[self decodedValueSize]];
        }
    }
    
    return self;
}

- (BOOL)stringIsNumeric:(NSString*)string {
    NSCharacterSet* alphaSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange range = [string rangeOfCharacterFromSet:alphaSet];
    return range.location == NSNotFound;
}

- (NSInteger)decodedValueSize {
    // Length of size + ":" + value size.
    return self.startIndex + self.length;
}

- (NSString*)stringValue {
    return self.decodedValue;
}

@end
