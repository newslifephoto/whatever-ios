//
//  DateTimeManager.m
//  Humatrix Mobile 3
//
//  Created by x5mobile on 5/28/56 BE.
//  Copyright (c) 2556 Huanica. All rights reserved.
//

#import "DateTimeLanguageManager.h"
#import "UserDefaultsManager.h"

@interface DateTimeLanguageManager (Private)
  @property NSDateFormatter * dateFormatter;

@end

@implementation DateTimeLanguageManager


-(void)setDateFormatterDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSString * calendarType = [self calendarType];
    NSString * calendarLanguage = [self calendarLanguage];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:calendarType];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:calendarLanguage];
    [dateFormatter setLocale:locale];
    [dateFormatter setCalendar:gregorianCalendar];
}

- (NSDate *)dateFromString:(NSString*)dateString
                 andFormat:(NSString *)dateFormat
{
    NSDateFormatter * dateFormatter = [self dateFormatterWithFormat:dateFormat];
    NSDate * dateToReturn = [dateFormatter dateFromString:dateString];
    return dateToReturn;
}

-(void)setDateFormatterDateFormatter:(NSDateFormatter *)dateFormatter
                     andCalendarType:(NSString *)calendarType
{
    NSString * calendarLanguage = [self calendarLanguage];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:calendarType];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:calendarLanguage];
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

-(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
                            andCalendarType:(NSString *)calendarType
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [self setDateFormatterDateFormatter:dateFormatter
                        andCalendarType:calendarType];
    [dateFormatter setDateFormat:format];
    
    return dateFormatter;
}

- (NSString *)languageSetting
{
    
    NSString * languageSetting = [UserDefaultsManager languageSetting];
    return languageSetting;
}

-(NSString *)calendarType
{
    NSString * currentLanguageSetting = [self languageSetting];
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
    NSString * currentLanguageSetting = [self languageSetting];
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



@end
