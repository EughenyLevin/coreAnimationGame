
//  HW#5
//
//  Created by Evgheny on 05.10.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.

#import "ViewController.h"
#import "LEGradient.h"
#import "LELayerModel.h"
#import "LEGame.h"
#import "MenuController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;
@property (strong,nonatomic)  CALayer *comingLayer;
@property (strong,nonatomic)  CAAnimationGroup *animationGroup;
@property (assign,nonatomic)  BOOL isPlay;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@end

static NSInteger offset = 250;

@implementation ViewController

-(void)saveScore{

    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self.userDefaults setInteger:self.score forKey:@"score"];
}
-(NSInteger) loadScore{
    self.userDefaults  = [NSUserDefaults standardUserDefaults];
    NSInteger score2 = [self.userDefaults integerForKey:@"score"];
    return score2;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupColor];
    [self layerIninit];
    self.comingLayer.delegate = (id)self;
    self.isPlay = YES;
    NSInteger score2 = [self loadScore];
    [LEGame sharedGameData].score = score2;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score = %ld",self.score];
    NSLog(@"Score = %ld",score2);
}

#pragma mark gradientSet -

-(void)setupColor{
    
    CAGradientLayer *gradientLayer = [LEGradient yellowGradient];
    
    gradientLayer.frame = CGRectMake(self.view.bounds.origin.x,
                                     self.view.bounds.origin.y,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
 }
#pragma mark layerInit

-(void)layerIninit{
    self.comingLayer = [LELayerModel singleLayer];
    self.comingLayer.frame = CGRectMake(self.view.center.x-50,
                                        self.view.bounds.origin.y,
                                        50, 50);
    [self randomColorForLayer];
    [self.view.layer addSublayer:self.comingLayer];
    [self.comingLayer addAnimation:[self layerAnimation] forKey:@"basicAnimation"];
    [self.comingLayer setNeedsDisplay];
}

-(CABasicAnimation*)layerAnimation{
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    self.comingLayer.beginTime = CACurrentMediaTime();
    move.fromValue = @10;
    move.toValue = @520;
    
    CABasicAnimation *scale  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1.0;
    scale.toValue =@2.8;
    [self.comingLayer addAnimation:scale forKey:nil];

    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.byValue = @10.0;

    self.animationGroup = [CAAnimationGroup animation];
    self.animationGroup.duration = 1.0;
    self.animationGroup.animations = @[move,scale,rotate];
    self.animationGroup.delegate = (id)self;
    
    return (id) self.animationGroup;
    
}
- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender {
    if (self.comingLayer.backgroundColor != [UIColor redColor].CGColor && self.comingLayer.backgroundColor != [UIColor greenColor].CGColor) {
         self.comingLayer.position = CGPointMake(self.comingLayer.position.x+offset, self.comingLayer.position.y);
        self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score = %ld",self.score];
        [self animationForUILayer:self.scoreLabel.layer andTextfieldFont:self.scoreLabel.text];
    }
    else{
    [self alert];
    [self saveScore];
    self.isPlay = NO;
    [self.comingLayer removeAllAnimations];
    }
}

#pragma mark alertWindow

-(void)alert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You loose"
                                                                   message:[NSString stringWithFormat:@"Your score is %ld",self.score]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)animationForUILayer:(CALayer*)layer andTextfieldFont:(NSString*)string{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    
    animation.duration = 0.5;
    animation.values = @[ @0, @20, @-10, @20, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.additive = YES;
    
    
    UIFont *font = [UIFont fontWithName:@"Palatino-Roman" size:20.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                              forKey:NSFontAttributeName];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attrsDictionary];
   
    [layer addAnimation:animation forKey:@"taptic"];
    NSAttributedString *str = self.scoreLabel.attributedText;
    self.scoreLabel.attributedText = attrString;
    self.scoreLabel.attributedText = str;
}

- (IBAction)onLeftSwipe:(id)sender {
    if (self.comingLayer.backgroundColor != [UIColor redColor].CGColor && self.comingLayer.backgroundColor != [UIColor yellowColor].CGColor) {
        self.comingLayer.position = CGPointMake(self.comingLayer.position.x-offset, self.comingLayer.position.y);
      
         self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score = %ld",self.score];
        [self animationForUILayer:self.scoreLabel.layer andTextfieldFont:self.scoreLabel.text];
    }
    else {
    [self alert];
    [self saveScore];
    self.isPlay = NO;
    [self.comingLayer removeAllAnimations];
    }
}

#pragma mark layerRandomColor

-(void)randomColorForLayer{
    int i = arc4random()%3;
    UIColor *layerColor;
    switch (i) {
        case 0:
            layerColor = [UIColor redColor];
            
            break;
        case 1:
            layerColor = [UIColor greenColor];
            
            break;
        case 2:
            layerColor = [UIColor yellowColor];
            
            break;
        default:
            break;
    }
    self.comingLayer.backgroundColor = layerColor.CGColor;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (!self.isPlay) {
        [self.comingLayer removeAllAnimations];
        [self.comingLayer removeFromSuperlayer];
    }
    else
    [self layerIninit];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
