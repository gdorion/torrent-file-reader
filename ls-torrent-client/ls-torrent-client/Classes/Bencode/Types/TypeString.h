//
//  TypeString.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Type.h"

@interface TypeString : Type

// Decoded string size - > "8:announce", represents 8.
@property (nonatomic) NSInteger length;

// Value after decoding. Decoding should be at init time.
@property (nonatomic) NSString * decodedValue;

@end
