//
//  TypeInteger.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Type.h"

@interface TypeInteger : Type

// Value after decoding. Decoding should be at init time -> "i42e" will be 42.
@property (nonatomic) NSInteger decodedValue;


@end
