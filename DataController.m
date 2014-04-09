//
//  DataController.m
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/9/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "DataController.h"
#import "PersonTableViewCell.h"
#import "person.h"

@implementation DataController

+(DataController *)sharedData {
    static dispatch_once_t pred;
    static DataController *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[DataController alloc] initWithTeachersAndStudents];
    });
    return shared;
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

-(instancetype)initWithTeachersAndStudents
{
    self = [super init];
    
    NSString *teacherPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Teachers.plist"];
    NSString *studentPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Students.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:teacherPath] && [[NSFileManager defaultManager] fileExistsAtPath:studentPath])
    {
        self.teacherRoster = [NSKeyedUnarchiver unarchiveObjectWithFile:teacherPath];
        self.studentRoster = [NSKeyedUnarchiver unarchiveObjectWithFile:studentPath];
        
    } else {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    NSDictionary *peopleDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *tempTeacherRoster = [peopleDictionary objectForKey:@"Teachers"];
    NSArray *tempStudentRoster = [peopleDictionary objectForKey:@"Students"];
    
    self.teacherRoster = [[NSMutableArray alloc] init];
    self.studentRoster = [[NSMutableArray alloc] init];
    
    for (NSDictionary *teacherDictionary in tempTeacherRoster) {
        Person *newPerson = [[Person alloc] init];
        newPerson.FirstName = [teacherDictionary objectForKey:@"FirstName"];
        newPerson.LastName = [teacherDictionary objectForKey:@"LastName"];
        [self.teacherRoster addObject:newPerson];
    }
    
    for (NSDictionary *studentDictionary in tempStudentRoster) {
        Person *newPerson = [[Person alloc] init];
        newPerson.FirstName = [studentDictionary objectForKey:@"FirstName"];
        newPerson.LastName = [studentDictionary objectForKey:@"LastName"];
        [self.studentRoster addObject:newPerson];
    }
        
    [NSKeyedArchiver archiveRootObject:self.teacherRoster toFile:teacherPath];
    [NSKeyedArchiver archiveRootObject:self.studentRoster toFile:studentPath];
    }
    return self;
    
}

-(NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

-(BOOL)checkForPlistFileInDocs:(NSString*)fileName
{
    NSError *error;
    
    NSFileManager *myManager = [NSFileManager defaultManager];
    
    NSString *pathForPlistInBundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    
    NSString *pathForPlistInDocs = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    
    return [myManager fileExistsAtPath:pathForPlistInDocs];
    
    
    [myManager copyItemAtPath:pathForPlistInBundle toPath:pathForPlistInDocs error:&error];
    
    
    return NO;
}

-(void)save
{
    NSString *teacherPlistPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Teachers.plist"];
    NSString *studentPlistPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Students.plist"];

    
    [NSKeyedArchiver archiveRootObject:self.teacherRoster toFile:teacherPlistPath];
    [NSKeyedArchiver archiveRootObject:self.studentRoster toFile:studentPlistPath];
     
     }

@end
