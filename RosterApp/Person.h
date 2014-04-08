//
//  Person.h
//  RosterApp
//
//  Created by Daniel Fairbanks on 4/7/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) UIImage *headShot;

typedef NS_ENUM(NSInteger, personType) {
    student,
    teacher
};

@property (nonatomic) personType type;

@end
