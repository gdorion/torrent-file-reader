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
    
    // Displaying checksum in raw string.
    NSString * checksum = file.checksum  ? [self readableChecksumWithString:file.checksum] : unknownStringValue;
    [self.checksumTextField setStringValue:checksum];
}

- (NSString *)readableChecksumWithString:(NSString*)checksum {
    const char * utf8 = [checksum UTF8String];
    NSMutableString *hex = [NSMutableString string];
    while ( *utf8 ) [hex appendFormat:@"%02X" , *utf8++ & 0x00FF];
    return hex;
}

@end
