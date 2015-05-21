//
//  Type.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Type.h"

@implementation Type

- (instancetype)initWithString:(NSString*)string {
    self = [super init];
    
    if (self) {
        self.rawValue = string;
    }
    
    return self;
}

- (NSString*)removeDecodedValuefromString:(NSString*)string {
    // Removing processed data.
    return [string substringFromIndex:[self decodedValueSize]];
}

- (NSInteger)decodedValueSize {
    return 0;
}

- (NSString*)stringValue {
    return nil;
}

@end
