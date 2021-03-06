//
//  TorrentCell.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class File;

@interface TorrentFileCell : NSTableCellView

- (void)updateWithFile:(File *)file;

@end
