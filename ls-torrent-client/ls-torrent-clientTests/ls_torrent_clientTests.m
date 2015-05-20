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

- (void)testDecodeTypeString {
    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
    NSString *path = [bundle pathForResource:@"test" ofType:@"txt"];
    
//    NSString * path = [bundle pathForResource:@"ubuntu-1504-desktop-amd64" ofType:@"torrent"];

    NSDictionary * dict = [self.decoder decodeTorrent:path];
    
    // TODO bug with removal in list and array.
    
    XCTAssert(YES, @"Pass");
}

- (void)testDecodeTypeInt {
    XCTAssert(YES, @"Pass");
}

- (void)testDecodeTypeArray {
    XCTAssert(YES, @"Pass");
}

- (void)testDecodeTypeDictionary {
    XCTAssert(YES, @"Pass");
}

@end
