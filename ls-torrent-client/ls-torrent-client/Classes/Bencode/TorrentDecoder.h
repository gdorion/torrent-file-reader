//
//  TorrentDecoder.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Torrent;

@interface TorrentDecoder : NSObject

- (Torrent*)decodeTorrent:(NSString*)filePath;

@end
