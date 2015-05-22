//
//  TypeArray.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Type.h"

@interface TypeArray : Type

// Contains any other type of Type objects.
@property (nonatomic) NSMutableArray * decodedArray;

@end
