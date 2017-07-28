//
//  LinkData.m
//  Play_Game
//
//  Created by 安昌 on 2017/3/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "LinkData.h"

@implementation LinkData

-(instancetype)init{
    
    if ( self = [super init] ) {
        _movieIDArray = [[NSMutableArray alloc] init];
        _movieRateArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)logInfo{
    NSLog(@"________userID = %d",self.userID);
    for (int i=0; i<[_movieIDArray count]; i++) {
        NSString *string = [_movieIDArray objectAtIndex:i];
        NSLog(@"___________movieID__%d_=_%@",i,string);
    }
    for (int i=0; i<[_movieRateArray count]; i++) {
        NSString *string = [_movieRateArray objectAtIndex:i];
        NSLog(@"___________movieRate__%d_=_%@",i,string);
    }
}

@end
