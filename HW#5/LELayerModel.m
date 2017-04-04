//
//  LELayerModel.m
//  HW#5
//
//  Created by Evgheny on 05.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LELayerModel.h"
#import <UIKit/UIKit.h>

static float flip = -1;

@implementation LELayerModel


+(id)singleLayer{
    
    static LELayerModel *layer = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        layer = [LELayerModel layer];
   
    });
    
    return layer;
}


-(UIColor*)randomColorForLayer{
    int i = arc4random()%3;
    UIColor *layerColor;
    switch (i) {
        case 0:
            layerColor = [UIColor blueColor];
            
            break;
        case 1:
            layerColor = [UIColor blackColor];
            
            break;
        case 2:
            layerColor = [UIColor orangeColor];
            
            break;
        default:
            break;
    }

    return layerColor;
}



-(void)drawInContext:(CGContextRef)ctx{
    
    int aSize = 50.0;
    CGContextSetLineWidth(ctx, aSize);
    CGFloat xCenter = 25.0;
    CGFloat yCenter = 25.0;
    
    float  w = 50.0;
    double r = w / 2.0;
    
    CGContextSetFillColorWithColor(ctx, [self randomColorForLayer].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [self randomColorForLayer].CGColor);
    
    double theta = 2.0 * M_PI * (2.0 / 5.0);
    
    CGContextMoveToPoint(ctx, xCenter, r*flip+yCenter);
    
    for (NSUInteger k=1; k<5; k++)
    {
        float x = r * sin(k * theta);
        float y = r * cos(k * theta);
        CGContextAddLineToPoint(ctx, x+xCenter, y*flip+yCenter);
    }

    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
}


@end
