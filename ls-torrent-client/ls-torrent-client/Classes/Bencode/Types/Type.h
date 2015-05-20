//
//  Type.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Type : NSObject

// Value before decoding.
@property (nonatomic) NSString * rawValue;

- (instancetype)initWithString:(NSString*)string;

- (NSInteger)rawValueLength;

@end
