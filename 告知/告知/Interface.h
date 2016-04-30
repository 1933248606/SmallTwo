//
//  Interface.h
//  sainty
//
//  Created by hhuai on 12/11/13.
//  Copyright (c) 2013 hhuai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^InterfaceCallback)(NSString *error, NSDictionary* value);

@interface Interface : NSObject

+(Interface *)newInterface;
-(void)call:(NSString *)commName umap:(NSDictionary *)umap finish:(InterfaceCallback)finish;
@end
