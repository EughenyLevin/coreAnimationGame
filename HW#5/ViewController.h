//
//  ViewController.h
//  HW#5
//
//  Created by Evgheny on 05.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (assign,nonatomic,readwrite)  NSInteger score;
@property (strong,nonatomic) NSUserDefaults *userDefaults;
-(NSInteger) loadScore;
@end

