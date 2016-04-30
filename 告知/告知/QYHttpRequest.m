//
//  QYHttpRequest.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/19.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "QYHttpRequest.h"
#import "Interface.h"
#import "Tool_h.h"
#import <MJExtension.h>

@implementation QYHttpRequest
{
    Interface *interface;
}
//获取验证码
+(void)requestToGetGainWithUser:(QYUser*)user
{
    NSMutableDictionary *umap = [NSMutableDictionary dictionary];
    [umap setObject:user.username forKey:@"phone"];
    [[Interface newInterface]call:@"sendMsg" umap:umap finish:^(NSString *error, NSDictionary *value) {
        
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        if ([value[@"status"]intValue] == 0) {
            NSLog(@"%@",[value[@"info"]copy]);
        }
    }];

}
//注册请求
+(void)requestToRegisteWithUser:(QYUser*)user
{
    
    NSMutableDictionary *umap = [NSMutableDictionary dictionary];
    
    [umap setObject:user.username forKey:@"phone"];
    [umap setObject:user.psw forKey:@"password"];
    [umap setObject:user.verification forKey:@"verify_code"];
    [[Interface newInterface]call:@"registry" umap:umap finish:^(NSString *error, NSDictionary *value) {
                
        if (error) {
            NSString *errorStr = [value valueForKey:@"info"];
            NSLog(@"error:%@",errorStr);
            NSLog(@"注册失败");
            return ;
        }
        if ([value[@"status"]intValue] == 0) {
            NSString *errorStr = [value valueForKey:@"info"];
            NSLog(@"error:%@",errorStr);

        }
    }];
    

}
//登录请求
/*
umap中的key值 
*/
+(void)requestToLoginWithUser:(QYUser*)user completion:(void(^)(NSString * error,BOOL isSuccess))complete
{
    NSMutableDictionary *umap = [NSMutableDictionary dictionary];
    [umap setObject:user.username forKey:@"phone"];
    [umap setObject:user.psw forKey:@"password"];
    [[Interface newInterface]call:@"login" umap:umap finish:^(NSString *error, NSDictionary *value) {
        NSLog(@"%@",value);
        if (error) {
            NSString *errorStr = [value valueForKey:@"info"];
            NSLog(@"error:%@",errorStr);
            NSLog(@"注册失败");
            return ;
        }
        if ([value[@"status"]intValue] == 0) {
            NSString *userID = value[@"data"][@"userId"];
            
            NSString *phone = value[@"data"][@"phone"];
    
            NSString *create_time = value[@"data"][@"create_time"];
            [[NSUserDefaults standardUserDefaults]setValue:userID forKey:UserId];
            [[NSUserDefaults standardUserDefaults]setValue:phone forKey:@"phone"];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[create_time longLongValue]];
            [[NSUserDefaults standardUserDefaults]setValue:date forKey:@"create_time"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }];

}
//修改登录密码
+(void)requestModifyPassword:(QYUser*)user
{
    NSMutableDictionary *ump = [NSMutableDictionary dictionary];
    [ump setObject:user.username forKey:@"phone"];
    [ump setObject:user.verification forKey:@"verify_code"];
    [ump setObject:user.psw forKey:@"password"];
    [[Interface newInterface]call:@"updateLoginPwd" umap:ump finish:^(NSString *error, NSDictionary *value) {
        NSLog(@"%@",value[@"info"]);
    }];
}
//上传头像
+(void)uploadUserHeadPic:(QYUser*)user completion:(void(^)(NSString * error,BOOL isSuccess))complete
{

    NSMutableDictionary *umap = [NSMutableDictionary dictionary];
    [umap setObject:user.userId forKey:@"userId"];
    [umap setObject:user.type forKey:@"type"];
    [umap setObject:user.imgdata forKey:@"file"];
    [[Interface newInterface]call:@"upload" umap:umap finish:^(NSString *error, NSDictionary *value) {
        NSLog(@"返回值%@",value[@"info"]);
    }];
}
//登录判断
+(BOOL)isNeedLogin
{
    NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
    NSDate * date = [[NSUserDefaults standardUserDefaults]valueForKey:@"create_time"];
    NSDate * now = [NSDate date];
    BOOL result = [date compare:now];
    if (userId && result == NSOrderedDescending)
    {
        return  NO;
    }

    return YES;
}
//修改用户信息
+(void)requestModifyUserInfo:(QYUser*)user  WithBlock:(void(^)(NSArray *dataArray))complete
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:user.userId forKey:@"userId"];
    [userInfo setObject:user.username forKey:@"userName"];
    [userInfo setObject:user.address forKey:@"addresss"];
    [userInfo setObject:user.sex forKey:@"sex"];
    [userInfo setObject:user.age forKey:@"age"];
    [userInfo setObject:user.address forKey:@"address"];
    [userInfo setObject:user.business forKey:@"business"];
    [userInfo setObject:user.info forKey:@"info"];
    [userInfo setObject:user.link forKey:@"link"];
    [userInfo setObject:user.email forKey:@"email"];
    [userInfo setObject:user.companyName forKey:@"companyName"];
    [[Interface newInterface]call:@"updateUser" umap:userInfo finish:^(NSString *error, NSDictionary *value) {
        
    }];
   
    
}
//获取每个省的信息
+(void)requestProvinceInfo:(void(^)(NSArray *dataArray))complete
{
    NSMutableArray *ProvinceArr = [NSMutableArray array];
    [[Interface newInterface]call:@"getProvince" umap:nil finish:^(NSString *error, NSDictionary *value) {
        NSArray *provinceArr = [NSArray array];
        provinceArr = value[@"data"];
        for (int i = 0; i < provinceArr.count; i++) {
            NSDictionary * dic = provinceArr[i];
            RegionModel *region = [RegionModel mj_objectWithKeyValues:dic];
            [ProvinceArr addObject:region.name];
        }

        if (complete) {
            complete(ProvinceArr);
            
        }
    }];
}
//获取每个市的信息
+(void)requestCityInfo:(RegionModel*)regionmodel WithBlock:(void(^)(NSArray *dataArray))complete
{
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableDictionary *cityDic = [NSMutableDictionary dictionary];
    [cityDic setObject:regionmodel.ProID forKey:@"ProID"];
    [[Interface newInterface]call:@"getCity" umap:cityDic finish:^(NSString *error, NSDictionary *value) {
        NSArray *array = value[@"data"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = array[i];
            CitysModel *model = [CitysModel mj_objectWithKeyValues:dic];
            [resultArr addObject:model.name];
            NSLog(@"%@",model.name);
        }
        if (complete) {
            complete(resultArr);
        }
}];
}
//查询个人信息
+(void)queryPersonInfo:(QYUser*)user WithBlock:(void(^)(NSArray *dataArray))complete
{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:user.userId forKey:@"userId"];
    [[Interface newInterface]call:@"queryUser" umap:mutableDic finish:^(NSString *error, NSDictionary *value) {
        NSMutableArray *mutableArr = [NSMutableArray array];
        NSDictionary *userDic = value[@"data"];
        QueryUserInfo *querymodel = [QueryUserInfo mj_objectWithKeyValues:userDic];
        querymodel.age = [NSString stringWithFormat:@"%@",value[@"data"][@"age"]];
        querymodel.points = [NSString stringWithFormat:@"%@",value[@"data"][@"points"]];
        [mutableArr addObject:querymodel];
        NSString *str = [NSString stringWithFormat:@"%@",querymodel.userName];
        [[NSUserDefaults standardUserDefaults]setValue:str forKey:USERNAME];
        NSString *pointsStr = [NSString stringWithFormat:@"%@",querymodel.points];
        [[NSUserDefaults standardUserDefaults]setValue:pointsStr forKey:POINTS];
        NSLog(@"查询个人信息%@",pointsStr);
        if (complete) {
            complete(mutableArr);
        }

    }];
}
//分页查询我关注的人
+(void)queryMyfocusInfo:(QYUser*)user;
{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:user.userId forKey:@"userId"];
    [[Interface newInterface]call:@"queryFocus" umap:mutableDic finish:^(NSString *error, NSDictionary *value) {
        NSLog(@"%@",value[@"info"]);
    }];

}
//分页获取我的粉丝
+(void)queryMyfansInfo:(QYUser*)user
{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:user.userId forKey:@"userId"];
    [[Interface newInterface]call:@"queryFans" umap:mutableDic finish:^(NSString *error, NSDictionary *value) {
        NSLog(@"%@",value);
    }];

}
//商家认证
+(void)merchantOfcertification:(MerchantModel*)merchant
{
    NSMutableDictionary *merchantDic = [NSMutableDictionary dictionary];
    [merchantDic setObject:merchant.userId forKey:@"userId"];
    [merchantDic setObject:merchant.lawyer_name forKey:@"lawyer_name"];
    [merchantDic setObject:merchant.merchantName forKey:@"merchantName"];
    [merchantDic setObject:merchant.business_license_photo forKey:@"business_license_photo"];
    [merchantDic setObject:merchant.baseAddress forKey:@"baseAddress"];
    [merchantDic setObject:merchant.merchantBusiness forKey:@"merchantBusiness"];
    [merchantDic setObject:merchant.merchantPhone forKey:@"merchantPhone"];
    [merchantDic setObject:merchant.merchantInfo forKey:@"merchantInfo"];
    [merchantDic setObject:merchant.merchantAddress forKey:@"merchantAddress"];
    [[Interface newInterface]call:@"merchant" umap:merchantDic finish:^(NSString *error, NSDictionary *value) {
        NSLog(@"%@",value[@"info"]);
    }];
}
@end
