//
//  File.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject

@property (nonatomic) NSString * name;
@property (nonatomic) NSUInteger length; // Length is in byte.
@property (nonatomic) NSString * sha1Hash; // 20 characters depending on the index of the file.
@property (nonatomic) NSString * checksum;

- (instancetype)initWithName:(NSString*)name andLength:(NSInteger)length andHash:(NSString*)hash andChecksum:(NSString*)checksum;

@end
