//
//  AppDelegate.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "AppDelegate.h"

// Model
#import "TorrentModel.h"

// Controller
#import "TorrentViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) IBOutlet NSButton * addTorrentButton;

@property (nonatomic) TorrentViewController *torrentViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [TorrentModel instance];
    [self loadView];
}

- (void)loadView {
    self.torrentViewController = [[TorrentViewController alloc] initWithNibName:NSStringFromClass([TorrentViewController class]) bundle:nil];
    [self.window.contentView addSubview:self.torrentViewController.view];
    self.torrentViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

#pragma mark - NSToolbarItem Actions

- (IBAction)addTorrent:(id)sender {
    [self.torrentViewController addTorrent];
}

@end
