//
//  CoreDataManager.h
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+(instancetype)shared;

- (NSManagedObjectContext *)managedObjectContext;

@end
