//
//  ResultViewController.m
//  Application Game
//
//  Created by Xingjian Xia [el17xx] on 27/11/2017.
//  Copyright © 2017 Xingjian Xia [el17xx]. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize scoreLabel, highestScoreLabel, ScoreWin;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", ScoreWin]];
    
    //Code of saving and loading values from a document needed was learnt from
    //http://www.jianshu.com/p/459c15cf6ce2
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger HighestScore = [userDefaults integerForKey:@"Easy Level Highest Score"]; //To load the highest score called HighestScore in document "Easy Level Highest Score"
    
    if(ScoreWin > HighestScore)
    {
        [userDefaults setInteger: ScoreWin forKey:@"Easy Level Highest Score"]; //To make the highest score called ScoreWin in document "Easy Level Highest Score"
        [highestScoreLabel setText: [NSString stringWithFormat:@"Highest Score (Easy): %d", ScoreWin]]; //Show the highest result
    }
    else
    {
        [highestScoreLabel setText: [NSString stringWithFormat:@"Highest Score (Easy): %ld", (long)HighestScore]]; //Show the highest result

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
