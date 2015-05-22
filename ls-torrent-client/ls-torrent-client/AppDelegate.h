//
//  AppDelegate.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TorrentListViewController;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic) IBOutlet TorrentListViewController *torrentListViewController;

@end

