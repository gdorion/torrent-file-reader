//
//  TorrentDecoder.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TorrentDecoder : NSObject

+ (NSDictionary*)decodeTorrent:(NSString*)filePath;

@end
