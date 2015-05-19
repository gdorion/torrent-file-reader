//
//  TorrentCell.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Torrent;

@interface TorrentCell : NSTableCellView

- (void)updateWithTorrent:(Torrent*)torrent;

@end
