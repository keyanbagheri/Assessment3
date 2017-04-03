//
//  PropertyViewController.m
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "PropertyViewController.h"
#import "CoreDataManager.h"
#import "Color+CoreDataClass.h"

@interface PropertyViewController ()<NSFetchedResultsControllerDelegate>
- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.currentOwner.name;
    [self setupData];
    [self setDefaultColor];
    if (![self.currentProperty.name isEqual: @""]) {
        self.navigationItem.title = self.currentProperty.name;
        self.nameTextField.text = self.currentProperty.name;
    }
    if (self.currentProperty.price > 0) {
        self.priceTextField.text = [NSString stringWithFormat:@"%d", self.currentProperty.price];
    }
    if (![self.currentProperty.name isEqual: @""]) {
        self.locationTextField.text = self.currentProperty.location;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData {
    self.context = [[CoreDataManager shared] managedObjectContext];
}

-(void)setDefaultColor {
    NSFetchRequest *colorFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Color"];
    
    NSError *fetchError = NULL;
    NSArray *fetchedObjects = [self.context executeFetchRequest:colorFetchRequest error:&fetchError];
    
    if (fetchError) {
        NSLog(@"ErrorFethcing | Description : %@ | Reason : %@",fetchError.localizedDescription,fetchError.localizedFailureReason);
        return;
    }
    
    NSString *color = @"greenColor";
    
    if (fetchedObjects.count > 0) {
        Color *selectedColor = [fetchedObjects objectAtIndex:0];
        color = selectedColor.choice;
    }
    
    if ([color isEqualToString:@"greenColor"]) {
        self.view.backgroundColor = [UIColor greenColor];
    } else if ([color isEqualToString:@"blueColor"]) {
        self.view.backgroundColor = [UIColor blueColor];
    } else if ([color isEqualToString:@"yellowColor"]) {
        self.view.backgroundColor = [UIColor yellowColor];
    } else if ([color isEqualToString:@"redColor"]) {
        self.view.backgroundColor = [UIColor redColor];
    }
}

- (IBAction)doneButtonPressed:(id)sender {
    Property * property = (Property *)[NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:self.context];
    property.name = self.nameTextField.text;
    property.price = [self.priceTextField.text integerValue];
    property.location = self.locationTextField.text;
    property.owner = self.currentOwner;
    
    NSError *saveError = NULL;
    [self.context save:&saveError];
    
    if (saveError) {
        return;
    }
}
@end
