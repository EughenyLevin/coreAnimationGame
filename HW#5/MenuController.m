
//
//  MenuController.m
//  HW#5
//
//  Created by Evgheny on 23.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "MenuController.h"
#import "ViewController.h"
#import "LEGame.h"
@interface MenuController ()
@property (weak, nonatomic) IBOutlet UIView *subView;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controller.userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger score2 = [self.controller.userDefaults integerForKey:@"score"];
    NSLog(@"Score = %ld",score2);
    
    
    [self setRoundedView:self.subView toDiameter:200.];
    
   
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
    [self animateLayer:roundedView.layer];
}

- (IBAction)onClick:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)animateLayer:(CALayer*)layer{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotation.duration = 2;
    rotation.repeatCount = INFINITY;
    [layer addAnimation:rotation forKey:@"rotation"];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.toValue = @20;

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
