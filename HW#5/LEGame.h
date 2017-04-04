//
//  LEGame.h
//  HW#5
//
//  Created by Evgheny on 23.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEGame : NSObject
@property (assign,nonatomic) NSInteger score;
+(instancetype)sharedGameData;
-(void)resetData;
@end
