//
//  OwnerViewController.m
//  PropertyManager
//
//  Created by bitbender on 4/3/17.
//  Copyright © 2017 Key. All rights reserved.
//

#import "OwnerViewController.h"
#import "CoreDataManager.h"
#import "Property+CoreDataClass.h"
#import "Color+CoreDataClass.h"
#import "PropertyViewController.h"

@interface OwnerViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)plusButtonPressed:(id)sender;
@property (weak, nonatomic) NSArray * properties;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) BOOL newProperty;
@end

@implementation OwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = self.currentOwner.name;
    [self setupData];
    [self setDefaultColor];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData {
    self.context = [[CoreDataManager shared] managedObjectContext];
    
    self.properties = self.currentOwner.properties;
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
    return self.properties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyCell" forIndexPath:indexPath];
    Property *currentProperty = [self.properties objectAtIndex:indexPath.row];
    cell.textLabel.text = currentProperty.location;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", currentProperty.price];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"showProperty" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProperty"]) {
        PropertyViewController *destinationViewController = [segue destinationViewController];
        if (self.newProperty) {
            destinationViewController.currentProperty = (Property *)[NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:self.context];
        } else {
            destinationViewController.currentProperty = self.properties[self.selectedIndex];
        }
        destinationViewController.currentOwner = self.currentOwner;
    }
}

- (IBAction)plusButtonPressed:(id)sender {
    self.newProperty = YES;
    [self performSegueWithIdentifier:@"showProperty" sender:self];
}
@end
