//
//  NSString+Test.m
//  Play_Game
//
//  Created by 安昌 on 2017/2/21.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "NSString+Test.h"
#import <objc/runtime.h>

static char *keyName;

@implementation NSString (test)

@dynamic testName;

//-(NSString*)testName{
//    return @"testSuccess";
//}

-(NSString*)testName{
    return objc_getAssociatedObject(self, keyName);
}

-(void)setTestName:(NSString *)testName
{
    objc_setAssociatedObject(self, &keyName, testName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
