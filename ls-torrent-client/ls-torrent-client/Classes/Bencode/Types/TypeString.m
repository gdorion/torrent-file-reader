//
//  TypeString.m
//  ls-torrent-client
//
//  Created by Guillaume Dorion-Racine on 2015-05-19.
//  Copyright (c) 2015 Guillaume Dorion-Racine. All rights reserved.
//

#import "TypeString.h"

@implementation TypeString

- (instancetype)initWithString:(NSString *)string {
    self = [super initWithString:string];
    if (self) {
        // Ie : Parsing 8:announce      8 : length       annonce : Actual desired value
        //
        NSArray * components = [string componentsSeparatedByString:@":"];
        
        // String length
        if (components.count > 0) {
            self.length = [[components firstObject] integerValue];
        }
        
        // String content
        if (components.count > 1) {
            self.decodedValue = [components objectAtIndex:1];
            self.decodedValue = [self.rawValue substringWithRange:NSMakeRange(0, self.length)];
        }
    }
    
    return self;
}

@end
