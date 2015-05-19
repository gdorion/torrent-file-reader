//
//  Torrent.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class File;

@interface Torrent : NSObject

@property (nonatomic) File * file;
@property (nonatomic) NSString * creationClient;
@property (nonatomic) NSDate * creationDate;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
