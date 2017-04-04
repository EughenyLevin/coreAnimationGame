//
//  LEGradient.m
//  HW#5
//
//  Created by Evgheny on 05.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LEGradient.h"
#import <UIKit/UIKit.h>
@implementation LEGradient

+(CAGradientLayer*)yellowGradient{
    
    UIColor *colorOne = [UIColor colorWithRed:(250/255) green:(76/255) blue:(61/255.0) alpha:1];
    UIColor *colorTwo = [UIColor colorWithRed:(243/255.0) green:(155/255.0) blue:(51/255.0) alpha:1];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor ,nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne,stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
}

@end
