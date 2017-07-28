//
//  RootControllerGetter.h
//  Play_Game
//
//  Created by 安昌 on 2017/2/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RootControllerCreater : NSObject

+ (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window;

@end
