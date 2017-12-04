//
//  HardViewController.m
//  Application Game
//
//  Created by Xingjian Xia [el17xx] on 28/11/2017.
//  Copyright © 2017 Xingjian Xia [el17xx]. All rights reserved.
//

#import "HardViewController.h"
#import "ResultHardViewController.h"
@interface HardViewController ()

{
    BOOL start;
    
    //set pacman
    int pacmanSpeed;
    
    //set size
    int screenWidth;
    int screenHeight;
    int barHeight;
    
    //set timer
    NSTimer *timer;
    
    //Score
    int scoreGet;
    UILabel *scoreLable;
}



@end

@implementation HardViewController
@synthesize startLable, pacman, grape, banana, bomb;






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    start = NO;
    
    bomb.hidden = YES;
    banana.hidden = YES;
    grape.hidden = YES;
    
    //ScreenSize
    CGRect screen = [[UIScreen mainScreen]bounds];
    screenWidth = (int) CGRectGetWidth(screen);
    screenHeight = (int)CGRectGetHeight(screen);
    barHeight = (int)[[UIApplication sharedApplication]statusBarFrame].size.height;
    
    //HalfSize
    //pacmanHalfsize = pacman.frame.size.width/2;
    //grapeHalfsize = grape.frame.size.width/2;
    //bananaHalfsize = banana.frame.size.width/2;
    //bombHalfsize = bomb.frame.size.width/2;
    
    //Score
    scoreGet = 0;
    scoreLable = [[UILabel alloc]initWithFrame:CGRectMake(230, 10, 120, 30)];
    [scoreLable setText:@"Score: 0"];
    
    [self.view addSubview:scoreLable];

}


//add
-(void)Result
{
    ResultHardViewController *result;
    result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultHardViewController"];
    [result setScoreWin:scoreGet];
    [self presentViewController:result animated:YES completion:nil];
}





//add
- (void)HitBox
{
    if(CGRectIntersectsRect(pacman.frame, grape.frame))
    {
        scoreGet += 30;
        grape.center = CGPointMake(0, 0);
    }
    
    if(CGRectIntersectsRect(pacman.frame, banana.frame))
    {
        scoreGet += 10;
        banana.center = CGPointMake(0, 0);
    }
    
    if(CGRectIntersectsRect(pacman.frame, bomb.frame))
    {
        [timer invalidate];
        grape.hidden = YES;
        banana.hidden = YES;
        [self performSelector:@selector(Result) withObject:nil afterDelay:1];
    }
    
    
}

//add
- (void)Running
{
    [self HitBox];
    
    int pacmanY = pacman.center.y + pacmanSpeed;
    
    if(pacmanY < 23 + barHeight)
    {
        pacmanY = 23 + barHeight;
    }
    else if(pacmanY > screenHeight - 23)
    {
        pacmanY = screenHeight - 23;
    }
    
    pacman.center = CGPointMake(pacman.center.x, pacmanY);
    
    //set grape
    int grapeX;
    int grapeY;
    grapeX = grape.center.x -8;
    grapeY = grape.center.y;
    
    if(grapeX < 0)
    {
        grapeX = screenWidth + 400;
        grapeY = arc4random_uniform(screenHeight - 23 -23 - barHeight) + (23 + barHeight);
    }
    
    grape.center = CGPointMake(grapeX, grapeY);
    
    //set banana
    int bananaX;
    int bananaY;
    bananaX = banana.center.x -6;
    bananaY = banana.center.y;
    
    if(bananaX < 0)
    {
        bananaX = screenWidth + 400;
        bananaY = arc4random_uniform(screenHeight - 23 -23 - barHeight) + (23 + barHeight);
    }
    
    banana.center = CGPointMake(bananaX, bananaY);
    
    //set bomb
    int bombX;
    int bombY;
    bombX = bomb.center.x -10;
    bombY = bomb.center.y;
    
    if(bombX < 0)
    {
        bombX = screenWidth + 100;
        bombY = arc4random_uniform(screenHeight - 23 -23 - barHeight) + (23 + barHeight);
    }
    
    bomb.center = CGPointMake(bombX, bombY);
    
    scoreLable.text = [NSString stringWithFormat:@"Score: %d", scoreGet];
}

//add
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if(start == NO)
    {
        start = YES;
        startLable.hidden = YES;
        grape.hidden = NO;
        banana.hidden = NO;
        bomb.hidden = NO;
        
        grape.center = CGPointMake(0, -99);
        banana.center = CGPointMake(0, -99);
        bomb.center = CGPointMake(0, -99);
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                 target:self
                                               selector:@selector(Running)
                                               userInfo:nil
                                                repeats:YES];
    }
    
    pacmanSpeed = -5;
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    pacmanSpeed = 5;
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
