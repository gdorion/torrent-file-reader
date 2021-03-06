//
//  TorrentList.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Torrent;

@interface TorrentModel : NSObject

@property (nonatomic) Torrent * torrent;

- (void)addTorrent:(NSString*)filepath;
- (NSUInteger)numberOfFiles;

+ (TorrentModel *)instance;

@end
