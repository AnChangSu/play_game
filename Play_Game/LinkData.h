//
//  LinkData.h
//  Play_Game
//
//  Created by 安昌 on 2017/3/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LinkData : NSObject

@property (nonatomic,assign) int userID;

@property (nonatomic,retain) NSMutableArray *movieIDArray;

@property (nonatomic,retain) NSMutableArray *movieRateArray;

-(void)logInfo;

@end
