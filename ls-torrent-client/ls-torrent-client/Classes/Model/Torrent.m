//
//  Torrent.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Torrent.h"
#import "File.h"

const NSString * kTorrentNameDictKey = @"name";
const NSString * kTorrentLengthDictKey = @"length";
const NSString * kTorrentChecksumDictKey = @"checksum";
const NSString * kTorrentCreationClientDictKey = @"creationclient";
const NSString * kTorrentCreationDateDictKey = @"creationdate";

@implementation Torrent

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    if (self) {
//        NSDictionary * info = [dictionary objectForKey:@"info"];
        self.creationClient = @"todo creation client";
        self.creationDate = [NSDate date];
        self.file = [[File alloc] initWithName:@"name" andLength:@"123" andChecksum:@"checksum"];
    }
    
    return self;
}

@end
