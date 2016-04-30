//
//  QYAdvClassHttpRequest.m
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/26.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "QYAdvClassHttpRequest.h"
#import "Interface.h"
#import <MJExtension.h>
#import "AdvClassifyModel.h"
@implementation QYAdvClassHttpRequest
+(void)requestQueryClassify:(void(^)(NSArray *dataArray))complete
{
    NSMutableArray *mutableArr = [NSMutableArray array];
    [[Interface newInterface]call:@"queryClassify" umap:nil finish:^(NSString *error, NSDictionary *value) {
        NSArray *array = [NSArray array];
        array = value[@"data"];
        for (int i = 0; i <array.count; i++) {
            NSDictionary *advDic = array[i];
            AdvClassifyModel *model = [AdvClassifyModel mj_objectWithKeyValues:advDic];
            [mutableArr addObject:model.classifyName];
        }
        if (complete) {
            complete(mutableArr);
        }
    }];

}
//发布图文广告
+(void)requestReleaseGraphic:(GraphicAdvModel*)advModel
{
    NSMutableDictionary *ump = [NSMutableDictionary dictionary];
    [ump setObject:advModel.userId forKey:@"userId"];
    [ump setObject:advModel.ad_title forKey:@"ad_title"];
    [ump setObject:advModel.ad_content forKey:@"ad_content"];
    NSNumber *num = [NSNumber numberWithDouble:advModel.ad_price];
    [ump setValue:num forKey:@"ad_price"];
    NSNumber *requireNum = [NSNumber numberWithInt:advModel.require_count];
    [ump setValue:requireNum forKey:@"require_count"];
    [ump setObject:advModel.end_time forKey:@"end_time"];
    [ump setObject:advModel.area forKey:@"area"];
    [ump setObject:advModel.classifyId forKey:@"classifyId"];
    [ump setObject:advModel.ad_logo forKey:@"ad_logo"];
    [ump setObject:advModel.shopLink forKey:@"shopLink"];
    [[Interface newInterface]call:@"teletextAd" umap:ump finish:^(NSString *error, NSDictionary *value) {
        
    }];
    
}
//发布视频广告
+(void)requestReleaseVideo:(VideoModel*)videoModel
{
    NSMutableDictionary *ump = [NSMutableDictionary dictionary];
    [ump setObject:videoModel.userId forKey:@"userId"];
    [ump setObject:videoModel.ad_title forKey:@"ad_title"];
    [ump setObject:videoModel.ad_info forKey:@"ad_info"];
    NSNumber *num = [NSNumber numberWithDouble:videoModel.ad_price];
    [ump setValue:num forKey:@"ad_price"];
    NSNumber *requireNum = [NSNumber numberWithInt:videoModel.require_count];
    [ump setValue:requireNum forKey:@"require_count"];
    [ump setObject:videoModel.end_time forKey:@"end_time"];
    [ump setObject:videoModel.area forKey:@"area"];
    [ump setObject:videoModel.video_key forKey:@"video_key"];
    [ump setObject:videoModel.classifyId forKey:@"classifyId"];
    [ump setObject:videoModel.ad_logo forKey:@"ad_logo"];
    [ump setObject:videoModel.shopLink forKey:@"shopLink"];
    [[Interface newInterface]call:@"teletextAd" umap:ump finish:^(NSString *error, NSDictionary *value) {
        
    }];

}
@end
