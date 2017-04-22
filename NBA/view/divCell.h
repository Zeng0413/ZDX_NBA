//
//  divCell.h
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "SDAutoLayout.h"
#import "match.h"

@interface divCell : UITableViewCell


@property (strong, nonatomic) UIImageView *imagePlayer1;
@property (strong, nonatomic) UIImageView *imagePlayer2;


@property (strong, nonatomic) match *model;


@end
