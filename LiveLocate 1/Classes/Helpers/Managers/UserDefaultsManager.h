//
//  UserDefaultsManager.h
//  LiveLocate 1
//
//  Created by x5mobile on 5/29/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsManager : NSObject
@property (nonatomic,strong) NSString * companyNameI;
@property (nonatomic,strong) NSString * companyNameL;
@property (nonatomic,strong) NSString * imageLocation;
@property (nonatomic,strong) NSString * serviceLocation;
@property (nonatomic,strong) NSString * registerKey;
@property (nonatomic,strong) NSString * username;
@property (nonatomic,strong) NSString * languageSetting;



+ (NSString *)companyNameI;
+ (NSString *)companyNameL;
+ (NSString *)imageLocation;
+ (NSString *)serviceLocation;
+ (NSString *)registerKey;
+ (NSString *)username;
+ (NSString *)languageSetting;
@end
