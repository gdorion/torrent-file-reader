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

@property (nonatomic) IBOutlet NSButton * addTorrentButton;
@property (nonatomic) IBOutlet NSButton * removeTorrentButton;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Prepare models.
    [TorrentList instance];
    
    [self loadViews];
}

- (void)loadViews {
    self.torrentListViewController = [[TorrentListViewController alloc] initWithNibName:@"TorrentListViewController" bundle:nil];
    [self.window.contentView addSubview:self.torrentListViewController.view];
    self.torrentListViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

#pragma mark - NSToolbarItem Actions

- (IBAction)addTorrent:(id)sender {
    [self.torrentListViewController addTorrent];
}

- (IBAction)removeTorrent:(id)sender {
    [self.torrentListViewController removeTorrent];
}

@end
