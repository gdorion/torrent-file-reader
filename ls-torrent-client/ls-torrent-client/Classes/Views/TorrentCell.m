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
    NSString * unknownStringValue = @"Unknown";
    
    NSString * name = file.name ? file.name : unknownStringValue;
    [self.nameTextField setStringValue:name];
    
    // Conversion from bytes to megabytes.
    NSString * length = file.length > 0 ? [NSString stringWithFormat:@"%.4f", (double)file.length / 1000000] : unknownStringValue;
    [self.lengthTextField setStringValue:[NSString stringWithFormat:@"%@ MB", length]];
    
    NSString * checksum = file.checksum  ? file.checksum : unknownStringValue;
    [self.checksumTextField setStringValue:checksum];
}

@end
