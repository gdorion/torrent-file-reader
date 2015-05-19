//
//  TorrentListViewController.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentListViewController.h"

// Model
#import "TorrentList.h"
#import "Torrent.h"
#import "File.h"

// Views
#import "TorrentCell.h"

@interface TorrentListViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic) NSTableView * tableView;

@end

@implementation TorrentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - NSTableViewDatasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[TorrentList instance] numberOfTorrents];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    TorrentCell *cell = [tableView makeViewWithIdentifier:NSStringFromClass([TorrentCell class]) owner:self];
    if (cell == nil) {
        cell = [[TorrentCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        cell.identifier = NSStringFromClass([TorrentCell class]);
    }
    
    [cell updateWithTorrent:[[TorrentList instance] torrentAtIndex:row]];
    
    return cell;
}


@end
