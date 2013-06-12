//
//  ConnectionManager.h
//  LiveLocate 1
//
//  Created by x5mobile on 5/29/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionDelegate 

- (void)requestDidFinishLoadWithDataIn:(NSDictionary *)dataIn andRquestName:(NSString *)requestName andTransactionStatus:(BOOL)status;
- (void)requestRequestTimeOutWithRquestName:(NSString *)requestName andRequestToolsIn:(NSMutableDictionary*)requestToolsIn;

@end

@interface ConnectionManager : NSObject

@property (nonatomic,assign) id <ConnectionDelegate> delegate;
-(void)requestToServerWithRpDic:(NSMutableDictionary *)rpDict andRequestName:(NSString *)requestName_ andProcessKey:(NSString *)pk;

@end
