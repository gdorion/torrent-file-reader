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
#import "TorrentModel.h"
#import "Torrent.h"
#import "File.h"

@interface TorrentListViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic) IBOutlet NSTableView * tableView;
@property (nonatomic) IBOutlet NSTextField * creationDateLabel;
@property (nonatomic) IBOutlet NSTextField * creationClientLabel;

@end

@implementation TorrentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

#pragma mark - NSTableViewDatasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[TorrentModel instance] numberOfFiles];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    TorrentCell *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    File * file = [[[TorrentModel instance] torrent].fileList objectAtIndex:row];
    [cell updateWithFile:file];
    
    return cell;
}

#pragma mark - Torrent Actions

- (void)addTorrent {
    NSString * torrentFilePath = [self filePathFromOpenDialog];
    if (torrentFilePath) {
        [[TorrentModel instance] addTorrent:torrentFilePath];
        
        // File list
        [self.tableView reloadData];
        
        // Date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:[[TorrentModel instance] torrent].creationDate];
        [self.creationDateLabel setStringValue:stringDate];
        
        // Created by
        NSString * client = [[TorrentModel instance] torrent].creationClient;
        if (client) {
            [self.creationClientLabel setStringValue:client];
        }
    }
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
