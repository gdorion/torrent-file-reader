//
//  Torrent.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "Torrent.h"
#import "File.h"

@implementation Torrent

- (id)initWithFileList:(NSArray*)fileList andCreationClient:(NSString*)creationClient andCreationDate:(NSInteger)creationDate {
    self = [super init];
    
    if (self) {
        self.creationClient = creationClient;
        
        // TODO Convert string to NSDate.
        self.creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate];
                
        self.fileList = fileList;
    }
    
    return self;
}

- (NSArray*)fileNameList {
    NSMutableArray * names = [NSMutableArray new];
    
    for (File * file in self.fileList) {
        [names addObject:file.name];
    }
    
    return names;
}

@end
