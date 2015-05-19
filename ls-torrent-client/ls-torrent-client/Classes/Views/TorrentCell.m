//
//  TorrentCell.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentCell.h"

// Models
#import "Torrent.h"
#import "File.h"

@interface TorrentCell()

@property (weak) IBOutlet NSTextField * nameTextField;
@property (weak) IBOutlet NSTextField * lengthTextField;
@property (weak) IBOutlet NSTextField * checksumTextField;
@property (weak) IBOutlet NSTextField * creationClientTextField;
@property (weak) IBOutlet NSTextField * creationDateTextField;
@property (weak) IBOutlet NSTextField * filePathTextField;

@end

@implementation TorrentCell

- (void)updateWithTorrent:(Torrent *)torrent {
    [self.nameTextField setStringValue:torrent.file.name];
//    [self.nameTextField setStringValue:torrent.file.length];
    [self.nameTextField setStringValue:torrent.file.checksum];
    [self.nameTextField setStringValue:torrent.creationClient];
//    [self.nameTextField setStringValue:torrent.creationDate];
}

@end
