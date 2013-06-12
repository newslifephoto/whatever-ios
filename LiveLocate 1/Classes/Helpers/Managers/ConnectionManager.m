//
//  ConnectionManager.m
//  LiveLocate 1
//
//  Created by x5mobile on 5/29/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import "ConnectionManager.h"
#import "ConnectionConstants.h"
@interface ConnectionManager (private)
@property (nonatomic,strong) NSMutableDictionary * requestToolsIn;
@property (nonatomic,strong) NSMutableData * responseData;
@property (nonatomic,strong) NSURLConnection * requestConn;
@property (nonatomic,strong) NSMutableDictionary * dictResponse;
@property (nonatomic,strong) NSMutableArray * connectionsRequesting;
// implemented
- (NSMutableDictionary *)requestToolsFactoryWithRequestName:(NSString *)
  requestName;
- (NSDictionary *)requestToolsFactoryWithRequestName:(NSString *)requestName
                                andRequestConnection:(NSURLConnection *)
  requestConn_;
- (NSMutableDictionary *)requestToolsFactoryWithRequestConnection:
  (NSURLConnection *)requestConn_;
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:
  (NSURLResponse *)response;
- (void)connectionDidFinishLoading:(NSURLConnection*)connection;
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse;
- (void)conection:(NSURLConnection *)connection didFailWithError:(NSError*)
  error;
- (void)checkIsTimeout:(NSTimer*)theTimer;
// implemented
- (NSString *)uuid;
@end

@implementation ConnectionManager

- (id)init
{
    self = [super init];
    if (self) {
        self.requestToolsIn = [[NSMutableDictionary alloc] init];
    }
    return self;
}


#pragma mark - request Method
- (void)requestToServerWithRpDic:(NSMutableDictionary *)rpDict
                  andRequestName:(NSString *)requestName_
                   andProcessKey:(NSString *)processKey
{
    NSString * sessionId;
    
    NSString * urlToRequest;
    NSMutableDictionary * requestToolIn =
    [self requestToolsFactoryWithRequestName:requestName_];
    NSString * uuid;
    NSData * JSONFromRequestProcess =
    [NSJSONSerialization dataWithJSONObject:rpDict
                                    options:NSJSONWritingPrettyPrinted
                                      error:nil];
    NSString * requestProcessString = [[NSString alloc]
                                       initWithData:JSONFromRequestProcess
                                           encoding:NSUTF8StringEncoding];
    NSString * rpStr = [NSString stringWithFormat:@"pk=%@&rp=%@&uk=%@&sk=%@"
                        ,processKey
                        ,requestProcessString
                        ,uuid
                        ,sessionId];
    NSLog(@"URL TEXT : %@?%@",urlToRequest,rpStr);
    NSString * urlString = urlToRequest;
    NSData* rpData = [rpStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request_ =
    [NSMutableURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                        timeoutInterval:20.0];
    [request_ setHTTPMethod:@"POST"];
    [request_ setHTTPBody:[rpStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * requestConn_ =
    [NSURLConnection connectionWithRequest:request_
                                  delegate:self];
    [self.connectionsRequesting addObject:requestConn_];
    [NSTimer scheduledTimerWithTimeInterval:20.0
                                     target:self
                                   selector:@selector(checkIsTimeout:)
                                   userInfo:requestName_
                                    repeats:NO];
    [requestToolIn setObject:requestConn_ forKey:kRequestConnection];
    [requestToolIn setObject:rpData forKey:kRequestProcess];
    [requestToolIn setObject:[NSNumber numberWithBool:NO]
                      forKey:kRequestStatus];
    [requestToolIn setObject:[NSNumber numberWithInt:1] forKey:kTimeToRequest];
}


#pragma mark - Factory Method
- (NSMutableDictionary *)requestToolsFactoryWithRequestName:(NSString *)
  requestName
{
    if(!self.requestToolsIn)
    {
        self.requestToolsIn = [[NSMutableDictionary alloc] init];
    }
    NSMutableDictionary * requestToolsIn_ = [self.requestToolsIn
                                             objectForKey:requestName];
    if(!requestToolsIn_)
    {
        NSMutableDictionary * newRequestToolsIn = [[NSMutableDictionary alloc]
                                                   init];
        NSMutableData * responseData_ = [[NSMutableData alloc] init];
        NSMutableDictionary * dictResponse_ = [[NSMutableDictionary alloc]
                                               init];
        NSString * uuid_ = [self uuid];
        [newRequestToolsIn setObject:responseData_ forKey:kResponseData];
        [newRequestToolsIn setObject:dictResponse_ forKey:kResponseIn];
        [newRequestToolsIn setObject:requestName forKey:kRequestName];
        [newRequestToolsIn setObject:uuid_ forKey:kUniqueID];
        [self.requestToolsIn setObject:newRequestToolsIn forKey:requestName];
        requestToolsIn_ = newRequestToolsIn;
    }else
    {
        return  requestToolsIn_;
    }
    return  requestToolsIn_;
}

-(NSDictionary *)requestToolsFactoryWithRequestName:(NSString *)requestName
                               andRequestConnection:(NSURLConnection *)
                               requestConn_
{
    NSDictionary * requestToolsIn_ =
    [self.requestToolsIn objectForKey:requestName];
    if(!requestToolsIn_)
    {
        NSMutableDictionary * newRequestToolsIn = [[NSMutableDictionary alloc]
                                                   init];
        NSMutableData * responseData_ = [[NSMutableData alloc] init];
        NSMutableDictionary * dictResponse_ = [[NSMutableDictionary alloc]
                                               init];
        [newRequestToolsIn setObject:responseData_ forKey:kResponseData];
        [newRequestToolsIn setObject:requestConn_ forKey:kRequestConnection];
        [newRequestToolsIn setObject:dictResponse_ forKey:kResponseIn];
    }else
    {
        return  requestToolsIn_;
    }
    return  requestToolsIn_;
}

-(NSMutableDictionary *)requestToolsFactoryWithRequestConnection
 :(NSURLConnection *)requestConn_
{
    NSArray * keyConnection = [self.requestToolsIn allKeys];
    for (NSString * key in keyConnection) {
        NSMutableDictionary * requestToolIn = [self.requestToolsIn
                                               objectForKey:key];
        NSURLConnection* requestConnInDict = [requestToolIn
                                              objectForKey:kRequestConnection];
        if(requestConnInDict == requestConn_)
        {
            return requestToolIn;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark Response Method
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    NSMutableDictionary * requestToolIn =
    [self requestToolsFactoryWithRequestConnection:connection];
    NSMutableData* responseData_ = [requestToolIn objectForKey:@"responseData"];
    if(!responseData_)
    {
        [requestToolIn setObject:[[NSMutableData alloc] init]
                          forKey:@"responseData"];
        responseData_ = [requestToolIn objectForKey:@"responseData"];
    }
    [responseData_ appendData:data];
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSMutableDictionary * requestToolIn =
    [self requestToolsFactoryWithRequestConnection:connection];
    NSMutableData * responseData_ = [requestToolIn objectForKey:kResponseData];
    
    if(responseData_.length != 0)
    {
        NSString * requestName = [requestToolIn objectForKey:kRequestName];
        NSDictionary * dictResponse_ =
        [NSJSONSerialization JSONObjectWithData:responseData_
                                        options:NSJSONReadingMutableContainers
                                          error:nil];
        if(dictResponse_)
        {
            BOOL IsSuccess =
            !([[dictResponse_ objectForKey:kRequestProcessStatus]
               intValue] == 0);
            NSDictionary * dataResponseIn;
            if(IsSuccess)
            {
                if([[dictResponse_ objectForKey:kResponseResult]
                    isKindOfClass:[NSString class]])
                {
                    NSString * stringDataToConvertToJSON =
                    [dictResponse_ objectForKey:kResponseResult];
                    if(!(stringDataToConvertToJSON == (id)[NSNull null]))
                    {
                        dataResponseIn =
                        [NSJSONSerialization JSONObjectWithData:
                         [stringDataToConvertToJSON
                          dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:
                         NSJSONReadingMutableContainers
                                                          error: nil];
                    }
                }else if([[dictResponse_ objectForKey:@"Data"]
                          isKindOfClass:[NSDictionary class]])
                {
                    dataResponseIn = [dictResponse_ objectForKey:@"Data"];
                }
                
                // delegateต
                [self.delegate requestDidFinishLoadWithDataIn:dataResponseIn
                                                andRquestName:requestName
                                         andTransactionStatus:IsSuccess];
                // delete response data
                [responseData_ setData:nil];
                [requestToolIn setObject:[NSNumber numberWithBool:YES]
                                  forKey:kRequestStatus];

            }
            else
            {
                if([[dictResponse_ objectForKey:kResponseMessage]
                    isKindOfClass:[NSString class]])
                {
                    NSString * stringDataToConvertToJSON =
                    [dictResponse_ objectForKey:kResponseMessage];
                    if(!(stringDataToConvertToJSON == (id)[NSNull null]))
                    {
                        dataResponseIn =
                        [NSJSONSerialization JSONObjectWithData:
                         [stringDataToConvertToJSON
                          dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:
                         NSJSONReadingMutableContainers
                                                          error: nil];
                    }
                }
                
                // delegateต
                [self.delegate requestDidFinishLoadWithDataIn:dataResponseIn
                                                andRquestName:requestName
                                         andTransactionStatus:IsSuccess];
                // delete response data
                [responseData_ setData:nil];
                [requestToolIn setObject:[NSNumber numberWithBool:YES]
                                  forKey:kRequestStatus];

            }
                        
        }
    }
    
    
    // do somthing same everywhere
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}


#pragma mark - Util Method
- (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

@end
