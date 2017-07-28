//
//  ResultInfo.h
//  Play_Game
//
//  Created by 安昌 on 2017/3/16.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobInfo.h"
#import "ResumeInfo.h"

@interface ResultInfo : NSObject

//余弦相似度返回结果
@property (nonatomic,assign) int userID;

@property (nonatomic,assign) double cosResult;

@property (nonatomic,retain) NSMutableArray *recommendArray;

@property (nonatomic,retain) NSMutableArray *jobKeyWordArray;

@property (nonatomic,retain) NSMutableArray *resumeKeyWordArray;

@property (nonatomic,retain) JobInfo *job;

@property (nonatomic,retain) ResumeInfo *resume;

@end
