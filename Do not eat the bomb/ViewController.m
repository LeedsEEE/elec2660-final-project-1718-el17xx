//
//  ViewController.m
//  Application Game
//
//  Created by Xingjian Xia [el17xx] on 27/11/2017.
//  Copyright © 2017 Xingjian Xia [el17xx]. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"
@interface ViewController ()
//add






{
    BOOL start;
    
    //set pacman
    int pacmanSpeed;
    
    //set size
    int pacmanHalfsize;
    int grapeHalfsize;
    int bananaHalfsize;
    int bombHalfsize;
    
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







@implementation ViewController
@synthesize startLable, pacman, grape, banana, bomb;





//add
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    pacmanHalfsize = pacman.frame.size.width/2;
    grapeHalfsize = grape.frame.size.width/2;
    bananaHalfsize = banana.frame.size.width/2;
    bombHalfsize = bomb.frame.size.width/2;
    
    //Score
    scoreGet = 0;
    scoreLable = [[UILabel alloc]initWithFrame:CGRectMake(250, 10, 120, 30)];
    [scoreLable setText:@"Score: 0"];
    [self.view addSubview:scoreLable];
    
    
}

//add
- (int)RandomNumber:(int)HalfSize
{
    int max;
    int min;
    min = barHeight + HalfSize;
    max = screenHeight - HalfSize - min;
    
    return arc4random_uniform(max) + min;
}

//add
-(void)Result
{
    ResultViewController *result;
    result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
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
    
    if(pacmanY < 23 + barHeight )
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
    grapeX = grape.center.x -4;
    grapeY = grape.center.y;
    
    if(grapeX < 0)
    {
        grapeX = screenWidth + 400;
        grapeY = [self RandomNumber:grapeHalfsize];
    }
    
    grape.center = CGPointMake(grapeX, grapeY);
    
    //set banana
    int bananaX;
    int bananaY;
    bananaX = banana.center.x -3;
    bananaY = banana.center.y;
    
    if(bananaX < 0)
    {
        bananaX = screenWidth + 400;
        bananaY = [self RandomNumber:bananaHalfsize];
    }
    
    banana.center = CGPointMake(bananaX, bananaY);
    
    //set bomb
    int bombX;
    int bombY;
    bombX = bomb.center.x -5;
    bombY = bomb.center.y;
    
    if(bombX < 0)
    {
        bombX = screenWidth + 150;
        bombY = [self RandomNumber:bombHalfsize];
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


@end
