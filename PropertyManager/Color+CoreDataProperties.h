//
//  Color+CoreDataProperties.h
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "Color+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Color (CoreDataProperties)

+ (NSFetchRequest<Color *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *choice;

@end

NS_ASSUME_NONNULL_END
