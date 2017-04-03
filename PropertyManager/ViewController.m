//
//  ViewController.m
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "ViewController.h"
#import "Color+CoreDataClass.h"
#import "Owner+CoreDataClass.h"
#import "CoreDataManager.h"
#import "OwnerViewController.h"

//typedef NS_ENUM(NSUInteger, DataState) {
//    DataStateFetched,
//    DataStateIntialized
//};

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)colorButtonPressed:(id)sender;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSArray * owners;
@property (assign, nonatomic) NSInteger selectedIndex;
//@property (assign, nonatomic) DataState dataState;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupData];
    [self setDefaultColor];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupData {
    self.context = [[CoreDataManager shared] managedObjectContext];
    
    NSFetchRequest *ownerFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    
    NSError *fetchError = NULL;
    NSArray *fetchedObjects = [self.context executeFetchRequest:ownerFetchRequest error:&fetchError];
    
    if (fetchError) {
        NSLog(@"ErrorFethcing | Description : %@ | Reason : %@",fetchError.localizedDescription,fetchError.localizedFailureReason);
        return;
    }
    
    self.owners = fetchedObjects;
    
    if (self.owners.count == 0) {
        NSArray *ownerNames = @[@"Robert Johnson", @"Mary Ellis", @"Perry James", @"Stephanie Morris", @"Danielle Blackwell", @"Sam Norris", @"Marty McDoyle", @"Nancy Lanker"];
        
        for (NSString *name in ownerNames) {
            Owner * owner = (Owner *)[NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.context];
            owner.name = name;
        }
        
        NSError *saveError = NULL;
        [self.context save:&saveError];
        
        if (saveError) {
            return;
        }
        
        NSFetchRequest *ownerFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
        
        NSError *fetchError = NULL;
        NSArray *fetchedObjects = [self.context executeFetchRequest:ownerFetchRequest error:&fetchError];
        
        if (fetchError) {
            NSLog(@"ErrorFethcing | Description : %@ | Reason : %@",fetchError.localizedDescription,fetchError.localizedFailureReason);
            return;
        }
        
        self.owners = fetchedObjects;
    }
}

- (IBAction)colorButtonPressed:(UIBarButtonItem*)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Default Color"
                                                                              message: @"Pick a default color"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Green" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeDefaultColor:@"greenColor"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Blue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeDefaultColor:@"blueColor"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yellow" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeDefaultColor:@"yellowColor"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Red" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeDefaultColor:@"redColor"];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)changeDefaultColor:(NSString *)color {
    NSFetchRequest *colorFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Color"];
    
    NSError *fetchError = NULL;
    NSArray *fetchedObjects = [self.context executeFetchRequest:colorFetchRequest error:&fetchError];
    
    Color *defaultColor;
    
    if (fetchedObjects.count > 0) {
        defaultColor = [fetchedObjects objectAtIndex:0];
    } else {
        defaultColor = (Color *)[NSEntityDescription insertNewObjectForEntityForName:@"Color" inManagedObjectContext:self.context];
    }
    
    defaultColor.choice = color;
    
    NSError *saveError = NULL;
    [self.context save:&saveError];
    
    if (saveError) {
        return;
    }
    
    [self setDefaultColor];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.owners.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnerCell" forIndexPath:indexPath];
    Owner *currentOwner = [self.owners objectAtIndex:indexPath.row];
    cell.textLabel.text = currentOwner.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"showProperties" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProperties"]) {
        OwnerViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.currentOwner = self.owners[self.selectedIndex];
    }
}

@end
