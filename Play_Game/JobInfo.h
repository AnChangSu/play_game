//
//  JobInfo.h
//  Play_Game
//
//  Created by 安昌 on 2017/3/22.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobInfo : NSObject

//ID integer,jobName text,jobMoney text,jobXueli text,jobJingyan text jobAddress,jobPosition text, jobRespons text,companyInfo text

@property (nonatomic,strong) NSString *jobID;

@property (nonatomic,strong) NSString *jobTitle;

@property (nonatomic,strong) NSString *jobName;

@property (nonatomic,strong) NSString *jobMoney;

@property (nonatomic,strong) NSString *jobXueli;

@property (nonatomic,strong) NSString *jobJingyan;

@property (nonatomic,strong) NSString *jobAddress;

@property (nonatomic,strong) NSString *jobRespons;

@property (nonatomic,strong) NSString *jobCompanyInfo;

@property (nonatomic,strong) NSString *jobKeyWords;

-(void)cleanUpInfo;

@end
