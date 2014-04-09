//
//  ViewController.m
//  RosterApp
//
//  Created by Daniel Fairbanks on 4/7/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonTableViewCell.h"
#import "PersonViewController.h"
#import "DataController.h"

@interface ViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DataController *myDataController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.myDataController = [[DataController sharedData] initWithTeachersAndStudents];
    
    self.tableView.dataSource = self.myDataController;
    self.tableView.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonViewController *personVC = segue.destinationViewController;
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    
    Person *myPerson;
    
    if ([segue.identifier isEqualToString:@"CreatePerson"]) {
        myPerson = [Person new];
        [[[DataController sharedData] studentRoster] addObject:myPerson];
    } else {
        if (myIndexPath.section == 0) {
            myPerson = [self.myDataController.teacherRoster objectAtIndex:myIndexPath.row];
        } else {
            myPerson = [self.myDataController.studentRoster objectAtIndex:myIndexPath.row];
        }
    }
    
   
    
    personVC.selectedPerson = myPerson;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
