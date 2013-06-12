//
//  UserDefaultsManager.m
//  LiveLocate 1
//
//  Created by x5mobile on 5/29/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import "UserDefaultsManager.h"
#import "UserDefaultConstants.h"
@interface UserDefaultsManager ()



@end
@implementation UserDefaultsManager
+ (NSString *)companyNameI
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * companyNameI =
    [standardUserDefaults stringForKey:kUserDefaultCompanyNameI];
    
    return companyNameI;
    
}

+ (NSString *)companyNameL
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * companyNameI =
    [standardUserDefaults stringForKey:kUserDefaultCompanyNameL];
    
    return companyNameI;
}

+ (NSString *)imageLocation
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * imageLocation =
    [standardUserDefaults stringForKey:kUserDefaultImageLocation];
    
    return imageLocation;
}

+ (NSString *)serviceLocation
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * serviceLocation =
    [standardUserDefaults stringForKey:kUserDefaultServiceLocation];
    
    return serviceLocation;
}

+ (NSString *)registerKey
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * registerKey =
    [standardUserDefaults stringForKey:kUserDefaultRegisterKey];
    
    return registerKey;
}

+ (NSString *)username
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * username =
    [standardUserDefaults stringForKey:kUserDefaultUsername];
    
    return username;
}

+ (NSString *)languageSetting
{
    NSUserDefaults * standardUserDefaults =
    [NSUserDefaults standardUserDefaults];
    NSString * languageSetting =
    [standardUserDefaults stringForKey:kUserDefaultLanguageSetting];
    if(languageSetting)
    {
        return languageSetting;
    }
    return languageSetting;
}

@end
