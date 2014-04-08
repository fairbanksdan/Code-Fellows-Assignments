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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *studentRoster;

@property (nonatomic, strong) NSMutableArray *teacherRoster;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.studentRoster = [[NSMutableArray alloc] init];
    
    self.teacherRoster = [[NSMutableArray alloc] init];
    
    Person *teacherOne = [Person new];
    teacherOne.firstName = @"John";
    teacherOne.lastName = @"Clem";
    teacherOne.type = teacher;
    
    Person *teacherTwo = [Person new];
    teacherTwo.firstName = @"Brad";
    teacherTwo.lastName = @"Johnson";
    teacherOne.type = teacher;
    
    [self.teacherRoster addObject:teacherOne];
    [self.teacherRoster addObject:teacherTwo];
    
    Person *studentOne = [Person new];
    studentOne.firstName = @"Dan";
    studentOne.lastName = @"Fairbanks";
    studentOne.type = student;
    
    Person *studentTwo = [Person new];
    studentTwo.firstName = @"Reed";
    studentTwo.lastName = @"Sweeney";
    studentOne.type = student;
    
    Person *studentThree = [Person new];
    studentThree.firstName = @"Micheal";
    studentThree.lastName = @"Bably";
    studentOne.type = student;
    
    Person *studentFour = [Person new];
    studentFour.firstName = @"Cole";
    studentFour.lastName = @"Bratcher";
    studentOne.type = student;
    
    Person *studentFive = [Person new];
    studentFive.firstName = @"Christopher";
    studentFive.lastName = @"Cohan";
    studentOne.type = student;
    
    Person *studentSix = [Person new];
    studentSix.firstName = @"Lauren";
    studentSix.lastName = @"Lee";
    studentOne.type = student;
    
    Person *studentSeven = [Person new];
    studentSeven.firstName = @"Sean";
    studentSeven.lastName = @"Mcneil";
    studentOne.type = student;
    
    [self.studentRoster addObject:studentOne];
    [self.studentRoster addObject:studentTwo];
    [self.studentRoster addObject:studentThree];
    [self.studentRoster addObject:studentFour];
    [self.studentRoster addObject:studentFive];
    [self.studentRoster addObject:studentSix];
    [self.studentRoster addObject:studentSeven];

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

- (PersonTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Person *myPerson;
    
    if (indexPath.section == 0) {
        myPerson = self.teacherRoster[indexPath.row];
    } else {
        myPerson = self.studentRoster[indexPath.row];
    }
    cell.cellLabel.text = myPerson.firstName;
    cell.headShotImageView.image = myPerson.headShot;
    cell.headShotImageView.layer.cornerRadius = cell.headShotImageView.frame.size.width/2.0;
    cell.headShotImageView.layer.masksToBounds = YES;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonViewController *personVC = segue.destinationViewController;
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    
    Person *myPerson;
    
    if (myIndexPath.section == 0) {
        myPerson = [self.teacherRoster objectAtIndex:myIndexPath.row];
    } else {
        myPerson = [self.studentRoster objectAtIndex:myIndexPath.row];
    }
    
    personVC.selectedPerson = myPerson;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
