//
//  DatabaseManager.m
//  Humatrix Mobile 3
//
//  Created by x5mobile on 5/31/56 BE.
//  Copyright (c) 2556 Huanica. All rights reserved.
//

#import "DatabaseManager.h"
#import "LiveLocateAppDelegate.h"
@implementation DatabaseManager

- (id)init
{
    self = [super init];
    if (self)
    {
        LiveLocateAppDelegate * appDelegate  = [[UIApplication sharedApplication] delegate];
        appDelegate = [[UIApplication sharedApplication] delegate];
        _moc = appDelegate.managedObjectContext;
    }
    return self;
}






@end
