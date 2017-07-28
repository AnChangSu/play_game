//
//  GameControllerRouter.m
//  Play_Game
//
//  Created by 安昌 on 2017/2/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "GameRootContrllerRouter.h"
#import "LoginViewController.h"
#import "RootControllerCreater.h"

@implementation GameRootContrllerRouter

-(void)presentRootInterfaceFromWindow:(UIWindow *)window
{
    //some logic code to choose which controller to present
    ////logic......
    ////logic......
    LoginViewController *controller = [[LoginViewController alloc] init];
    [RootControllerCreater showRootViewController:controller inWindow:window];
}

@end
