//
//  QYUser.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/19.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionModel.h"

typedef enum {
    SexMale,
    SexFemale
}Sex;
@interface QYUser : NSObject
@property(copy,nonatomic)NSString *username;
@property(copy,nonatomic)NSString *psw;
@property(copy,nonatomic)NSString *confirmpsw;
@property(copy,nonatomic)NSString *verification;

@property(nonatomic,copy)NSString *userId,*address,*info,*sex,*email,*business,*companyName,*link,*age;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,retain)NSData *imgdata;
@property(nonatomic,retain)NSDictionary *ProvinceDic;

@end




