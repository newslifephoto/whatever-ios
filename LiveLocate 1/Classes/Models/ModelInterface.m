//
//  ModelInterface.m
//  LiveLocate 1
//
//  Created by x5mobile on 5/27/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import "ModelInterface.h"

@interface ModelInterface (Private)

///// connection property
@property (nonatomic,strong) NSMutableData * responseData;
@property (nonatomic,strong) NSURLConnection * requestConn;
@property (nonatomic,strong) NSMutableDictionary * dictResponse;
@property (nonatomic,strong) NSMutableArray * connectionsRequesting;
//// connection Method
- (NSMutableDictionary *)requestToolsFactoryWithRequestName:(NSString *)requestName;
- (NSDictionary *)requestToolsFactoryWithRequestName:(NSString *)requestName andRequestConnection:(NSURLConnection *)requestConn_;
-(NSMutableDictionary *)requestToolsFactoryWithRequestConnection:(NSURLConnection *)requestConn_;
////
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connectionDidFinishLoading:(NSURLConnection*)connection;
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse;
- (void)conection:(NSURLConnection *)connection didFailWithError:(NSError*)error;
- (void)checkIsTimeout:(NSTimer*)theTimer;
////

@end

@implementation ModelInterface

#pragma mark - Connection Method




@end
