//
//  Owner+CoreDataProperties.h
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "Owner+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Owner (CoreDataProperties)

+ (NSFetchRequest<Owner *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Property *> *properties;

@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addPropertiesObject:(Property *)value;
- (void)removePropertiesObject:(Property *)value;
- (void)addProperties:(NSSet<Property *> *)values;
- (void)removeProperties:(NSSet<Property *> *)values;

@end

NS_ASSUME_NONNULL_END
