//
//  DateTimeManager.h
//  Humatrix Mobile 3
//
//  Created by x5mobile on 5/28/56 BE.
//  Copyright (c) 2556 Huanica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultsManager.h"

@interface DateTimeLanguageManager : NSObject

@property (nonatomic,strong) UserDefaultsManager * userDefaultManager;

- (NSString *)dateStringWith:(NSDate *)aDate andFormat:(NSString *)dateFormat;
- (NSString *)calendarType;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andCalendarType:(NSString *)calendarType;
- (NSDate *)dateFromString:(NSString*)dateString andFormat:(NSString *)dateFormat;
- (NSString *)languageSetting;


@end
