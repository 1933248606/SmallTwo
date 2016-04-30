//
//  QYHttpRequest.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/19.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYUser.h"
#import "QueryUserInfo.h"
#import "MerchantModel.h"
#import "CitysModel.h"
@interface QYHttpRequest : NSObject
//获取验证码
+(void)requestToGetGainWithUser:(QYUser*)user;
//注册请求
+(void)requestToRegisteWithUser:(QYUser*)user;
//登录请求
+(void)requestToLoginWithUser:(QYUser*)user completion:(void(^)(NSString * error,BOOL isSuccess))complete;
//修改登录密码
+(void)requestModifyPassword:(QYUser*)user;
//登录判断
+(BOOL)isNeedLogin;
//上传用户头像
+(void)uploadUserHeadPic:(QYUser*)user completion:(void(^)(NSString * error,BOOL isSuccess))complete;
//修改用户信息
+(void)requestModifyUserInfo:(QYUser*)user  WithBlock:(void(^)(NSArray *dataArray))complete;
//获得全国各个省的信息
+(void)requestProvinceInfo:(void(^)(NSArray *dataArray))complete;
//获得每个市的信息
+(void)requestCityInfo:(RegionModel*)region WithBlock:(void(^)(NSArray *dataArray))complete;
//查询个人信息
+(void)queryPersonInfo:(QYUser*)user WithBlock:(void(^)(NSArray *dataArray))complete;
//分页查询我关注的人
+(void)queryMyfocusInfo:(QYUser*)user;
//分页获取我的粉丝
+(void)queryMyfansInfo:(QYUser*)user;
//商家认证
+(void)merchantOfcertification:(MerchantModel*)merchant;




@end
