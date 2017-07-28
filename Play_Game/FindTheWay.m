//
//  FindHTMLWord.m
//  Play_Game
//
//  Created by 安昌 on 2017/3/20.
//  Copyright © 2017年 安昌. All rights reserved.
//

#import "FindTheWay.h"
#import "TFHpple.h"
#import <objc/objc.h>
#import "FMDB.h"

//将Html读入数据库的类

@interface FindTheWay ()

@property(nonatomic,strong) FMDatabase *jobDB;

@end

@implementation FindTheWay

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.jobInfo = [[JobInfo alloc] init];
    self.resumeInfo = [[ResumeInfo alloc] init];
    [self createDataBase];
//    [self loadAllJobFile];
    [self loadAllResumeFile];
}

-(void)createJobTable
{
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'",@"job"];
    FMResultSet *rs = [_jobDB executeQuery:existsSql];
    if ( [rs next] ) {
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count:%li",count);
        if ( count >= 1 ) {
            NSLog(@"job table is existed");
            return;
        }
        NSLog(@"job table is not exist");
        [_jobDB executeUpdate:@"CREATE TABLE job (jobID text,jobTitle text,jobName text,jobMoney text,jobXueli text,jobJingyan text ,jobAddress text, jobRespons text,companyInfo text,jobKeyWords text)"];
    }
    [rs close];
}

-(void)createResumeTable
{
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'",@"resume"];
    FMResultSet *rs = [_jobDB executeQuery:existsSql];
    if ( [rs next] ) {
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count:%li",count);
        if ( count >= 1 ) {
            NSLog(@"resume table is existed");
            return;
        }
        NSLog(@"resume table is not exist");
        [_jobDB executeUpdate:@"CREATE TABLE resume (resumeName text,resumeID text,resumeTitle text,gongzuoDidian text,gongzuoNianxian text,zhiyeQiwang text,hangyeQiwang text,xueli text ,daxuezhuanye text, xinziQiwang text,gongzuoJingli text,xiangmuJingli text,resumeKeywords text)"];
    }
    [rs close];
}

#pragma warning - 注意这里需要修改读取的路径

-(void)createDataBase
{
    NSString *path = @"文件路径/data/job_resume.db";
    _jobDB = [FMDatabase databaseWithPath:path];
    if ( ![_jobDB open] ) {
        NSLog(@"open membersDB failed");
        return;
    }
    [self createJobTable];
    [self createResumeTable];
}

-(void)loadAllJobFile
{
    @autoreleasepool {
        NSString *jobDirPath = @"文件路径/data/job";
        NSFileManager* fileMgr = [NSFileManager defaultManager];
        NSArray* jobArray = [fileMgr contentsOfDirectoryAtPath:jobDirPath error:nil];
        
        for (int i=0; i<[jobArray count]; i++) {
            NSString *path = [jobArray objectAtIndex:i];
            [self readJobStringFromFile:path dir:jobDirPath];
        }
    }

}

-(void)loadAllResumeFile
{
    @autoreleasepool {
        NSString *resumeDirPath = @"文件路径/data/resume";
        NSFileManager* fileMgr = [NSFileManager defaultManager];
        NSArray* resumeArray = [fileMgr contentsOfDirectoryAtPath:resumeDirPath error:nil];
        
        for (int i=0; i<[resumeArray count]; i++) {
            NSString *path = [resumeArray objectAtIndex:i];
            if ( [path isEqualToString:@"4978500.html"]     //测试候选人
                || [path isEqualToString:@"4978621.html"]    //精华候选人
                ) {
                continue;
            }
            self.resumeInfo.resumeName = path;
//            NSLog(@"______path = %@",path);
            [self readResumeStringFromFile:path dir:resumeDirPath];
        }
        
        //测试使用
//        NSString *path = @"4978621.html";//[resumeArray objectAtIndex:0];
//        self.resumeInfo.resumeName = path;
//        [self readResumeStringFromFile:path dir:resumeDirPath];
    }

}

-(void)readResumeStringFromFile:(NSString*)path dir:(NSString*)dirPath
{
    NSData *fileData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dirPath,path]];
    TFHpple *parser = [[TFHpple alloc] initWithHTMLData:fileData encoding:nil];
    NSArray *array = [parser searchWithXPathQuery:@"//body"];
    TFHppleElement *result = [array objectAtIndex:0];
//    NSLog(@"___________%@",result.content);
    if( [result.content rangeOfString:@"精华候选人"].length != 0 ){
        //如果是精华候选人，则跳过
        return;
    }
    
    for (int i=0; i<[result.children count]; i++) {
        TFHppleElement *temp = [result.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    
    TFHppleElement *result_3 = [result.children objectAtIndex:3];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_3 = [result_3.children objectAtIndex:3];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_3 = [result_3.children objectAtIndex:13];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_3 = [result_3.children objectAtIndex:5];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_3 = [result_3.children objectAtIndex:1];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_3 = [result_3.children objectAtIndex:17];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    //所有简历相关信息 0.简历编号，经验，地址等基础信息， 1.期望薪资，期望职位，到岗时间 2.教育经历 3.工作经历 4.项目经验 5.自我评价
    BOOL has[6];
    NSArray *arrayN = @[@"简历编号",@"期望行业,期望职位,求职方向,期望薪资,到岗时间",@"教育经历",@"工作经历",@"项目经验",@"自我评价"];
    int j = 0;
    for (int i=0; i<6; i++) {
        has[i] = NO;
    }
    
    result_3 = [result_3.children objectAtIndex:0];
    for (int i=0; i<[result_3.children count]; i++) {
        TFHppleElement *temp = [result_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( j<6 ) {
            NSString *string = [arrayN objectAtIndex:j];
            NSArray *array = [string componentsSeparatedByString:@","];
            
            for ( int k=0 ; k<[array count]; k++) {
                NSString *finalString = [array objectAtIndex:k];
                if ( [temp.content rangeOfString:finalString].length != 0 ) {
                    has[j] = YES;
                }
            }
            if ( has[j] == YES ) {
                j++;
            }
        }
    }
//    //1为简历编号，更新时间
//    //2为应聘人员基础信息杨先生JAVA 男 | 未婚 | 25岁 | 1991年12月 | 本科 | 国籍：中国 | 群众工作经验：6年工作经验 现居住地：北京-海淀区 如需联络方式，仅需2块狗粮即可解锁立即解锁
    if ( has[0] ) {
        [self getResumeIDAndPersonInfo:result_3];
    }
    
    //0为求职方向
    //1为期望地点：北京期望职位：高级软件工程师、软件工程师期望行业：计算机软件期望薪资：15000-19999元/月到岗时间：1周内
    if ( has[1] ) {
         [self getQiWang:result_3];
    }

   
    //0______教育经历
    //1______2007/9--2011/7北京工商学院计算机科学本科
    if ( has[2] ) {
        [self getJiaoYu:result_3];
    }

    
    if ( has[3] ) {
        [self getGongZuoJingLi:result_3];
    }

    
    if ( has[4] ) {
        [self getXiangMuJingLi:result_3];
    }

    
    
    [self.resumeInfo cleanUpInfo];
    [self writhResumeInfo];

}

-(void)getXiangMuJingLi:(TFHppleElement *)element
{
    TFHppleElement *result_Info = [element.children objectAtIndex:4];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( i==1 ) {
            self.resumeInfo.xiangmuJingli = temp.content;
        }
        
    }
}

-(void)getGongZuoJingLi:(TFHppleElement *)element
{
    TFHppleElement *result_Info = [element.children objectAtIndex:3];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( i==1 ) {
            self.resumeInfo.gongzuoJingli = temp.content;
        }

    }
}

-(void)getJiaoYu:(TFHppleElement *)element
{
    //0______教育经历
    //1______2007/9--2011/7北京工商学院计算机科学本科
    TFHppleElement *result_Info = [element.children objectAtIndex:2];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);

    }
    result_Info = [result_Info.children objectAtIndex:1];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
//        if ( i==1 ) {
//            self.resumeInfo.xueli = temp.content;
//        }
    }
    //0______2007/9--2011/7
    //1______北京工商学院
    //2______计算机科学
    //3______本科
    result_Info = [result_Info.children objectAtIndex:0];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( i==2 ) {
            self.resumeInfo.daxuezhuanye = temp.content;
        }
        if ( i==3 ) {
            self.resumeInfo.xueli = temp.content;
        }
    }
}

-(void)getQiWang:(TFHppleElement *)element
{
    //0为求职方向
    //1为期望地点：北京期望职位：高级软件工程师、软件工程师期望行业：计算机软件期望薪资：15000-19999元/月到岗时间：1周内
    TFHppleElement *result_Info = [element.children objectAtIndex:1];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    //0______期望地点：北京
    //1______期望职位：高级软件工程师、软件工程师
    //2______期望行业：计算机软件
    //3______期望薪资：15000-19999元/月
    //4______到岗时间：1周内
    result_Info = [result_Info.children objectAtIndex:1];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( [temp.content rangeOfString:@"期望职位"].length != 0 ) {
            self.resumeInfo.zhiyeQiwang = temp.content;
        }
        if ( [temp.content rangeOfString:@"期望行业"].length != 0) {
            self.resumeInfo.hangyeQiwang = temp.content;
        }
        if ( [temp.content rangeOfString:@"期望薪资"].length != 0 ) {
            self.resumeInfo.xinziQiwang = temp.content;
        }
    }
}

-(void)getResumeIDAndPersonInfo:(TFHppleElement *)element
{
    //1为简历编号，更新时间
    //2为应聘人员基础信息杨先生JAVA 男 | 未婚 | 25岁 | 1991年12月 | 本科 | 国籍：中国 | 群众工作经验：6年工作经验 现居住地：北京-海淀区 如需联络方式，仅需2块狗粮即可解锁立即解锁
    TFHppleElement *result_Info = [element.children objectAtIndex:0];
    for (int i=0; i<[result_Info.children count]; i++) {
        TFHppleElement *temp = [result_Info.children objectAtIndex:i];
        //        NSLog(@"______%d______%@",i,temp.content);
    }
    
    TFHppleElement *result_ID = [result_Info.children objectAtIndex:1];
    for (int i=0; i<[result_ID.children count]; i++) {
        TFHppleElement *temp = [result_ID.children objectAtIndex:i];
        //        NSLog(@"______%d______%@",i,temp.content);
    }
    //0为简历编号   1为更新时间
    result_ID = [result_ID.children objectAtIndex:1];
    for (int i=0; i<[result_ID.children count]; i++) {
        TFHppleElement *temp = [result_ID.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( i == 0 ) {
            self.resumeInfo.resumeID = temp.content;
        }
    }
    
    TFHppleElement *result_preson = [result_Info.children objectAtIndex:2];
    for (int i=0; i<[result_preson.children count]; i++) {
        TFHppleElement *temp = [result_preson.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_preson = [result_preson.children objectAtIndex:0];
    for (int i=0; i<[result_preson.children count]; i++) {
        TFHppleElement *temp = [result_preson.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    result_preson = [result_preson.children objectAtIndex:0];
    for (int i=0; i<[result_preson.children count]; i++) {
        TFHppleElement *temp = [result_preson.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( i==0 ) {
            self.resumeInfo.resumeTitle = temp.content;
        }
    }
    
    result_preson = [result_preson.children objectAtIndex:3];
    for (int i=0; i<[result_preson.children count]; i++) {
        TFHppleElement *temp = [result_preson.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
        if ( i == 2 ) {
            self.resumeInfo.gongzuoDidian = temp.content;
        }
        if ( i == 0 ) {
            self.resumeInfo.gongzuoNianxian = temp.content;
        }
    }

}

-(void)readJobStringFromFile:(NSString*)path dir:(NSString*)jobDirPath
{
   
//    NSLog(@"_________%@",jobArray);
    
//    NSString *resumePath = @"文件路径/data/resume";
//    NSArray* resumeArray = [fileMgr contentsOfDirectoryAtPath:resumePath error:nil];
//    NSLog(@"_________%@",resumeArray);
    
    
    self.jobInfo.jobID = path;
    NSData *fileData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",jobDirPath,path]];
    TFHpple *parser = [[TFHpple alloc] initWithHTMLData:fileData encoding:nil];
    NSArray *array = [parser searchWithXPathQuery:@"//body"];
    TFHppleElement *result = [array objectAtIndex:0];
//    NSLog(@"%s",object_getClassName(result));
//    NSLog(@"_______%@",result.content);
//    NSLog(@"_________%d",[result.children count]);
//    NSString *unicodeString = [NSString stringWithCString:[string UTF8String] encoding:NSUnicodeStringEncoding];
//    NSLog(@"_________%@",unicodeString);
    
    TFHppleElement *result_5 = [result.children objectAtIndex:5];
    for (int i=0; i<[result_5.children count]; i++) {
        TFHppleElement *temp = [result_5.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
    }
    TFHppleElement *result_5_2 = [result_5.children objectAtIndex:1];
//    for (int i=0; i<[result_5_2.children count]; i++) {
//        TFHppleElement *temp = [result_5_2.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
//    }
    
    TFHppleElement *result_5_2_3 = [result_5_2.children objectAtIndex:3];
//    for (int i=0; i<[result_5_2_3.children count]; i++) {
//        TFHppleElement *temp = [result_5_2_3.children objectAtIndex:i];
//        NSLog(@"______%d______%@",i,temp.content);
//    }
    
    //3为职位基础信息，7为任职要求，11为公司信息
    //1为招聘标题，5为职位简介
    TFHppleElement *result_5_2_3_3 = [result_5_2_3.children objectAtIndex:3];
    for (int i=0; i<[result_5_2_3_3.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_3.children objectAtIndex:i];
//        NSLog(@"___333___%d______%@_____%@",i,temp.content,temp.attributes);
        if ( i == 1 ) {
            self.jobInfo.jobTitle = temp.content;
        }
    }
    TFHppleElement *result_5_2_3_3_5 = [result_5_2_3_3.children objectAtIndex:5];
    for (int i=0; i<[result_5_2_3_3_5.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_3_5.children objectAtIndex:i];
//        NSLog(@"___3335555___%d______%@_____%@",i,temp.content,temp.attributes);
    }
    //1为营销bd  3为月薪4000 5为高中/中专/中技    7为最低1年工作经验  9为朝阳区
    TFHppleElement *result_5_2_3_3_51 = [result_5_2_3_3_5.children objectAtIndex:1];
    for (int i=0; i<[result_5_2_3_3_51.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_3_51.children objectAtIndex:i];
//        NSLog(@"___33355551111___%d______%@_____%@",i,temp.content,temp.attributes);
        switch(i)
        {
            case 1:
                self.jobInfo.jobName = temp.content;
                break;
            case 3:
                self.jobInfo.jobMoney = temp.content;
                break;
            case 5:
                self.jobInfo.jobXueli = temp.content;
                break;
            case 7:
                self.jobInfo.jobJingyan = temp.content;
                break;
            case 9:
                self.jobInfo.jobAddress = temp.content;
                break;
            default:
                break;
        }
    }

    //1为"任职要求"字段，3为岗位职责
    TFHppleElement *result_5_2_3_7 = [result_5_2_3.children objectAtIndex:7];
    for (int i=0; i<[result_5_2_3_7.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_7.children objectAtIndex:i];
//        NSLog(@"___777___%d______%@",i,temp.content);
        if ( i == 3 ) {
            self.jobInfo.jobRespons = temp.content;
        }
    }
    //1为"公司信息"字段，5为公司信息详情
    TFHppleElement *result_5_2_3_11 = [result_5_2_3.children objectAtIndex:11];
    for (int i=0; i<[result_5_2_3_11.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_11.children objectAtIndex:i];
//        NSLog(@"___1111___%d______%@",i,temp.content);
       
    }
    //获取公司信息详情
    TFHppleElement *result_5_2_3_11_5 = [result_5_2_3_11.children objectAtIndex:5];
    for (int i=0; i<[result_5_2_3_11_5.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_11_5.children objectAtIndex:i];
//                NSLog(@"___1111dddddd___%d______%@",i,temp.content);
    }
    //获取公司信息详情 1为人员规模   3为公司福利
    TFHppleElement *result_5_2_3_11_51 = [result_5_2_3_11_5.children objectAtIndex:1];
    for (int i=0; i<[result_5_2_3_11_51.children count]; i++) {
        TFHppleElement *temp = [result_5_2_3_11_51.children objectAtIndex:i];
        if ( i == 1 ) {
            self.jobInfo.jobCompanyInfo = temp.content;
        };
    }
    
    [_jobInfo cleanUpInfo];
    [self writeJobInfo];
}

-(void)writhResumeInfo
{
    //resume (resumeID text,resumeTitle text,gongzuoDidian text,gongzuoNianxian text,zhiyeQiwang text,hangyeQiwang text,xueli text ,daxuezhuanye text, xinziQiwang text,gongzuoJingli text,xiangmuJingli text,resumeKeywords text)"];
    BOOL success = [_jobDB executeUpdate:@"INSERT INTO resume (resumeName,resumeID ,resumeTitle ,gongzuoDidian ,gongzuoNianxian ,zhiyeQiwang ,hangyeQiwang ,xueli  ,daxuezhuanye , xinziQiwang ,gongzuoJingli ,xiangmuJingli ,resumeKeywords ) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)",_resumeInfo.resumeName,_resumeInfo.resumeID,_resumeInfo.resumeTitle,_resumeInfo.gongzuoDidian,_resumeInfo.gongzuoNianxian,_resumeInfo.zhiyeQiwang,_resumeInfo.hangyeQiwang,_resumeInfo.xueli,_resumeInfo.daxuezhuanye,_resumeInfo.xinziQiwang,_resumeInfo.gongzuoJingli,_resumeInfo.xiangmuJingli,_resumeInfo.resumeKeywords];
//    NSLog(@"_____success = %d",success);
}

-(void)writeJobInfo
{
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO job(jobID,jobTitle,jobName,jobMoney,jobXueli,jobJingyan,jobAddress, jobRespons,companyInfo,jobKeyWords) VALUES(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)",@"222",@"222",@"222",@"222",@"222",@"222",@"222",@"222",@"222",@"222"];
//     BOOL success = [_jobDB executeUpdate:sql];
    BOOL success = [_jobDB executeUpdate:@"INSERT INTO job (jobID,jobTitle,jobName,jobMoney,jobXueli,jobJingyan,jobAddress, jobRespons,companyInfo,jobKeyWords) VALUES(?,?,?,?,?,?,?,?,?,?)",_jobInfo.jobID,_jobInfo.jobTitle,_jobInfo.jobName,_jobInfo.jobMoney,_jobInfo.jobXueli,_jobInfo.jobJingyan,_jobInfo.jobAddress,_jobInfo.jobRespons,_jobInfo.jobCompanyInfo,_jobInfo.jobKeyWords];
    
//    NSLog(@"_____success = %d______%@__________%@",success,self.jobInfo.jobRespons,self.jobInfo.jobCompanyInfo);
}

@end
