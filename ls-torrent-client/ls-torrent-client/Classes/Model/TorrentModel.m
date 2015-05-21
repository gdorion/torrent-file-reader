//
//  TorrentList.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentModel.h"

// Models
#import "Torrent.h"

// Helpers
#import "TorrentDecoder.h"

@interface TorrentModel()

@property (nonatomic) TorrentDecoder * decoder;

@end

@implementation TorrentModel

- (id)init {
    self = [super init];
    if (self) {
        self.torrent = nil;
        self.decoder = [TorrentDecoder new];
    }
    
    return self;
}

- (void)addTorrent:(NSString*)filepath {
    if (filepath) {
        self.torrent = [self.decoder decodeTorrent:filepath];
    }
}

- (NSUInteger)numberOfFiles {
    return self.torrent.fileList.count;
}

#pragma mark - Singleton accessor

+ (TorrentModel *)instance {
    static TorrentModel * _instance = nil;
    
    @synchronized (self) {
        if (_instance == nil)
            _instance = [[self alloc] init];
    }
    
    return _instance;
}

@end
