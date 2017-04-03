//
//  Property+CoreDataProperties.h
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "Property+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Property (CoreDataProperties)

+ (NSFetchRequest<Property *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t price;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, retain) Owner *owner;

@end

NS_ASSUME_NONNULL_END
