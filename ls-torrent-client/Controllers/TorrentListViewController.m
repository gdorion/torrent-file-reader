//
//  TorrentListViewController.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-20.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentListViewController.h"

// Views
#import "TorrentCell.h"

// Model
#import "TorrentList.h"
#import "Torrent.h"
#import "File.h"

@interface TorrentListViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic) IBOutlet NSTableView * tableView;

@end

@implementation TorrentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
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

#pragma mark - Torrent Actions

- (void)addTorrent {
    NSString * torrentFilePath = [self filePathFromOpenDialog];
    if (torrentFilePath) {
        [[TorrentList instance] addTorrent:torrentFilePath];
        [self.tableView reloadData];
    }
}

- (void)removeTorrent {
    
}

#pragma mark - Dialogs

- (NSString*)filePathFromOpenDialog {
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];
    openDialog.canChooseFiles = YES;
    openDialog.canChooseDirectories = NO;
    openDialog.allowsMultipleSelection = NO;
    openDialog.allowedFileTypes = @[@"torrent"];

    if ([openDialog runModal] == NSModalResponseOK) {
        NSLog(@"%@", [openDialog.URLs firstObject]);
        return [openDialog.URLs firstObject];
    }
    
    return nil;
}

@end
