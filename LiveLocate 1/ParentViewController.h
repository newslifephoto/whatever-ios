//
//  ParentTableViewController.h
//  Humatrix Mobile 3
//
//  Created by x5mobile on 1/3/56 BE.
//  Copyright (c) 2556 Huanica. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@protocol ParentViewControllerDelegate <NSObject>

@required
- (void)requestDidFinishLoadWithDataIn:(NSDictionary *)dataIn andRquestName:(NSString *)requestName andTransactionStatus:(BOOL)status;
- (void)requestRequestTimeOutWithRquestName:(NSString *)requestName andRequestToolsIn:(NSMutableDictionary*)requestToolsIn;

-(void)didLanguageChange:(NSString*)stringLanguageSetting;
@optional
- (void)sideBarActionTemporary:(NSIndexPath*)indexPath;

@end
@class AppDelegate;
@class SidebarViewController;
@interface ParentViewController : UIViewController <UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>

{
#if EXPERIEMENTAL_ORIENTATION_SUPPORT
    CGPoint _containerOrigin;
#endif
    
	NSMutableArray *dataArray;
	NSMutableDictionary *dataDictionary;
}
@property (nonatomic,assign) id <ParentViewControllerDelegate> delegate;
@property (nonatomic, strong) SidebarViewController *leftSidebarViewController;
@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@property (nonatomic,strong) NSMutableDictionary * requestToolsIn;
/////
@property (nonatomic,strong) NSMutableData * responseData;
@property (nonatomic,strong) NSURLConnection * requestConn;
@property (nonatomic,strong) NSMutableDictionary * dictResponse;
@property (nonatomic,strong) NSMutableArray * connectionsRequesting;
////
@property (nonatomic,strong) NSString * ipServerRequest;
@property (nonatomic,strong) AppDelegate * ad;
@property (nonatomic,strong) UIView * v ;
///// database property /////
@property (nonatomic,strong) NSManagedObjectContext* moc;
@property (nonatomic,strong) NSFetchRequest * request;
@property (nonatomic,strong) NSEntityDescription *entityDescription;
@property (nonatomic,strong) NSString * currentLanguageSetting;
/////////

- (NSString *)generateStringFromDictRp:(NSDictionary *)_rpIn;
//-(NSString*)getUserDataWithKey:(NSString*)key;
-(void)requestToServerWithRpDic:(NSMutableDictionary *)rpDict andRequestName:(NSString *)requestName_ andProcessKey:(NSString *)pk;
-(void)requestToServerWithRequestToolsIn:(NSMutableDictionary *)requestToolsIn_;
/// database method ///
-(void)removeObjectFromKey:(NSString*)aKey;
-(void)insertObjectWithKey:(NSString *)aKey andValue:(NSString *)aValue;

///
/// date method ////
-(NSString *)dateStringWith:(NSDate *)aDate andFormat:(NSString *)dateFormat;
-(NSString *)calendarType;
-(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
-(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andCalendarType:(NSString *)calendarType;
////////////
// factory method ///
-(UIButton*)barButtonFactoryWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBorderColor:(UIColor*)borderColor andBackgroundColor:(UIColor *)backgroundColor andWidth:(float)width andHeight:(float)height;
-(void)changeBackgroundBack:(id)sender;
-(void)changeBackground:(id)sender;
-(UITextField*)textFieldFactoryWithTagNum:(NSInteger)tagNum andSection:(NSInteger)section andTextFieldFormIn:(NSMutableDictionary *)textFieldsFormIn;

@end
