//
//  ResultHardViewController.m
//  Application Game
//
//  Created by Xingjian Xia [el17xx] on 28/11/2017.
//  Copyright © 2017 Xingjian Xia [el17xx]. All rights reserved.
//

#import "ResultHardViewController.h"

@interface ResultHardViewController ()

@end

@implementation ResultHardViewController
@synthesize scoreLabel, highestScoreLabel, ScoreWin;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", ScoreWin]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger HighestScore = [userDefaults integerForKey:@"Hard Level Highest Score"];
    
    if(ScoreWin > HighestScore)
    {
        [userDefaults setInteger: ScoreWin forKey:@"Hard Level Highest Score"];
        [highestScoreLabel setText: [NSString stringWithFormat:@"Highest Score (Hard): %d", ScoreWin]];
    }
    else
    {
        [highestScoreLabel setText: [NSString stringWithFormat:@"Highest Score (Hard): %ld", (long)HighestScore]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
