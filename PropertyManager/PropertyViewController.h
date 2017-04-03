//
//  PropertyViewController.h
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Owner+CoreDataClass.h"
#import "Property+CoreDataClass.h"

@interface PropertyViewController : UIViewController
@property (strong, nonatomic) Owner *currentOwner;
@property (strong, nonatomic) Property *currentProperty;
@end
