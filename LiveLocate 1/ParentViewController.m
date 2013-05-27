//
//  ParentViewController.m
//  testCoredata
//
//  Created by Lion User on 19/11/2012.
//  Copyright (c) 2012 Lion User. All rights reserved.
//


#import "ParentViewController.h"
#import "LiveLocateAppDelegate.h"
#import "Language.h"
#import <QuartzCore/QuartzCore.h>

#define ipServer @"https://www.esspace.com/Mobile/service.sv"

#define RESPONSE_DATA @"responseData"
#define REQUEST_CONN @"requestConn"
#define DICT_RESPONSE @"dictResponse"
#define REQUEST_NAME @"requestName"
#define REQUEST @"request"
#define RP @"rpStr"
#define TTR @"timeToRequest"
#define REQUEST_STATUS @"requestStatus"
#define LANGUAGE_SETTING_KEY @"languageSetting"
#define UUID @"uuid"

@class SidebarViewController;
@interface ParentViewController (Private) <UITableViewDataSource, UITableViewDelegate>
-(void)reachabilityChanged:(NSNotification*)note;
@end

@implementation ParentViewController
@synthesize dataArray, dataDictionary;
@synthesize leftSidebarViewController;
@synthesize leftSelectedIndexPath;
@synthesize ad;
@synthesize dictResponse,requestConn,responseData;
@synthesize ipServerRequest;
@synthesize requestToolsIn;
@synthesize delegate;
@synthesize connectionsRequesting;
@synthesize v;
@synthesize request,moc,entityDescription;
@synthesize currentLanguageSetting;

#pragma mark-
#pragma mark Class Method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    ipServerRequest = ipServer;
    [super viewDidLoad];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [v setBackgroundColor:[UIColor redColor]];
    //    [self.view addSubview:v];
    UILabel * label_ = [[UILabel alloc] initWithFrame:v.bounds];
    [label_ setBackgroundColor:[UIColor redColor]];
    [label_ setTextAlignment:NSTextAlignmentCenter];
    label_.text = @"no internet connection";
    [v addSubview:label_];

    request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.0 green:0.137254 blue:0.24313 alpha:0]];
  
}

-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

#pragma mark -

#pragma mark Request Method
-(void)requestToServerWithRpDic:(NSMutableDictionary *)rpDict andRequestName:(NSString *)requestName_ andProcessKey:(NSString *)pk
{
//    AppDelegate * ad_ = self.ad;
//    NSString * employeeId = ad_.username;
//    NSMutableDictionary * requestToolIn = [self requestToolsFactoryWithRequestName:requestName_];
//    NSString * uuid = [requestToolIn objectForKey:UUID];
//    if(!employeeId && [rpDict objectForKey:@"employeeid"])
//    {
//        employeeId =[rpDict objectForKey:@"employeeid"];
//    }
//    else if(!employeeId && ![rpDict objectForKey:@"employeeid"])
//    {
//        employeeId = @"";
//    }
//    NSString * roleId = ad_.roleId?ad_.roleId:@"";
//    // may be must fix it
//    NSString * username = employeeId;
//    [rpDict setObject:@"HMCHQ" forKey:@"oucode"];
//    [rpDict setObject:employeeId forKey:@"employeeid"];
//    [rpDict setObject:roleId forKey:@"roleid"];
//    [rpDict setObject:username forKey:@"username"];
//    [rpDict setObject:username forKey:@"employeecode"];
//    [rpDict setObject:currentLanguageSetting forKey:@"language"];
//    NSData * json = [NSJSONSerialization dataWithJSONObject:rpDict options:NSJSONWritingPrettyPrinted error:nil];
//    NSString * stringJSON = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
//    NSString * action = rpDict[@"action"];
//    if(![action isEqualToString:@"sub"])
//    {
//        uuid = @"";
//    }
//    NSString * rpStr = [NSString stringWithFormat:@"pk=%@&rp=%@&uk=%@",pk,stringJSON,uuid];
//    
//    //    responseData = [requestToolIn objectForKey:RESPONSE_DATA];
//    NSLog(@"URL TEXT : %@",rpStr);
//    NSString * urlString = ipServerRequest;
//    NSData* rpData = [rpStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSURL * url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest * request_ = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
//    [request_ setHTTPMethod:@"POST"];
//    [request_ setHTTPBody:[rpStr dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLConnection * requestConn_ = [NSURLConnection connectionWithRequest:request_ delegate:self];
//    [connectionsRequesting addObject:requestConn_];
//    [NSTimer scheduledTimerWithTimeInterval:20.0
//                                     target:self
//                                   selector:@selector(checkIsTimeout:)
//                                   userInfo:requestName_
//                                    repeats:NO];
//    [requestToolIn setObject:requestConn_ forKey:REQUEST_CONN];   
////    [requestToolIn setObject:request forKey:REQUEST];
//    [requestToolIn setObject:rpData forKey:RP];
//    [requestToolIn setObject:[NSNumber numberWithBool:NO] forKey:REQUEST_STATUS];
//    [requestToolIn setObject:[NSNumber numberWithInt:1] forKey:TTR];
}

-(void)requestToServerWithRequestToolsIn:(NSMutableDictionary *)requestToolsIn_;
{
    
    NSString * requestName_ = [requestToolsIn_ objectForKey:REQUEST_NAME];
    NSMutableURLRequest * request_ = [requestToolsIn_ objectForKey:REQUEST];
    NSData * rpData = [requestToolsIn_ objectForKey:RP];
    [requestToolsIn_ setObject:[NSNumber numberWithInteger:0] forKey:TTR];
    [request_ setHTTPMethod:@"POST"];
    [request_ setHTTPBody:rpData];
    NSLog(@"URL TEXT %@",rpData);
    NSURLConnection * requestConn_ = [NSURLConnection connectionWithRequest:request_ delegate:self];
    [NSTimer scheduledTimerWithTimeInterval:20.0
                                     target:self
                                   selector:@selector(checkIsTimeout:)
                                   userInfo:requestName_
                                    repeats:NO];
    [requestToolsIn_ setObject:requestConn_ forKey:REQUEST_CONN];
    [NSTimer scheduledTimerWithTimeInterval:20.0
                                     target:self
                                   selector:@selector(checkIsTimeout:)
                                   userInfo:requestName_
                                    repeats:NO];
}

#pragma mark -
#pragma mark Response Method
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    NSMutableDictionary * requestToolIn = [self requestToolsFactoryWithRequestConnection:connection];
    NSMutableData* responseData_ = [requestToolIn objectForKey:@"responseData"];
    if(!responseData_)
    {
        [requestToolIn setObject:[[NSMutableData alloc] init] forKey:@"responseData"];
        responseData_ = [requestToolIn objectForKey:@"responseData"];
    }
    [responseData_ appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    [v removeFromSuperview];
    NSMutableDictionary * requestToolIn = [self requestToolsFactoryWithRequestConnection:connection];
    NSMutableData * responseData_ = [requestToolIn objectForKey:RESPONSE_DATA];
    
    if(responseData_.length != 0)
    {
        NSString * requestName = [requestToolIn objectForKey:REQUEST_NAME];
        NSDictionary * dictResponse_ = [NSJSONSerialization JSONObjectWithData:responseData_ options:nil error:nil];
        if(dictResponse_)
        {
            BOOL IsSuccess = !([[dictResponse_ objectForKey:@"IsSuccess"] intValue] == 0);
            NSDictionary * dataResponseIn;
            if([[dictResponse_ objectForKey:@"Data"] isKindOfClass:[NSString class]])
            {
                NSString * stringDataToConvertToJSON = [dictResponse_ objectForKey:@"Data"];
                if(!(stringDataToConvertToJSON == (id)[NSNull null]))
                {
                    dataResponseIn =
                    [NSJSONSerialization JSONObjectWithData: [stringDataToConvertToJSON dataUsingEncoding:NSUTF8StringEncoding]
                                                    options: NSJSONReadingMutableContainers
                                                      error: nil];
                    
                }
            }else if([[dictResponse_ objectForKey:@"Data"] isKindOfClass:[NSDictionary class]])
            {
                dataResponseIn = [dictResponse_ objectForKey:@"Data"];
            }
            
            // delegateต
            [self.delegate requestDidFinishLoadWithDataIn:dataResponseIn andRquestName:requestName andTransactionStatus:IsSuccess];
            // delete response data
            [responseData_ setData:nil];
            [requestToolIn setObject:[NSNumber numberWithBool:YES] forKey:REQUEST_STATUS];
            
        }
    }
    
    
    // do somthing same everywhere
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}
#pragma mark -


#pragma mark Timeout and Error Handler Connection Method

//-(void)reachabilityChanged:(NSNotification*)sender
//{
//    Reachability * reach = [sender object];
//    
//    if([reach isReachable])
//    {
//        NSLog(@"testewtrsetset");
//        [v removeFromSuperview];
//    }
//    else
//    {
//        NSLog(@"testewtrsetset");
//        [self.view addSubview:v];
//    }
//}

-(void)conection:(NSURLConnection *)connection didFailWithError:(NSError*)error
{
    
    NSLog(@"Error %@",error);
}

-(void)checkIsTimeout:(NSTimer*)theTimer
{
    NSString * requestName_ = (NSString*)[theTimer userInfo];
    NSMutableDictionary * requestToolsIn_ = [self requestToolsFactoryWithRequestName:requestName_];
    NSNumber * ttr = (NSNumber*)[requestToolsIn_ objectForKey:TTR];
    NSMutableData * responseData_ = [requestToolsIn_ objectForKey:RESPONSE_DATA];
    //    [requestToolIn setObject:[NSNumber numberWithBool:NO] forKey:REQUEST_STATUS];
    BOOL requestStatus = [[requestToolsIn_ objectForKey:REQUEST_STATUS] boolValue];
    if(ttr.intValue > 3)
    {
        NSLog(@"request time out eie ! %@",requestName_);
        [self.delegate requestRequestTimeOutWithRquestName:requestName_ andRequestToolsIn:requestToolsIn_];
    }
    else if (!requestStatus){
        NSLog(@"resend request to server");
        [requestToolsIn_ setObject:[NSNumber numberWithInteger:(ttr.intValue + 1)] forKey:TTR];
        if(responseData_.length == 0)
        {
            NSMutableURLRequest * request_ = [requestToolsIn_ objectForKey:REQUEST];
            NSData * rpData = [requestToolsIn_ objectForKey:RP];
            [request_ setHTTPMethod:@"POST"];
            [request_ setHTTPBody:rpData];
            NSURLConnection * requestConn_ = [NSURLConnection connectionWithRequest:request_ delegate:self];
            [NSTimer scheduledTimerWithTimeInterval:20.0
                                             target:self
                                           selector:@selector(checkIsTimeout:)
                                           userInfo:requestName_
                                            repeats:NO];
            [requestToolsIn_ setObject:requestConn_ forKey:REQUEST_CONN];
            
        }
    }
}

#pragma mark -
#pragma mark Factory Method
-(NSMutableDictionary *)requestToolsFactoryWithRequestName:(NSString *)requestName
{
    if(!requestToolsIn)
        requestToolsIn = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * requestToolsIn_ = [requestToolsIn objectForKey:requestName];
    if(!requestToolsIn_)
    {
        NSMutableDictionary * newRequestToolsIn = [[NSMutableDictionary alloc] init];
        NSMutableData * responseData_ = [[NSMutableData alloc] init];
        NSMutableDictionary * dictResponse_ = [[NSMutableDictionary alloc] init];
        NSString * uuid_ = [self uuid];
        [newRequestToolsIn setObject:responseData_ forKey:RESPONSE_DATA];
        //[newRequestToolsIn setObject:requestConn_ forKey:REQUEST_CONN];
        [newRequestToolsIn setObject:dictResponse_ forKey:DICT_RESPONSE];
        [newRequestToolsIn setObject:requestName forKey:REQUEST_NAME];
        [newRequestToolsIn setObject:uuid_ forKey:UUID];
        [requestToolsIn setObject:newRequestToolsIn forKey:requestName];
        
        requestToolsIn_ = newRequestToolsIn;
    }else
    {
        return  requestToolsIn_;
    }
    return  requestToolsIn_;
}

-(NSDictionary *)requestToolsFactoryWithRequestName:(NSString *)requestName andRequestConnection:(NSURLConnection *)requestConn_
{
    NSDictionary * requestToolsIn_ = [requestToolsIn objectForKey:requestName];
    if(!requestToolsIn_)
    {
        NSMutableDictionary * newRequestToolsIn = [[NSMutableDictionary alloc] init];
        NSMutableData * responseData_ = [[NSMutableData alloc] init];
        NSMutableDictionary * dictResponse_ = [[NSMutableDictionary alloc] init];
        [newRequestToolsIn setObject:responseData_ forKey:RESPONSE_DATA];
        [newRequestToolsIn setObject:requestConn_ forKey:REQUEST_CONN];
        [newRequestToolsIn setObject:dictResponse_ forKey:DICT_RESPONSE];
    }else
    {
        return  requestToolsIn_;
    }
    return  requestToolsIn_;
}

-(NSMutableDictionary *)requestToolsFactoryWithRequestConnection:(NSURLConnection *)requestConn_
{
    NSArray * keyConnection = [requestToolsIn allKeys];
    for (NSString * key in keyConnection) {
        NSMutableDictionary * requestToolIn = [requestToolsIn objectForKey:key];
        NSURLConnection* requestConnInDict = [requestToolIn objectForKey:REQUEST_CONN];
        if(requestConnInDict == requestConn_)
        {
            return requestToolIn;
        }
    }
    return nil;
}

-(UIButton*)barButtonFactoryWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBorderColor:(UIColor*)borderColor andBackgroundColor:(UIColor *)backgroundColor andWidth:(float)width andHeight:(float)height
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.layer.cornerRadius = 3;
    bt.layer.borderWidth = 0.9;
    bt.layer.borderColor = borderColor.CGColor;
    bt.backgroundColor = backgroundColor;
    [bt addTarget:self action:@selector(changeBackground:) forControlEvents:UIControlEventTouchDown];
    [bt addTarget:self action:@selector(changeBackground:) forControlEvents:UIControlEventTouchDragInside];
    [bt addTarget:self action:@selector(changeBackgroundBack:) forControlEvents:UIControlEventTouchDragOutside];
    [bt addTarget:self action:@selector(changeBackgroundBack:) forControlEvents:UIControlEventTouchUpInside];
    bt.bounds = CGRectMake( 0, 0, width, height);
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    return bt;
}

-(UITextField*)textFieldFactoryWithTagNum:(NSInteger)tagNum andSection:(NSInteger)section andTextFieldFormIn:(NSMutableDictionary *)textFieldsFormIn
{
    if(!textFieldsFormIn)
    {
        textFieldsFormIn = [[NSMutableDictionary alloc] init];
    }
    
    NSString * sectionStr = [NSString stringWithFormat:@"%i",section];
    NSString * tagNumStr = [NSString stringWithFormat:@"%i",tagNum];
    UITextField * textField;
    textField = (UITextField*)[[textFieldsFormIn objectForKey:sectionStr] objectForKey:tagNumStr];
    if(!textField)
    {
        textField = [[UITextField alloc] init];
        [textFieldsFormIn setObject:textField forKey:tagNumStr];
    }
    return textField;
    
}

#pragma mark -
#pragma mark Util Method
-(NSString *)generateStringFromDictRp:(NSDictionary *)_rpIn
{
    NSArray * allKey = [_rpIn allKeys];
    NSString * rpStr = @"{";
    for (int i =0; i<[allKey count]; i++) {
        NSString * key = [allKey objectAtIndex:i];
        NSString * val = [_rpIn objectForKey:key];
        if(i < ([allKey count] - 1))
        {
            rpStr = [rpStr stringByAppendingFormat:@"\"%@\":\"%@\",",key,val];
        }
        else{
            rpStr = [rpStr stringByAppendingFormat:@"\"%@\":\"%@\"}",key,val];
        }
    }
    return rpStr;
}

- (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

//-(NSString*)getUserDataWithKey:(NSString*)key
//{
//    NSDictionary * userDataIn_ =  (NSDictionary*)ad.userDataIn;
//    return [userDataIn_ objectForKey:key];
//}

-(NSString *)calendarType
{
    if([currentLanguageSetting isEqualToString:@"en"])
    {
        return NSGregorianCalendar;
    }else if([currentLanguageSetting isEqualToString:@"th"])
    {
        return NSBuddhistCalendar;
    }
    // return default
    return NSGregorianCalendar;
}

-(NSString *)calendarLanguage
{
    if([currentLanguageSetting isEqualToString:@"en"])
    {
        return @"en_BI";
    }else if([currentLanguageSetting isEqualToString:@"th"])
    {
        return @"th_BI";
    }
    // return default
    return @"en_BI";
}

-(void)setDateFormatterDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSString * calendarType = [self calendarType];
    NSString * calendarLanguage = [self calendarLanguage];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:calendarType];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:calendarLanguage];
    [dateFormatter setLocale:locale];
    [dateFormatter setCalendar:gregorianCalendar];
    
}

-(void)setDateFormatterDateFormatter:(NSDateFormatter *)dateFormatter andCalendarType:(NSString *)calendarType
{
    NSString * calendarLanguage = [self calendarLanguage];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:calendarType];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:calendarLanguage];
    [dateFormatter setLocale:locale];
    [dateFormatter setCalendar:gregorianCalendar];
    
}

-(NSString *)dateStringWith:(NSDate *)aDate andFormat:(NSString *)dateFormat
{
    
    NSDateFormatter * dateFormatter = [self dateFormatterWithFormat:dateFormat];
    [self setDateFormatterDateFormatter:dateFormatter];
    NSString * stringDateToReturn = [dateFormatter stringFromDate:aDate];
    
    return stringDateToReturn;
}

-(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [self setDateFormatterDateFormatter:dateFormatter];
    [dateFormatter setDateFormat:format];
    
    return dateFormatter;
    
    
}

-(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andCalendarType:(NSString *)calendarType
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [self setDateFormatterDateFormatter:dateFormatter andCalendarType:calendarType];
    [dateFormatter setDateFormat:format];
    
    return dateFormatter;
}

-(void)changeBackgroundBack:(id)sender
{
    UIColor * borderColor = [UIColor colorWithRed:0 green:0.68 blue:0.9372 alpha:1];
    UIColor * backgroundColor = [UIColor clearColor];
    UIColor * textColor = [UIColor colorWithRed:0 green:0.68 blue:0.9372 alpha:1];
    UIButton *bt = (UIButton *)sender;
    bt.titleLabel.textColor = textColor;
    bt.layer.borderColor = borderColor.CGColor;
    [bt setBackgroundColor:backgroundColor];
}

-(void)changeBackground:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    bt.backgroundColor = [UIColor colorWithRed:0.69411 green:0.85098 blue:0.89411 alpha:1];
    bt.titleLabel.textColor = [UIColor colorWithRed:0 green:0.29411 blue:0.37647 alpha:1];
}

#pragma mark -
#pragma mark Databse Method

-(void)removeObjectFromKey:(NSString*)aKey
{
//    GerneralInfo* generalInfo;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", aKey];
//    [request setPredicate:predicate];
//    NSError *error;
//    NSArray *array = [moc executeFetchRequest:request error:&error];
//    generalInfo =  (GerneralInfo*)[array objectAtIndex:0];
//    
//    if([array count] > 0)
//    {
//        [moc deleteObject:generalInfo];
//        [moc save:nil];
//    }
}

-(void)insertObjectWithKey:(NSString *)aKey andValue:(NSString *)aValue
{
//    GerneralInfo * generalInfo = [NSEntityDescription insertNewObjectForEntityForName:GERNERAL_ENTITY_NAME inManagedObjectContext:moc];
//    generalInfo.key = aKey;
//    generalInfo.value = aValue;
//    [moc save:nil];
}


//-(GerneralInfo *)generalInfoWithKey:(NSString*)aKey
//{
//    GerneralInfo* generalInfo;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@", aKey];
//    [request setPredicate:predicate];
//    NSError *error;
//    NSArray *array = [moc executeFetchRequest:request error:&error];
//    if([array count] > 0)
//    {
//        generalInfo = ((GerneralInfo*)array[0]);
//    }
//    return generalInfo;
//}

@end



