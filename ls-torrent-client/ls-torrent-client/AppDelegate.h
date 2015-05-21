//
//  AppDelegate.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "TorrentListViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic,strong) IBOutlet TorrentListViewController *torrentListViewController;

@end

