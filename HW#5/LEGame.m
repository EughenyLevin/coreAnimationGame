//
//  LEGame.m
//  HW#5
//
//  Created by Evgheny on 23.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LEGame.h"

@implementation LEGame
+(instancetype)sharedGameData{

    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)resetData{
    self.score = 0;
}

@end
