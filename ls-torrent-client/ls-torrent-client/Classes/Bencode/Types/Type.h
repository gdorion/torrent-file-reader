//
//  Type.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>


// Each type is contains data extract from the original torrent file.
// Each sub part of the file is represent by a subclass of Type.
@interface Type : NSObject

// Contains the remains of the un processed content in the .torrent file.
@property (nonatomic) NSString * remainingContent;

- (instancetype)initWithString:(NSString*)remainingContent;

// Represents the size of the processed data for an iteration.
- (NSInteger)decodedValueSize;

// String representation
- (NSString*)stringValue;

@end
