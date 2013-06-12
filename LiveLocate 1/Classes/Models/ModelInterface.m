//
//  ModelInterface.m
//  LiveLocate 1
//
//  Created by x5mobile on 5/27/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import "ModelInterface.h"

@interface ModelInterface (Private)



@end

@implementation ModelInterface

- (id)init
{
    self = [super init];
    if (self) {
        _connectionManager = [[ConnectionManager alloc] init];
        _dateTimeLanguageManager = [[DateTimeLanguageManager alloc] init];
        _databaseManager = [[DatabaseManager alloc] init];
    }
    return self;
}



@end
