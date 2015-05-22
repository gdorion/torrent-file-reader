//
//  ls_torrent_clientTests.m
//  ls-torrent-clientTests
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "TorrentDecoder.h"
#import "Torrent.h"

@interface ls_torrent_clientTests : XCTestCase

@property (nonatomic) TorrentDecoder * decoder;

@end

@implementation ls_torrent_clientTests

- (void)setUp {
    [super setUp];
    self.decoder = [TorrentDecoder new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDecodeFileList {
    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
    NSString *path = [bundle pathForResource:@"testDictionary" ofType:@"txt"];
    
    Torrent * torrent = [self.decoder decodeTorrent:path];
    XCTAssertEqual(torrent.fileList.count, 2);
}

// Tracker
- (void)testDecodeAnnounce {
    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
    NSString *path = [bundle pathForResource:@"testDictionary" ofType:@"txt"];
    
    Torrent * torrent = [self.decoder decodeTorrent:path];
    XCTAssertTrue([torrent.announce isEqualToString:@"udp://open.demonii.com:1337/announce"]);
}

- (void)testDecodeCreationClient {
    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
    NSString *path = [bundle pathForResource:@"testDictionary" ofType:@"txt"];
    
    Torrent * torrent = [self.decoder decodeTorrent:path];
    XCTAssertTrue([torrent.creationClient isEqualToString:@"mktorrent 1.0"]);
}

- (void)testDecodeCreationDate {
    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
    NSString *path = [bundle pathForResource:@"testDictionary" ofType:@"txt"];
    
    Torrent * torrent = [self.decoder decodeTorrent:path];
    XCTAssertTrue([torrent.creationDate isEqualToDate:[NSDate dateWithTimeIntervalSince1970:1426231678]]);
}


@end
