//
//  File.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "File.h"

@implementation File

- (instancetype)initWithName:(NSString*)name andLength:(NSInteger)length andHash:(NSString*)hash andChecksum:(NSString*)checksum {
    self = [super init];
    
    if (self){
        self.name = name;
        self.length = length;
        self.sha1Hash = hash;
        self.checksum = checksum;
    }
    
    return self;
}

@end
