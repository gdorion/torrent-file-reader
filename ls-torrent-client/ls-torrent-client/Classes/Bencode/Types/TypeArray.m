//
//  TypeArray.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeArray.h"
#import "Type.h"
#import "TypeInteger.h"
#import "TypeString.h"

@implementation TypeArray

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    
    if (self) {
        self.decodedArray = [NSMutableArray new];
        NSString * firstChar = [string substringWithRange:NSMakeRange(0, 1)];
        
        if ([firstChar isEqualToString:@"l"]) {
            
            // The raw value contains the remaining unparse data as the algorithm process it.
            self.rawValue = [self.rawValue substringWithRange:NSMakeRange(1, self.rawValue.length - 1)];
            
            // Array Decoding loop.
            while (self.rawValue.length > 0) {
                Type * newType = nil;
                
                NSString * firstChar = [self.rawValue substringWithRange:NSMakeRange(0, 1)];
                switch ([firstChar characterAtIndex:0]) {
                    case 105: // ASCII : i
                        newType = [[TypeInteger alloc] initWithString:self.rawValue];
                        break;
                        
                    default: // Byte string
                        newType = [[TypeString alloc] initWithString:self.rawValue];
                        break;
                }
                
                [self.decodedArray addObject:newType];
                
                // Removing processed data.
                [self.rawValue substringWithRange:NSMakeRange(0, [newType rawValueLength])];
            }
        }
    }
    
    return self;
}

- (NSInteger)rawValueLength {
    NSInteger totalLength = 0;
    
    for (Type * type in self.decodedArray) {
        totalLength += [type rawValueLength];
    }
    
    return totalLength;
}

@end
