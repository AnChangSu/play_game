//
//  XTViewController.m
//  Play_Game
//
//  Created by 安昌 on 2017/3/15.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "XTViewController.h"
#import "LinkData.h"
#import "ResultInfo.h"
#import <math.h>

//实现余弦过滤，使用movieslen的数据测试
@interface XTViewController ()



@end

@implementation XTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"csv" ];
    
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *array = [string componentsSeparatedByString:@"\r\n"];
    
    LinkData *data = [[LinkData alloc] init];
    for ( NSString *string in array) {
        BOOL isNew = NO;
        NSArray *tempArray = [string componentsSeparatedByString:@","];
        //判断是否同一用户
        if ( data.userID == [[tempArray objectAtIndex:0] intValue]) {
            isNew = NO;
        }else{
            isNew = YES;
            data = [[LinkData alloc] init];
            data.userID = [[tempArray objectAtIndex:0] intValue];
        }
        //判断是否正常记录
        if ( [tempArray count] == 4 ) {
            [data.movieIDArray addObject: [tempArray objectAtIndex:1]];
            [data.movieRateArray addObject:[tempArray objectAtIndex:2]];
            
        }
        //判断是否需要将data加入数组(避免重复加入)
        if ( isNew ) {
            [_dataArray addObject:data];
        }
    }
    
    data = [_dataArray objectAtIndex:0];
//    [data logInfo];
    
//    [self cos:[_dataArray objectAtIndex:0] user2:[_dataArray objectAtIndex:1]];
    for ( int i=0 ; i<1500; i++) {
        LinkData *data2 = [_dataArray objectAtIndex:i];
        [self cos:data user2:data2];
    }
//    NSLog(@"-----array = %@",_dataArray);
//    NSLog(@"string = %@",string);
    // Do any additional setup after loading the view.
}

//计算余弦距离
-(ResultInfo*)cos:(LinkData*)user1 user2:(LinkData*)user2
{
    //公式               x1x2 + y1y2
    //     ----------------------------------
    //     根号(x1平方+y1平方)*根号(x2平方+y2平方)
    //user1独有的电影的rating
    NSMutableArray *user1RateArray = [[NSMutableArray alloc] init];
    //user2独有的电影的rating
    NSMutableArray *user2RateArray = [[NSMutableArray alloc] init];
    //共有的电影user1的rating
    NSMutableArray *same1RateArray = [[NSMutableArray alloc] init];
    //共有的电影user2的rating
    NSMutableArray *same2RateArray = [[NSMutableArray alloc] init];
    ResultInfo *result = [[ResultInfo alloc] init];
    
    //查找user2 movieID列表中与user1重合的部分
    NSMutableSet *user1MovieIDSet = [NSMutableSet setWithArray:user1.movieIDArray];
    NSMutableSet *user2MovieIDSet = [NSMutableSet setWithArray:user2.movieIDArray];
    //user1和user2的交集
    NSMutableSet *intersectSet = [NSMutableSet setWithSet:user1MovieIDSet];
    [intersectSet intersectSet:user2MovieIDSet];
    //user1和user2的并集
    NSMutableSet *unionSet = [NSMutableSet set];
    [unionSet unionSet:user1MovieIDSet];
    [unionSet unionSet:user2MovieIDSet];
//    //user1中独有的集
//    NSMutableSet *user1Set = [[NSMutableSet alloc] initWithSet:unionSet];
//    [user1Set minusSet:user2MovieIDSet];
    //user2中独有的集
    NSMutableSet *user2Set = [[NSMutableSet alloc] initWithSet:unionSet];
    [user2Set minusSet:user1MovieIDSet];
//
////    [user1Set containsObject:<#(nonnull id)#>]
//    //查找user1中独有的rating
//    NSArray *tempArray = user1Set.allObjects;
//    for (int i=0; i<[tempArray count]; i++) {
//        NSString *string = [tempArray objectAtIndex:i];
//        for ( int j=0 ; j<[user1.movieIDArray count]; j++) {
//            NSString *movieString = [user1.movieIDArray objectAtIndex:j];
//            if ( [string isEqualToString:movieString] ) {
//                [user1RateArray addObject:[user1.movieRateArray objectAtIndex:j]];
//            }
//        }
//    }
//    
//    //查找user2中独有的rating
//    tempArray = user2Set.allObjects;
//    for (int i=0; i<[tempArray count]; i++) {
//        NSString *string = [tempArray objectAtIndex:i];
//        for ( int j=0 ; j<[user2.movieIDArray count]; j++) {
//            NSString *movieString = [user2.movieIDArray objectAtIndex:j];
//            if ( [string isEqualToString:movieString] ) {
//                [user2RateArray addObject:[user2.movieRateArray objectAtIndex:j]];
//            }
//        }
//
//    }
    
    //查找user1,user2中共有的rating
    NSArray *tempArray = intersectSet.allObjects;
    for (int i=0; i<[tempArray count]; i++) {
        NSString *string = [tempArray objectAtIndex:i];
        for ( int j=0 ; j<[user2.movieIDArray count]; j++) {
            NSString *movieString = [user2.movieIDArray objectAtIndex:j];
            if ( [string isEqualToString:movieString] ) {
                [same2RateArray addObject:[user2.movieRateArray objectAtIndex:j]];
            }
        }
        
        for ( int j=0 ; j<[user1.movieIDArray count]; j++) {
            NSString *movieString = [user1.movieIDArray objectAtIndex:j];
            if ( [string isEqualToString:movieString] ) {
                [same1RateArray addObject:[user1.movieRateArray objectAtIndex:j]];
            }
        }
    }
    
//    NSLog(@"_____%d_____%d_______%d",[tempArray count],[same1RateArray count],[same2RateArray count]);
    
//    开始计算余弦距离,计算sum即除数
    double sum = 0;
    tempArray = intersectSet.allObjects;
    for ( int i=0 ; i<[tempArray count]; i++) {
        double number1 = [[same1RateArray objectAtIndex:i] doubleValue];
        double number2 = [[same2RateArray objectAtIndex:i] doubleValue];
        sum += number1* number2;
//        NSLog(@" sum = %f_____%f_____%f",sum,number1,number2);
    }
    
    //计算user1开根号
    double user1Result = 0;
    for (int i=0; i<[user1.movieRateArray count]; i++) {
        double number = [[user1.movieRateArray objectAtIndex:i] doubleValue];
        user1Result += number*number;
    }
    user1Result = sqrt(user1Result);
    
    double user2Result = 0;
    for (int i=0; i<[user2.movieRateArray count]; i++) {
        double number = [[user2.movieRateArray objectAtIndex:i] doubleValue];
        user2Result += number*number;
    }
    user2Result = sqrt(user2Result);
    
    double result1 = sum/(user1Result*user2Result);
    NSLog(@"________%f",result1);
    
    //获取返回结果
    result.userID = user2.userID;
    result.cosResult = result1;
    [result.recommendArray addObjectsFromArray:user2Set.allObjects];
    
    return result;
//    NSLog(@"______user1 only____%@",user1Set.allObjects);
//    NSLog(@"______user2 only____%@",user2Set.allObjects);
//    NSLog(@"______user1 rating____%@",user1RateArray);
//    NSLog(@"______user2 rating____%@",user2RateArray);
//    double result = sqrt(3.33333);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
