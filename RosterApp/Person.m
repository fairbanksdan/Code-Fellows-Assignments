//
//  Person.m
//  RosterApp
//
//  Created by Daniel Fairbanks on 4/7/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "Person.h"

@implementation Person

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.firstName = [aDecoder decodeObjectForKey:@"firstName"];
        self.lastName = [aDecoder decodeObjectForKey:@"lastName"];
        self.headShot = [UIImage imageWithData: [aDecoder decodeObjectForKey:@"headShot"]];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.firstName forKey:@"firstName"];
    [aCoder encodeObject:self.lastName forKey:@"lastName"];
    [aCoder encodeObject:UIImagePNGRepresentation(self.headShot) forKey:@"headShot"];
}

@end
