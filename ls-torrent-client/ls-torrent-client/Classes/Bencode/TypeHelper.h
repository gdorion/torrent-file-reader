//
//  TypeHelper.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-21.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TypeString, Type, TypeInteger;

@interface TypeHelper : NSObject

// Methods : Find a value from given key for (recursively) :
// Dictionary params takes :
//   - TypeArray
//   - TypeDictionary
//   - NSDictionary

+ (TypeString*)stringForKey:(NSString*)key inDictionaryTree:(id)dictionary;
+ (TypeInteger*)intForKey:(NSString*)key inDictionaryTree:(id)dictionary;
+ (Type*)typeForKey:(NSString*)key inDictionaryTree:(id)dictionary;

@end
