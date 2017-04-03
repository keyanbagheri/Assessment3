//
//  Owner+CoreDataProperties.m
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "Owner+CoreDataProperties.h"

@implementation Owner (CoreDataProperties)

+ (NSFetchRequest<Owner *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
}

@dynamic name;
@dynamic properties;

@end
