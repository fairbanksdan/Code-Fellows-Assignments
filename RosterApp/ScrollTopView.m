//
//  ScrollTopView.m
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/10/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "ScrollTopView.h"

@implementation ScrollTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview touchesBegan:touches withEvent:event];
}

@end
