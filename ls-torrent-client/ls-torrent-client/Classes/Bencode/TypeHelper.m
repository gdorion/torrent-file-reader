//
//  TypeHelper.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-21.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeHelper.h"

#import "Type.h"
#import "TypeString.h"
#import "TypeInteger.h"
#import "TypeDictionary.h"
#import "TypeArray.h"

@implementation TypeHelper

// Recursive search for string types mapped to specified keys
+ (TypeString*)stringForKey:(NSString*)key inDictionaryTree:(id)dictionary {
    Type * resultValue = [TypeHelper typeForKey:key inDictionaryTree:dictionary];
    
    // Nested Array
    if ([resultValue isKindOfClass:[TypeArray class]]) {
        TypeArray * nestedArray = (TypeArray*)resultValue;

        if (nestedArray.decodedArray.count > 1) {
            // Directory structure
            TypeString * folderStructure = [TypeString new];
            folderStructure.decodedValue = [nestedArray.decodedArray componentsJoinedByString:@"/"];
            
            for (TypeString * string in nestedArray.decodedArray) {
                folderStructure.length += string.length;
            }
            
            return folderStructure;
        }
        else {
            return [nestedArray.decodedArray firstObject];
        }
    }
    
    // Nested Dictionary
    else if ([resultValue isKindOfClass:[TypeDictionary class]]) {
        TypeDictionary * nestedDictionary = (TypeDictionary*)resultValue;
        resultValue = [TypeHelper intForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
    }
    
    // Value found !
    else if ([resultValue isKindOfClass:[TypeString class]]) {
        return (TypeString*)resultValue;
    }
    
    return (TypeString*)resultValue;
    
}

// Recursive search for integer types mapped to specified keys
+ (TypeInteger*)intForKey:(NSString*)key inDictionaryTree:(id)dictionary {
    Type * resultValue = [TypeHelper typeForKey:key inDictionaryTree:dictionary];
    
    // Nested Array
    if ([resultValue isKindOfClass:[TypeArray class]]) {
        TypeArray * nestedArray = (TypeArray*)resultValue;
        return [nestedArray.decodedArray firstObject];
    }
    
    // Nested Dictionary
    else if ([resultValue isKindOfClass:[TypeDictionary class]]) {
        TypeDictionary * nestedDictionary = (TypeDictionary*)resultValue;
        resultValue = [TypeHelper intForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
    }
    
    // Value found !
    else if ([resultValue isKindOfClass:[TypeInteger class]]) {
        return (TypeInteger*)resultValue;
    }
    
    return (TypeInteger*)resultValue;
}

// Recursively go down the type object structure.
+ (Type*)typeForKey:(NSString*)key inDictionaryTree:(id)dictionary {
    Type * resultValue = nil;
    
    for (NSString * dictKey in [dictionary allKeys]) {
        Type * dictValue = [dictionary objectForKey:dictKey];
        
        // Found the value !
        if ([dictKey isEqualToString:key]) {
            return dictValue;
        }
        
        // Nested dictionary
        else if ([dictValue isKindOfClass:[TypeDictionary class]]) {
            TypeDictionary * nestedDictionary = (TypeDictionary*)dictValue;
            resultValue = [TypeHelper typeForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
            
            if (resultValue) {
                return resultValue;
            }
        }
        
        // Nested array
        else if ([dictValue isKindOfClass:[TypeArray class]]) {
            TypeArray * nestedArray = (TypeArray*)dictValue;
            
            for (Type * nestedValue in nestedArray.decodedArray) {
                if ([nestedValue isKindOfClass:[TypeDictionary class]]) {
                    TypeDictionary * nestedDictionary = (TypeDictionary*)nestedValue;
                    resultValue = [TypeHelper typeForKey:key inDictionaryTree:nestedDictionary.decodedDictionary];
                    
                    if (resultValue) {
                        return resultValue;
                    }
                }
            }
        }
    }
    
    return nil;
}

@end
