//
//  RootControllerGetter.m
//  Play_Game
//
//  Created by 安昌 on 2017/2/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "RootControllerCreater.h"

@implementation RootControllerCreater

+ (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window
{
    UINavigationController *navigationController = [RootControllerCreater navigationControllerFromWindow:window];
    navigationController.viewControllers = @[viewController];
}


+ (UINavigationController *)navigationControllerFromWindow:(UIWindow *)window
{
    UINavigationController *navigationController = (UINavigationController *)[window rootViewController];
    
    return navigationController;
}


@end
