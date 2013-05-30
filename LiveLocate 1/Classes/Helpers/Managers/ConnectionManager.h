//
//  ConnectionManager.h
//  LiveLocate 1
//
//  Created by x5mobile on 5/29/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionManager : NSObject


// implemented
-(void)requestToServerWithRpDic:(NSMutableDictionary *)rpDict andRequestName:(NSString *)requestName_ andProcessKey:(NSString *)pk;

@end
