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

@end

@implementation TorrentCell

- (void)updateWithFile:(File *)file {
    NSString * unknownStringValue = @"unknown";
    
    NSString * name = file.name ? file.name : unknownStringValue;
    [self.nameTextField setStringValue:name];
    
    NSString * length = file.length > 0 ? [NSString stringWithFormat:@"%ld", file.length] : unknownStringValue;
    [self.lengthTextField setStringValue:length];
    
    NSString * checksum = file.checksum  ? file.checksum : unknownStringValue;
    [self.checksumTextField setStringValue:checksum];
}

@end
