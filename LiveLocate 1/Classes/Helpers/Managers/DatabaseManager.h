//
//  DatabaseManager.h
//  Humatrix Mobile 3
//
//  Created by x5mobile on 5/31/56 BE.
//  Copyright (c) 2556 Huanica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseManager : NSObject

@property (nonatomic,strong) NSManagedObjectContext* moc;
@property (nonatomic,strong) NSFetchRequest * request;
@property (nonatomic,strong) NSEntityDescription *entityDescription;


@end
