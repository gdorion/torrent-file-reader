//
//  Torrent.h
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Torrent : NSObject

@property (nonatomic) NSArray * fileList;
@property (nonatomic) NSString * creationClient;
@property (nonatomic) NSDate * creationDate;

- (id)initWithFileList:(NSArray*)fileList andCreationClient:(NSString*)creationClient andCreationDate:(NSInteger)creationDate;

- (NSArray*)fileNameList;

@end
