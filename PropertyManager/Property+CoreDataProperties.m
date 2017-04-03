//
//  Property+CoreDataProperties.m
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "Property+CoreDataProperties.h"

@implementation Property (CoreDataProperties)

+ (NSFetchRequest<Property *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Property"];
}

@dynamic name;
@dynamic price;
@dynamic location;
@dynamic owner;

@end
