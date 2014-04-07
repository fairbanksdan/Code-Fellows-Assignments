//
//  ViewController.m
//  RosterApp
//
//  Created by Daniel Fairbanks on 4/7/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *studentRoster;

@property (nonatomic, strong) NSMutableArray *teacherRoster;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.studentRoster = [[NSMutableArray alloc] init];
    
    self.teacherRoster = [[NSMutableArray alloc] init];
    
    Person *teacherOne = [Person new];
    teacherOne.firstName = @"John";
    teacherOne.lastName = @"Clem";
    
    Person *teacherTwo = [Person new];
    teacherTwo.firstName = @"Brad";
    teacherTwo.lastName = @"Johnson";
    
    [self.teacherRoster addObject:teacherOne];
    [self.teacherRoster addObject:teacherTwo];
    
    Person *studentOne = [Person new];
    studentOne.firstName = @"Dan";
    studentOne.lastName = @"Fairbanks";
    
    Person *studentTwo = [Person new];
    studentTwo.firstName = @"Reed";
    studentTwo.lastName = @"Sweeney";
    
    Person *studentThree = [Person new];
    studentThree.firstName = @"Micheal";
    studentThree.lastName = @"Bably";
    
    Person *studentFour = [Person new];
    studentFour.firstName = @"Cole";
    studentFour.lastName = @"Bratcher";
    
    Person *studentFive = [Person new];
    studentFive.firstName = @"Christopher";
    studentFive.lastName = @"Cohan";
    
    [self.studentRoster addObject:studentOne];
    [self.studentRoster addObject:studentTwo];
    [self.studentRoster addObject:studentThree];
    [self.studentRoster addObject:studentFour];
    [self.studentRoster addObject:studentFive];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return @"Teachers";
    } else {
        return @"Students";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.teacherRoster.count;
    } else {
    return self.studentRoster.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Person *myPerson;
    
    if (indexPath.section == 0) {
        myPerson = [self.teacherRoster objectAtIndex:indexPath.row];
    } else {
        myPerson = [self.studentRoster objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = myPerson.firstName;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *personVC = segue.destinationViewController;
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    
    Person *myPerson;
    
    if (myIndexPath.section == 0) {
        myPerson = [self.teacherRoster objectAtIndex:myIndexPath.row];
    } else {
        myPerson = [self.studentRoster objectAtIndex:myIndexPath.row];
    }
    
    personVC.title = [NSString stringWithFormat:@"%@ %@", myPerson.firstName, myPerson.lastName];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
