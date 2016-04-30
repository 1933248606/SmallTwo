//
//  Interface.m
//  sainty
//
//  Created by hhuai on 12/11/13.
//  Copyright (c) 2013 hhuai. All rights reserved.
//

#import "Interface.h"
#import "iosapi.h"
#import "SVProgressHUD.h"

@interface Interface()
@property (nonatomic,copy)InterfaceCallback cb;
@end

@implementation Interface

-(NSMutableDictionary *)setDevice:(NSDictionary *)map {
    NSMutableDictionary *umap = [NSMutableDictionary dictionaryWithDictionary:map];
    NSDictionary * userinfo = [Api loadRms:@"userinfo"];
    if(userinfo[@"_id"]){
        [umap setValue:userinfo[@"_id"]    forKey:@"userId"];
        
    }
    return umap;
}

+(Interface *)newInterface {
    return [[Interface alloc]init];
}

-(void)commCallBack:(JNetItem*)it{
	if(it.rcode==0){
        if (it.rmap[@"result"] && [it.rmap[@"result"] intValue]==0) {
            self.cb(nil,it.rmap);
        } else {
            self.cb(it.rmap[@"resultinfo"],it.rmap);
            if (it.rmap[@"resultinfo"]) {
                [SVProgressHUD showErrorWithStatus:it.rmap[@"resultinfo"]];
            }
        }
    } else {
        self.cb(it.errMsg,it.rmap);
        if (it.errMsg) {
            [SVProgressHUD showErrorWithStatus:it.errMsg];
        }
    }
}

-(void)call:(NSString *)commName umap:(NSDictionary *)umap finish:(InterfaceCallback)finish {
    self.cb = finish;
    JNetItem * it=[JNetItem new];
    it.target=JTargetMake(self, @selector(commCallBack:));
    [it setComm:commName data:[self setDevice:umap]];
    [JNet addItem:it];
}

@end