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
    //All these are the main parameters.
    
    BOOL start; //wheather the game starts
    
    //set pacman
    
    int pacmanSpeed; //the speed of pacman
    
    //set size
    //Setting these three parameters is to make the frames of pictures showe completely in the screen.
    //Without these three parameters, the frames will just show part of them sometimes.
    
    int screenWidth; //phone's screen width
    int screenHeight; //phone's screen height
    int barHeight; //phone's bar height
    
    //set timer
    //The timer is the basic function to make the project run.
    //It can make one order run x times in some time.
    
    NSTimer *timer;
    
    //set score
    
    int scoreGet;
    UILabel *scoreLable;
}



@end

@implementation HardViewController
@synthesize startLable, pacman, grape, banana, bomb;






- (void)viewDidLoad {
    [super viewDidLoad];
    
    start = NO; //Originally the bool start is NO. Only the pacman can be seen on the main viewcontronler.
    //The following three are set to be hidden.
    
    bomb.hidden = YES;
    banana.hidden = YES;
    grape.hidden = YES;
    
    //ScreenSize
    
    //Code to set screen width and height was learnt from
    //https://stackoverflow.com/questions/5677716/how-to-get-the-screen-width-and-height-in-ios
    
    CGRect screen = [[UIScreen mainScreen]bounds];
    screenWidth = screen.size.width;//To get the screen width
    screenHeight = screen.size.height;;//To get the screen height
    
    //Code to set the bar height was learnt from
    //https://stackoverflow.com/questions/12991935/how-to-programmatically-get-ios-status-bar-height
    
    barHeight = (int)[[UIApplication sharedApplication]statusBarFrame].size.height;//To get the bar height
    
    //Score
    
    scoreGet = 0;//Original score is 0
    
    //Code to set the lable to a new Rect was learnt from
    //https://stackoverflow.com/questions/6628644/changing-cgrectmake-x-x-x-x-to-a-different-location-such-as-y-y-y-y
    
    
    scoreLable = [[UILabel alloc]initWithFrame:CGRectMake(230, 10, 120, 30)];//To set where the score showed on the screen
    //230 is float x, 10 is float y, 120 is the width of lable width, 30 is the height of lable height
    
    [scoreLable setText:@"Score: 0"];
    [self.view addSubview:scoreLable];

}


//add
-(void)Result
{
    ResultHardViewController *result;
    result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultHardViewController"];
    [result setScoreWin:scoreGet]; //To make the scoreWin in ResultHardViewController be scoreGet in ViewController
    
    //Code to change view was learnt from
    //http://m.blog.csdn.net/ityanping/article/details/39270609
    
    [self presentViewController:result animated:YES completion:nil];//To show the ResultHardViewController by animation
}





//add
- (void)HitBox
{
    //Code to check wheather two rectangles intersect was learnt from
    //https://developer.apple.com/documentation/coregraphics/1454747-cgrectintersectsrect
    
    if(CGRectIntersectsRect(pacman.frame, grape.frame))//If pacman intersects with grape, score pluses 30
    {
        scoreGet += 30;
        grape.center = CGPointMake(0, 0);//Reset the position of grape (float x, float y)
    }
    
    if(CGRectIntersectsRect(pacman.frame, banana.frame))//If pacman intersects with banana, score pluses 10
    {
        scoreGet += 10;
        banana.center = CGPointMake(0, 0);//Reset the postion of banana
    }
    
    if(CGRectIntersectsRect(pacman.frame, bomb.frame))//If pacman intersects with bomb, game over
    {
        [timer invalidate];//Stop timer function
        grape.hidden = YES;
        banana.hidden = YES;
        
        //Code to runing anothrt function was learnt from
        //http://m.blog.csdn.net/libaineu2004/article/details/45874149
        
        [self performSelector:@selector(Result) withObject:nil afterDelay:1];//To run the Result function after 1 second
    }
    
    
}

//add
- (void)Running
{
    [self HitBox]; //Run HitBox function
    
    int pacmanY = pacman.center.y + pacmanSpeed; //With the timer function, float y of pacman can plus pacmanSpeed each time set
    
    //To make the pacman do not disappear in the screen
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
    
    //To set the grape appear in the screen
    int grapeX;
    int grapeY;
    grapeX = grape.center.x -8; //With the timer function, float x of grape can plus -4 each time set, set the speed
    grapeY = grape.center.y;
    
    //To make the grape appear again if it disappears (float x is smaller than 0)
    if(grapeX < 0)
    {
        grapeX = screenWidth + 400; //To set the frequency of grape appearing
        
        //Code to set range of random float y was learnt from
        //http://m.blog.csdn.net/Enjolras1024/article/details/51965607
        
        grapeY = arc4random_uniform(screenHeight - 23 -23 - barHeight) + (23 + barHeight); //To set a range of float y to make the grape appear randomly in the screen
    }
    
    grape.center = CGPointMake(grapeX, grapeY);
    
    //set banana
    int bananaX;
    int bananaY;
    bananaX = banana.center.x -6;//With the timer function, float x of banana can plus -4 each time set, set the speed
    bananaY = banana.center.y;
    
    //To make the banana appear again if it disappears (float x is smaller than 0)
    if(bananaX < 0)
    {
        bananaX = screenWidth + 400; //To set the frequency of banana appearing
        bananaY = arc4random_uniform(screenHeight - 23 -23 - barHeight) + (23 + barHeight); //To set a range of float y to make the banana appear randomly in the screen
    }
    
    banana.center = CGPointMake(bananaX, bananaY);
    
    //set bomb
    int bombX;
    int bombY;
    bombX = bomb.center.x -10; //With the timer function, float x of bomb can plus -5 each time set, set the speed
    bombY = bomb.center.y;
    
    if(bombX < 0)
    {
        bombX = screenWidth + 100;  //To set the frequency of banana appearing
        bombY = arc4random_uniform(screenHeight - 23 -23 - barHeight) + (23 + barHeight); //To set a range of float y to make the banana appear randomly in the screen
    }
    
    bomb.center = CGPointMake(bombX, bombY);
    
    scoreLable.text = [NSString stringWithFormat:@"Score: %d", scoreGet];}

//add

//Code to run function when touching screen was learnt from
//https://developer.apple.com/documentation/uikit/uigesturerecognizer/1620009-touchesbegan?language=objc

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //To run the timer just only once
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
        
        //Code of setting timer details was learnt from
        //https://developer.apple.com/documentation/foundation/nstimer/1412416-scheduledtimerwithtimeinterval?language=objc
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                 target:self
                                               selector:@selector(Running)
                                               userInfo:nil
                                                repeats:YES]; //To run the Running function every 0.01 second
    }
    
    pacmanSpeed = -5; //parameter of pacman's speed when touching screen
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    pacmanSpeed = 5; //parameter of pacman's speed when touching screen
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
