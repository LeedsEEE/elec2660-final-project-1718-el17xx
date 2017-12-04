//
//  ResultHardViewController.h
//  Application Game
//
//  Created by Xingjian Xia [el17xx] on 28/11/2017.
//  Copyright © 2017 Xingjian Xia [el17xx]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultHardViewController : UIViewController

@property (nonatomic) int ScoreWin;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestScoreLabel;



@end
