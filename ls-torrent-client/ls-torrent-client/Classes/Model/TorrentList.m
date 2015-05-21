//
//  TorrentList.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentList.h"

// Models
#import "Torrent.h"

// Helpers
#import "TorrentDecoder.h"

@interface TorrentList()

@property (nonatomic) NSMutableArray * torrentList;
@property (nonatomic) TorrentDecoder * decoder;

@end

@implementation TorrentList

- (id)init {
    self = [super init];
    if (self) {
        self.torrentList = [NSMutableArray new];
        self.decoder = [TorrentDecoder new];
    }
    
    return self;
}

- (void)addTorrent:(NSString*)filepath {
    if (filepath) {
        NSDictionary * torrentElements = [self.decoder decodeTorrent:filepath];
        Torrent * newTorrent = [[Torrent alloc] initWithDictionary:torrentElements];
        
        [self.torrentList addObject:newTorrent];
    }
}

- (void)removeTorrent:(Torrent*)torrent {
    if (torrent) {
        [self.torrentList removeObject:torrent];
    }
}

- (Torrent*)torrentAtIndex:(NSUInteger)index {
    if (index < self.torrentList.count) {
        return [self.torrentList objectAtIndex:index];
    }
    
    return nil;
}

- (NSUInteger)numberOfTorrents {
    return self.torrentList.count;
}

#pragma mark - Singleton accessor

+ (TorrentList *)instance {
    static TorrentList * _instance = nil;
    
    @synchronized (self) {
        if (_instance == nil)
            _instance = [[self alloc] init];
    }
    
    return _instance;
}

@end
