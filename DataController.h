//
//  DataController.h
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/9/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *studentRoster, *teacherRoster;

-(instancetype)initWithTeachersAndStudents;

+(DataController *)sharedData;

-(void)save;

@end
