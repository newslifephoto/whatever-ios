//
//  ModelObjectInterface.h
//  Humatrix Mobile 3
//
//  Created by x5mobile on 4/18/56 BE.
//  Copyright (c) 2556 Huanica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class AppDelegate;
@interface ModelObjectInterface : NSObject

@property (nonatomic,strong) AppDelegate * appDelegate;

///// database property /////
@property (nonatomic,strong) NSManagedObjectContext* moc;
@property (nonatomic,strong) NSFetchRequest * request;
@property (nonatomic,strong) NSEntityDescription *entityDescription;
@property (nonatomic,strong) NSString * currentLanguageSetting;

@end
