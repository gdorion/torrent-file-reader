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

// Build a type object from a torrent file string.
// Parse the type : int, string, list or dictionary and build the object with the string content.
+ (Type*)typeFromTypeIdentifier:(NSString*)identifier andString:(NSString*)string;

@end
