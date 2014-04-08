//
//  PersonTableViewCell.h
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/8/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *thumbnailHeadShot;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end
