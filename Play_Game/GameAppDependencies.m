//
//  GameAppDependencies.m
//  Play_Game
//
//  Created by 安昌 on 2017/2/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "GameAppDependencies.h"
#import "GameRootContrllerRouter.h"

@interface GameAppDependencies ()

@property (strong,nonatomic) GameRootContrllerRouter *rootRouter;

@end

@implementation GameAppDependencies

-(id)init
{
    if( self = [super init] )
    {
        [self configureDependencies];
        return self;
    }
    return nil;
}

-(void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    
}

-(void)configureDependencies
{
    self.rootRouter = [[GameRootContrllerRouter alloc] init];
}

@end
