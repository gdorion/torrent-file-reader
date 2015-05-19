//
//  TorrentList.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Torrent;

@interface TorrentList : NSObject

- (void)addTorrent:(NSString*)filepath;
- (void)removeTorrent:(Torrent*)torrent;
- (Torrent*)torrentAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfTorrents;

+ (TorrentList *)instance;

@end
