//
//  ResumeInfo.m
//  Play_Game
//
//  Created by 安昌 on 2017/3/22.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "ResumeInfo.h"

@implementation ResumeInfo

-(NSString *)cleanString:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"_" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"简历编号：" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"现居住地：" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"工作经验：" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"期望职位：" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"期望行业：" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"期望薪资：" withString:@""];
    return string;
}

-(void)cleanUpInfo
{
    @autoreleasepool {
        self.resumeName = [self cleanString:self.resumeName];
        self.resumeID = [self cleanString:self.resumeID];
        self.resumeTitle = [self cleanString:self.resumeTitle];
        self.gongzuoDidian = [self cleanString:self.gongzuoDidian];
        self.gongzuoNianxian = [self cleanString:self.gongzuoNianxian];
        self.zhiyeQiwang = [self cleanString:self.zhiyeQiwang];
        self.hangyeQiwang = [self cleanString:self.hangyeQiwang];
        self.xueli = [self cleanString:self.xueli];
        self.daxuezhuanye = [self cleanString:self.daxuezhuanye];
        self.xinziQiwang = [self cleanString:self.xinziQiwang];
        self.gongzuoJingli = [self cleanString:self.gongzuoJingli];
        self.xiangmuJingli = [self cleanString:self.xiangmuJingli];
        self.resumeKeywords = [self cleanString:self.resumeKeywords];
    }
    
}

@end
