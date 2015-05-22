//
//  TorrentDecoder.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Torrent;

// The decoder class use a tree structure composed of string, int, array and dictionary
// to rebuild the bencode content of a torrent file.
// The parsing algorithm was based on the specification located here :
// Ref.: http://www.bittorrent.org/beps/bep_0003.html

@interface TorrentDecoder : NSObject

- (Torrent*)decodeTorrent:(NSString*)filePath;

@end
