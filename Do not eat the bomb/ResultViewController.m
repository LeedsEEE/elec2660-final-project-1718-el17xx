//
//  ResultViewController.m
//  Do not eat the bomb
//
//  Created by Nicopoi on 17/11/2017.
//  Copyright © 2017 Nicopoi. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end
@implementation ResultViewController
@synthesize scoreLable,highScoreLable,score;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [scoreLable setText:[NSString stringWithFormat:@"%d", score]];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSInteger highScore = [userDefaults integerForKey:@"High Score"];
    
    if(score > highScore){
        [userDefaults setInteger: score forKey:@"High Score"];
        [highScoreLable setText:[NSString stringWithFormat:@"High Score :%d",score]];
    }
    
    else{
        [highScoreLable setText:[NSString stringWithFormat:@"High Score : %ld", (long)highScore]];
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
