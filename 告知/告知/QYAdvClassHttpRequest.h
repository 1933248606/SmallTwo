//
//  QYAdvClassHttpRequest.h
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/26.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicAdvModel.h"
#import "VideoModel.h"
@interface QYAdvClassHttpRequest : NSObject
//广告分类
+(void)requestQueryClassify:(void(^)(NSArray *dataArray))complete;
//发布图文广告
+(void)requestReleaseGraphic:(GraphicAdvModel*)advModel;
//发布视频广告
+(void)requestReleaseVideo:(VideoModel*)videoModel;
@end
