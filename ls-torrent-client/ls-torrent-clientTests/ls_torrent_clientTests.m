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

- (void)testDecodeDictionary {
    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
    NSString *path = [bundle pathForResource:@"testDictionary" ofType:@"txt"];
    
    NSDictionary * dict = [self.decoder decodeTorrent:path];
    XCTAssertEqual([[dict objectForKey:@"info" ] allKeys].count, 3);
}

- (void)testDecodeArray {
//    NSBundle *bundle = [NSBundle bundleForClass:[self.decoder class]];
//    NSString *path = [bundle pathForResource:@"testArray" ofType:@"txt"];
//    
//    NSDictionary * dict = [self.decoder decodeTorrent:path];
//    NSArray * array = [dict objectForKey:@"info"];
//    XCTAssertEqual(array.count, 6);
}


@end
