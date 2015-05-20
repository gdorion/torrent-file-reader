//
//  TypeFactory.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-20.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeFactory.h"

// Types
#import "TypeDictionary.h"
#import "TypeArray.h"
#import "TypeInteger.h"
#import "TypeString.h"

@implementation TypeFactory

+ (Type*)typeFromTypeIdentifier:(NSString*)identifier andString:(NSString*)string {
    if ([identifier isEqualToString:@"d"]) {
        return [[TypeDictionary alloc] initWithString:string];
    }
    else if ([identifier isEqualToString:@"l"]) {
        return [[TypeArray alloc] initWithString:string];
    }
    else if ([identifier isEqualToString:@"i"]) {
        return [[TypeInteger alloc] initWithString:string];
    }
    else  {
        return [[TypeString alloc] initWithString:string];
    }
    
    return nil;
}

@end
