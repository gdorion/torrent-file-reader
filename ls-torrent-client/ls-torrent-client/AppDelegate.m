//
//  AppDelegate.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "AppDelegate.h"

// Model
#import "TorrentList.h"

// Controller
#import "TorrentListViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic) TorrentListViewController * torrentListController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Prepare models.
    [TorrentList instance];
    
   // [self loadViews];
}

- (void)loadViews {
    self.torrentListController = [[TorrentListViewController alloc] initWithNibName:@"TorrentListView" bundle:nil];
    [self.window.contentView addSubview:self.torrentListController.view];
}

@end
