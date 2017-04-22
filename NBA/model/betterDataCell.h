//
//  betterDataCell.h
//  NBA
//
//  Created by zdx on 2017/3/29.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "betterData.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "SDAutoLayout.h"
@interface betterDataCell : UITableViewCell

@property (strong, nonatomic) betterData *model;
@property (strong, nonatomic)UIImageView *playerImage;
@property (strong, nonatomic)UIImageView *teamImage;
@property (strong, nonatomic)UILabel *lableRank;
@end
