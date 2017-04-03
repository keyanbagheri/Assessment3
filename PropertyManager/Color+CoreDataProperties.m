//
//  Color+CoreDataProperties.m
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "Color+CoreDataProperties.h"

@implementation Color (CoreDataProperties)

+ (NSFetchRequest<Color *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Color"];
}

@dynamic choice;

@end
