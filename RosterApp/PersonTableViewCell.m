//
//  PersonTableViewCell.m
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/8/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "PersonTableViewCell.h"

@implementation PersonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
