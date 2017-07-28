//
//  JobInfo.m
//  Play_Game
//
//  Created by 安昌 on 2017/3/22.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "JobInfo.h"

@implementation JobInfo

-(NSString *)cleanString:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"_" withString:@""];
    return string;
}

-(void)cleanUpInfo
{
    @autoreleasepool {
        _jobID = [self cleanString:_jobID];
        _jobTitle = [self cleanString:_jobTitle];
        _jobName = [self cleanString:_jobName];
        _jobMoney = [self cleanString:_jobMoney];
        _jobXueli = [self cleanString:_jobXueli];
        _jobJingyan = [self cleanString:_jobJingyan];
        _jobAddress = [self cleanString:_jobAddress];
        _jobRespons = [self cleanString:_jobRespons];
        _jobCompanyInfo = [self cleanString:_jobCompanyInfo];
        _jobKeyWords = [self cleanString:_jobKeyWords];
    }
   
}

@end
