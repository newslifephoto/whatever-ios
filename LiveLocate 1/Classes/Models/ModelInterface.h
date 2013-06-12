//
//  ModelInterface.h
//  LiveLocate 1
//
//  Created by x5mobile on 5/27/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "DateTimeLanguageManager.h"
#import "DatabaseManager.h"
@interface ModelInterface : NSObject

@property (nonatomic,strong) ConnectionManager * connectionManager;
@property (nonatomic,strong) DateTimeLanguageManager * dateTimeLanguageManager;
@property (nonatomic,strong) DatabaseManager * databaseManager;

@end

