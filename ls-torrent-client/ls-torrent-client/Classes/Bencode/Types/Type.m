//
//  Type.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Type.h"

@implementation Type

- (instancetype)initWithString:(NSString*)remainingContent {
    self = [super init];
    
    if (self) {
        self.remainingContent = remainingContent;
    }
    
    return self;
}

- (NSInteger)decodedValueSize {
    return 0;
}

- (NSString*)stringValue {
    return nil;
}

@end
