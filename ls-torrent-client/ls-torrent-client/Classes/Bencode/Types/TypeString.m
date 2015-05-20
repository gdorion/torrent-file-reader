//
//  TypeString.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeString.h"

@interface TypeString()

@property (nonatomic) NSInteger rawValueSize;

@end

@implementation TypeString

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    if (self) {
        // Ie : Parsing 8:announce      8 : length       annonce : Actual desired value
        //
        
        // Parsing length
        for (int i = 1; i < string.length; i++) {
            NSString * possibleLength = [string substringToIndex:i];
            if ([self stringIsNumeric:possibleLength] == NO) {
                self.rawValueSize = possibleLength.length;
                self.length = [possibleLength integerValue];
                self.decodedValue = [possibleLength substringToIndex:i - 1]; // - 1 : Remove the non numeric character that stopped the loop.
                break;
            }
        }
        
        // Parsing content value
        if (self.length > 0) {
            self.decodedValue = [string substringWithRange:NSMakeRange(self.rawValueSize, self.length)];
            self.rawValueSize += self.decodedValue.length;
        }
    }
    
    return self;
}

- (BOOL)stringIsNumeric:(NSString*)string {
    NSCharacterSet* alphaSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange range = [string rangeOfCharacterFromSet:alphaSet];
    return range.location == NSNotFound;
}

- (NSInteger)rawValueLength {
    return self.rawValueSize + 1; // + 1 -> ":"
}

@end
