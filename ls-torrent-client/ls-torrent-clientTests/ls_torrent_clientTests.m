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

@end

@implementation ls_torrent_clientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDecodeTypeString {
    NSString * fileToDecode = @"ubuntu-15.04-desktop-amd64.iso.torrent";
    
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
