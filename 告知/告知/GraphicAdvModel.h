//
//  GraphicAdvModel.h
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/28.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphicAdvModel : NSObject
@property(nonatomic,copy)NSString *userId,*ad_title,*ad_content,*end_time,*area,*classifyId,*ad_logo;
@property(nonatomic,assign)int require_count;
@property(nonatomic,assign)double ad_price;
@property(nonatomic,strong)NSArray *shopLink;
@end
