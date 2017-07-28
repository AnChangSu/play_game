//
//  ViewController.m
//  Play_Game
//
//  Created by 安昌 on 2017/2/14.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "LoginViewController.h"
#import "XTViewController.h"
#import "FindTheWay.h"
#import "GiveTheResultController.h"

@interface LoginViewController ()

@property(nonatomic,retain) NSOperationQueue *secondQueue;
@property(nonatomic,retain) NSInvocationOperation *invocationOperation;
@property(nonatomic,retain) NSBlockOperation *blockOperation;

@end

@implementation LoginViewController

@synthesize mainQueue;


- (void)viewDidLoad {
    [super viewDidLoad];
//    _blockOperation = [self createBlockOperation];
//    [_blockOperation addExecutionBlock:^{
//        NSLog(@"————————————%@",[NSThread currentThread]);
//    }];
//    [_blockOperation addExecutionBlock:^{
//        NSLog(@"————————————%@",[NSThread currentThread]);
//        sleep(2);
//    }];
//    _invocationOperation = [self createInvocationOperation];
//    [_invocationOperation addDependency:_blockOperation];
//    [self.mainQueue addOperation:_invocationOperation];
//    [self.mainQueue addOperation:_blockOperation];
//    [self.mainQueue addOperationWithBlock:^{
//        NSLog(@"=============%@",[NSThread currentThread]);
//    }];
//
    
    //初始化数据，存入数据库
//    FindTheWay *way = [[FindTheWay alloc] init];
//    [self presentViewController:way animated:NO completion:nil];
    
    
    //测试余弦过滤算法
//    XTViewController *controller = [[XTViewController alloc] init];
//    [self presentViewController:controller animated:NO completion:nil];
    // Do any additional setup after loading the view, typically from a nib.
    
 
    //计算最终的结果
    GiveTheResultController *controller = [[GiveTheResultController alloc] init];
    [self presentViewController:controller animated:NO completion:nil];
//    NSLog(@"___________resumeArray = %@",resumeArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addOperation
{
    NSOperation *operation = [[NSOperation alloc] init];
}

-(NSBlockOperation*)createBlockOperation
{
    return [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"————————————%@",[NSThread currentThread]);
    }];
}

-(NSInvocationOperation *)createInvocationOperation
{
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionLogInfo) object:nil];
    return invocation;
}

-(void)actionLogInfo
{
    NSLog(@"我在地%@个线程",[NSThread currentThread]);
}

-(NSOperationQueue*)mainQueue{
    if ( mainQueue == nil ) {
        mainQueue = [[NSOperationQueue alloc] init];
        mainQueue.maxConcurrentOperationCount = 1;
    }
    return mainQueue;
}

-(void)setMainQueue:(NSOperationQueue *)mainQueue1{
    if ( mainQueue != mainQueue1 ) {
        mainQueue = mainQueue1;
    }
}


@end
