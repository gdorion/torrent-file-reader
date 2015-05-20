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

- (NSInteger)rawValueLength {
    return 0;
}

@end
