//
//  TypeFactory.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-20.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Type;

@interface TypeFactory : NSObject

+ (Type*)typeFromTypeIdentifier:(NSString*)identifier andString:(NSString*)string;

@end
