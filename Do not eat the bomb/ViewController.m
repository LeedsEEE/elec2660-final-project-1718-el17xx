//
//  ViewController.m
//  Do not eat the bomb
//
//  Created by Nicopoi on 16/11/2017.
//  Copyright © 2017 Nicopoi. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"
@interface ViewController ()
{
    BOOL start_flg;
    
    //set speed
    int eatghostSpeed;
    
    //Size
    int eatghostHalfSize;
    int grapeHalfSize;
    int bananaHalfSize;
    int bombHalfSize;
    
    //Screen Size
    int screenWidth;
    int screenHeight;
    int statusBarHeight;//statusBar is the time section, at the top
    
    //Timer
    NSTimer *timer;
    
    //Score
    int score;
    UILabel *scoreLable;
}



@end

@implementation ViewController
@synthesize startLable, eatghost, grape, banana, bomb ;
//add
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    start_flg = NO;
    
    bomb.hidden = YES;
    banana.hidden = YES;
    grape.hidden = YES;
    
    //Screen Size
    CGRect screen = [[UIScreen mainScreen]bounds];
    screenWidth = (int)CGRectGetWidth(screen);
    screenHeight = (int)CGRectGetHeight(screen);
    statusBarHeight = (int)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
    //Confirm
    /*NSLog(@"width : %d", screenWidth);
    NSLog(@"height : %d", screenHeight);
    NSLog(@"status bar : %d", statusBarHeight);*/
    
    eatghostHalfSize = eatghost.frame.size.width/2;
    grapeHalfSize = grape.frame.size.width/2;
    bananaHalfSize = banana.frame.size.width/2;
    bombHalfSize = bomb.frame.size.width/2;
    
    //Mentioned Above to hide the grape, banana and bomb at beginning
    
    /*-(void)touchesBegan:(NSSet<UItouch *> *)touches withEvent:(UIEvent *)event
    {
        if (start_flg == NO)
    }*/
    //made a mistake...it should be in another section.
    
    score = 0;
    scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(180, 30, 125, 20)];
    [scoreLable setText:@"Score : 0"];
    [scoreLable setTextAlignment:NSTextAlignmentRight];
    [scoreLable setFont:[UIFont fontWithName:@" Nico" size:18]];
    [self.view addSubview:scoreLable];
    
}

-(void)checkHit {
    
    if(CGRectIntersectsRect(eatghost.frame, grape.frame)){
        score += 30;
        grape.center = CGPointMake(-100, -100);
    }
    
    if(CGRectIntersectsRect(eatghost.frame, banana.frame)){
        score += 10;
        banana.center = CGPointMake(-100, -100);
    }
    
    if(CGRectIntersectsRect(eatghost.frame, bomb.frame)){
        //You die
        [timer invalidate]; //make the timer stop
        grape.hidden = YES;
        banana.hidden = YES;
        //[self showResult];
        [self performSelector:@selector(showResult) withObject:nil afterDelay:1.0];
    }
}

-(void)showResult {
    ResultViewController *viewController;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    [viewController setScore:score];
    [self presentViewController:viewController animated:YES completion:nil];
}


-(void)changesPos {
    
    [self checkHit];
    
    
    //About the ghost
    int eatghostY = eatghost.center.y + eatghostSpeed;
    
    if (eatghostY < 30 + statusBarHeight ){
        eatghostY = 30 + statusBarHeight;
    }else if (eatghostY > screenHeight -30 ){
        eatghostY = screenHeight -30;
    }
    //30 is the half size of ghost
    
    eatghost.center = CGPointMake(eatghost.center.x,eatghostY);
    
    //To make the ghost move up and down
    
    //set the grape
    int grapeX;
    int grapeY;
    //int maximun;
    //int minimun;
    
    grapeX = grape.center.x -4;//the number decides how fast the grape run
    grapeY = grape.center.y;
    
    if (grapeX < 0){
        grapeX = screenWidth + 400 ;//the number decides how often grape appears
        
         //maximun = screenHeight - grapeHalfSize - minimun;
         //minimun = statusBarHeight + grapeHalfSize;
        
        //the first time I use this order above, it does not work
        //the sequence is important
        
        //grapeY = arc4random_uniform(maximun) + minimun;
    
        grapeY = [self generateRandomNumber:grapeHalfSize];
        
        
    }
    
    grape.center = CGPointMake(grapeX, grapeY);
    
    //set the banana
    int bananaX;
    int bananaY;
    //int maximun1;
    //int minimun1;
    
    bananaX = banana.center.x - 3;
    bananaY = banana.center.y;
    
    if(bananaX < 0){
        bananaX = screenWidth +200;
        
        //maximun1 = screenHeight - bananaHalfSize - minimun1;
        //minimun1 = statusBarHeight + bananaHalfSize;
        
        bananaY = [self generateRandomNumber:bananaHalfSize];
        //bananaY = arc4random_uniform(maximun1) + minimun1;
        
    }
    banana.center = CGPointMake(bananaX, bananaY);
    
    
    //set the bomb
    int bombX;
    int bombY;
    
    bombX = bomb.center.x - 5;
    bombY = bomb.center.y;
    
    if(bombX <0){
        bombX = screenWidth +150;
        
        bombY = [self generateRandomNumber:bombHalfSize];
    }
    bomb.center = CGPointMake(bombX, bombY);
    
    scoreLable.text = [NSString stringWithFormat:@"Score : %d", score];
    
}


-(int)generateRandomNumber:(int)HalfSize{
    
    int maximun ;
    int minimun ;
    
    minimun = statusBarHeight + HalfSize;
    maximun = screenHeight - HalfSize - minimun;
    
    return arc4random_uniform(maximun) + minimun;
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (start_flg == NO){
        start_flg = YES;
        startLable.hidden = YES;
        
        grape.hidden = NO;
        bomb.hidden = NO;
        banana.hidden = NO;
        
        //Make three move out of the screen x
        grape.center = CGPointMake(-9999,-9999);
        banana.center = CGPointMake(-9999,-9999);
        bomb.center = CGPointMake(-9999,-9999);
        
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
        target:self selector:@selector(changesPos)userInfo:nil repeats:YES];
    }
    eatghostSpeed = -5;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    eatghostSpeed = 5;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
