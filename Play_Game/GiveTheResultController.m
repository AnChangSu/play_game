//
//  GiveTheResultController.m
//  Play_Game
//
//  Created by 安昌 on 2017/3/27.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "GiveTheResultController.h"
#import "ResultInfo.h"
#import "JobInfo.h"
#import "ResumeInfo.h"
#import "FMDB.h"

@interface GiveTheResultController ()

@property(nonatomic,strong) FMDatabase *jobDB;

@end

@implementation GiveTheResultController

//将整个句切分为词(分词)
-(NSArray *)stringTokenizerWithWord:(NSString *)word{
    NSMutableArray *keyWords=[[NSMutableArray alloc] init];
    
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)word, CFRangeMake(0, word.length),kCFStringTokenizerUnitWord,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    
    
    while (range.length>0)
    {
        keyWord=[word substringWithRange:NSMakeRange(range.location, range.length)];
        [keyWords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }

    return keyWords;
}

-(void)testCutWord
{
    NSString *string = @"这是一条测试数据，能否分词成功呢？运营经理测试工程师ios工程师android高级工程师xcode环境";
    NSArray *array = [self stringTokenizerWithWord:string];
    
    for ( int i=0; i<[array count]; i++) {
        NSString *temp = [array objectAtIndex:i];
        NSLog(@"________temp = %@",temp);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _jobArray = [[NSMutableArray alloc] init];
    _resumeArray = [[NSMutableArray alloc] init];
    _resultArray = [[NSMutableArray alloc] init];
    
//    [self testCutWord];
    
    [self openDataBase];
    
    JobInfo *job = [_jobArray objectAtIndex:0];
    
    for ( int i=0 ; i<[_resumeArray count]; i++) {
        ResumeInfo *resume = [_resumeArray objectAtIndex:i];
        [self cos:job user2:resume];
    }
    
    NSLog(@"______job = %@",job.jobID);
    
    for (int i=0; i<[_resultArray count]; i++) {
        ResultInfo *info = [_resultArray objectAtIndex:i];
        NSLog(@"______cos = %f ____name = %@",info.cosResult,info.resume.resumeName);
        
        NSMutableString *keyString = [[NSMutableString alloc] init];
        for ( int i=0 ; i<[info.jobKeyWordArray count]; i++) {
            NSString *temp = [info.jobKeyWordArray objectAtIndex:i];
            [keyString appendFormat:@"_%@",temp];
        }
        NSLog(@"job_____%@",keyString);
        
        NSMutableString *resumeString = [[NSMutableString alloc] init];
        for ( int i=0 ; i<[info.resumeKeyWordArray count]; i++) {
            NSString *temp = [info.resumeKeyWordArray objectAtIndex:i];
            [resumeString appendFormat:@"_%@",temp];
        }
        NSLog(@"resume_____%@",resumeString);
    }
    
//    [self cos:job user2:resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openDataBase
{
    NSString *path = @"文件路径/data/job_resume.db";
    _jobDB = [FMDatabase databaseWithPath:path];
    if ( ![_jobDB open] ) {
        NSLog(@"open membersDB failed");
        return;
    }
    
    [self readJobTable];
    [self readResumeTable];
}

-(void)readJobTable
{
    @autoreleasepool {
        
        FMResultSet* resultSet = [_jobDB executeQuery: @"select * from job" ];
        
        int i = 0;
        // 逐行读取数据
        while ( [ resultSet next ] )
        {
            i++;
            JobInfo *job = [[JobInfo alloc] init];

            // 对应字段来取数据
            job.jobID = [ resultSet stringForColumn: @"jobID" ];
            job.jobTitle = [ resultSet stringForColumn: @"jobTitle" ];
            job.jobName = [ resultSet stringForColumn: @"jobName" ];
            job.jobMoney = [ resultSet stringForColumn: @"jobMoney" ];
            job.jobXueli = [ resultSet stringForColumn: @"jobXueli" ];
            job.jobJingyan = [ resultSet stringForColumn: @"jobJingyan" ];
            job.jobAddress = [ resultSet stringForColumn: @"jobAddress" ];
            job.jobRespons = [ resultSet stringForColumn: @"jobRespons" ];
            job.jobCompanyInfo = [ resultSet stringForColumn: @"companyInfo" ];
            job.jobKeyWords = [ resultSet stringForColumn: @"jobKeyWords" ];
            
            [_jobArray addObject:job];
        }
        NSLog( @"job________ %d",i);
    }
}

-(void)readResumeTable
{
    @autoreleasepool {
        
        FMResultSet* resultSet = [_jobDB executeQuery: @"select * from resume" ];
        
        int i=0;
        // 逐行读取数据
        while ( [ resultSet next ] )
        {
            i++;
            ResumeInfo *resume = [[ResumeInfo alloc] init];
            
            // 对应字段来取数据
            resume.resumeName = [ resultSet stringForColumn: @"resumeName" ];
            resume.resumeID = [ resultSet stringForColumn: @"resumeID" ];
            resume.resumeTitle = [ resultSet stringForColumn: @"resumeTitle" ];
            resume.gongzuoDidian = [ resultSet stringForColumn: @"gongzuoDidian" ];
            resume.gongzuoNianxian = [ resultSet stringForColumn: @"gongzuoNianxian" ];
            resume.zhiyeQiwang = [ resultSet stringForColumn: @"zhiyeQiwang" ];
            resume.hangyeQiwang = [ resultSet stringForColumn: @"hangyeQiwang" ];
            resume.xueli = [ resultSet stringForColumn: @"xueli" ];
            resume.daxuezhuanye = [ resultSet stringForColumn: @"daxuezhuanye" ];
            resume.xinziQiwang = [ resultSet stringForColumn: @"xinziQiwang" ];
            resume.gongzuoJingli = [ resultSet stringForColumn: @"gongzuoJingli" ];
            resume.xiangmuJingli = [ resultSet stringForColumn: @"xiangmuJingli" ];
            resume.resumeKeywords = [ resultSet stringForColumn: @"resumeKeywords" ];
            
            [_resumeArray addObject:resume];
        }
        
        NSLog(@"resume ______%d",i);
    }

}

//计算余弦距离
-(ResultInfo*)cos:(JobInfo *)job user2:(ResumeInfo*)resume
{
    //公式               x1x2 + y1y2
    //     ----------------------------------
    //     根号(x1平方+y1平方)*根号(x2平方+y2平方)
    NSMutableArray *jobArray = [[NSMutableArray alloc] init];
    NSMutableArray *resumeArray = [[NSMutableArray alloc] init];
    NSArray *allArray;
    
/* 用单字解析真个句子
//    //解析job中所有字符
//    for ( int i=0 ; i<[job.jobName length]; i++) {
//        NSString *string1 = [job.jobName substringWithRange:NSMakeRange(i, 1)];
//        [jobArray addObject:string1];
//    }
//    //解析resume中所有字符
//    for ( int i=0 ; i<[resume.zhiyeQiwang length]; i++) {
//        NSString *string1 = [resume.zhiyeQiwang substringWithRange:NSMakeRange(i, 1)];
//        [resumeArray addObject:string1];
//    }
//    
 */
    //分词
    [jobArray addObjectsFromArray:[self stringTokenizerWithWord:job.jobRespons]];
    [resumeArray addObjectsFromArray:[self stringTokenizerWithWord:resume.xiangmuJingli]];
    
    
    NSMutableSet *jobSet = [NSMutableSet setWithArray:jobArray];
    NSMutableSet *resumeSet = [NSMutableSet setWithArray:resumeArray];
    NSMutableSet *allSet = [NSMutableSet setWithSet:jobSet];
    
    [allSet unionSet:resumeSet];
    allArray = allSet.allObjects;
    
    
    NSMutableArray *jobNum = [[NSMutableArray alloc] init];
    NSMutableArray *resumeNum = [[NSMutableArray alloc] init];
    
    for ( int i=0 ; i<[allArray count]; i++) {
        NSString *string = [allArray objectAtIndex:i];
        
        double sum = 0;
        for (int j=0; j<[jobArray count]; j++) {
            NSString *temp = [jobArray objectAtIndex:j];
            if ( [temp isEqualToString:string] ) {
                sum += 1;
            }
        }
        [jobNum addObject:[NSNumber numberWithDouble:sum]];
        
        sum = 0;
        for (int j=0; j<[resumeArray count]; j++) {
            NSString *temp = [resumeArray objectAtIndex:j];
            if ( [temp isEqualToString:string] ) {
                sum += 1;
            }
        }
        [resumeNum addObject:[NSNumber numberWithDouble:sum]];
    }
    
   
    //    开始计算余弦距离,计算sum即除数
    double sum = 0;
    for ( int i=0 ; i<[allArray count]; i++) {
        double number1 = [[jobNum objectAtIndex:i] doubleValue];
        double number2 = [[resumeNum objectAtIndex:i] doubleValue];
        sum += number1* number2;
//        NSLog(@" sum = %f_____%f_____%f",sum,number1,number2);
    }
    
    //计算job开根号
    double user1Result = 0;
    for (int i=0; i<[jobNum count]; i++) {
        double number = [[jobNum objectAtIndex:i] doubleValue];
        user1Result += number*number;
    }
    user1Result = sqrt(user1Result);
    
    double user2Result = 0;
    for (int i=0; i<[resumeNum count]; i++) {
        double number = [[resumeNum objectAtIndex:i] doubleValue];
        user2Result += number*number;
    }
    user2Result = sqrt(user2Result);
    
    double result1 = sum/(user1Result*user2Result);
//    NSLog(@"________%f",result1);
    
    ResultInfo *info = [[ResultInfo alloc] init];
    info.cosResult = result1;
    info.resume = resume;
    info.jobKeyWordArray = jobArray;
    info.resumeKeyWordArray = resumeArray;
    
    if ( [_resultArray count] < 21 ) {
        [_resultArray addObject:info];
    }else{
        int target = -1;
        for ( int i=0 ; i<[_resultArray count]; i++) {
            ResultInfo *temp = [_resultArray objectAtIndex:i];
            if ( info.cosResult > temp.cosResult ) {
                target = i;
                break;
            }
        }
        if ( target != -1 ) {
            [_resultArray replaceObjectAtIndex:target withObject:info];
        }
    }

   
    
    return nil;
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
