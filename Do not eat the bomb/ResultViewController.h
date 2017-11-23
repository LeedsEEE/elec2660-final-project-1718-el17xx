//
//  ResultViewController.h
//  Do not eat the bomb
//
//  Created by Nicopoi on 17/11/2017.
//  Copyright © 2017 Nicopoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController :UIViewController

@property(nonatomic)int score;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLable;

@end
