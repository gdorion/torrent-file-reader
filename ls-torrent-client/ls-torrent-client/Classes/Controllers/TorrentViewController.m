//
//  TorrentViewController.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-20.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TorrentViewController.h"

// Views
#import "TorrentFileCell.h"

// Model
#import "TorrentModel.h"
#import "Torrent.h"
#import "File.h"

@interface TorrentViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, weak) IBOutlet NSTableView * tableView;
@property (nonatomic, weak) IBOutlet NSTextField * creationDateLabel;
@property (nonatomic, weak) IBOutlet NSTextField * creationClientLabel;
@property (nonatomic, weak) IBOutlet NSTextField * announceClientLabel;
@property (nonatomic, weak) IBOutlet NSTextField * fileNameClientLabel;

@end

@implementation TorrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - NSTableViewDatasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[TorrentModel instance] numberOfFiles];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    TorrentFileCell *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    File * file = [[[TorrentModel instance] torrent].fileList objectAtIndex:row];
    [cell updateWithFile:file];
    
    return cell;
}

#pragma mark - Torrent Actions

- (void)addTorrent {
    [self reset];
    
    NSString * torrentFilePath = [self filePathFromOpenDialog];
    if (torrentFilePath) {
        [[TorrentModel instance] addTorrent:torrentFilePath];
        
        // File name
        [self.fileNameClientLabel setStringValue:torrentFilePath];
        
        // File list
        [self.tableView reloadData];
        
        // Date
        [self.creationDateLabel setStringValue:[self formattedDateString]];
        
        // Tracker (announce)
        NSString * announce = [[TorrentModel instance] torrent].announce;
        if (announce == nil && [announce isKindOfClass:[NSString class]] == NO) {
            announce = @"Unknown";
        }
        
        [self.announceClientLabel setStringValue:announce];
        
        // Created by
        NSString * client = [[TorrentModel instance] torrent].creationClient;
        if (client) {
            [self.creationClientLabel setStringValue:client];
        }
    }
}

#pragma mark - Open Dialogs

- (NSString*)filePathFromOpenDialog {
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];
    openDialog.canChooseFiles = YES;
    openDialog.canChooseDirectories = NO;
    openDialog.allowsMultipleSelection = NO;
    openDialog.allowedFileTypes = @[@"torrent"];

    if ([openDialog runModal] == NSModalResponseOK) {
        return (NSString*)[openDialog.URLs firstObject];
    }
    
    return nil;
}

- (void)reset {
    [self.creationDateLabel setStringValue:@"Unknown"];
    [self.creationClientLabel setStringValue:@"Unknown"];
    [self.announceClientLabel setStringValue:@"Unknown"];
}

#pragma mark - Date helper

- (NSString*)formattedDateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return [dateFormatter stringFromDate:[[TorrentModel instance] torrent].creationDate];
}

@end
