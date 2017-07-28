//
//  ResumeInfo.h
//  Play_Game
//
//  Created by 安昌 on 2017/3/22.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeInfo : NSObject

@property(nonatomic,strong) NSString *resumeName;

@property(nonatomic,strong) NSString *resumeID;

@property(nonatomic,strong) NSString *resumeTitle;

@property(nonatomic,strong) NSString *gongzuoDidian;

@property(nonatomic,strong) NSString *gongzuoNianxian;

@property(nonatomic,strong) NSString *zhiyeQiwang;

@property(nonatomic,strong) NSString *hangyeQiwang;

@property(nonatomic,strong) NSString *xueli;

@property(nonatomic,strong) NSString *daxuezhuanye;

@property(nonatomic,strong) NSString *xinziQiwang;

@property(nonatomic,strong) NSString *gongzuoJingli;

@property(nonatomic,strong) NSString *xiangmuJingli;

@property(nonatomic,strong) NSString *resumeKeywords;

-(void)cleanUpInfo;

@end
