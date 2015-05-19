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
@property (nonatomic) NSUInteger length;
@property (nonatomic) NSString * checksum;

- (instancetype)initWithName:(NSString*)name andLength:(NSString*)length andChecksum:(NSString*)checksum;

@end
