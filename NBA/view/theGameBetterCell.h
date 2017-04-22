//
//  theGameBetterCell.h
//  NBA
//
//  Created by zdx on 2017/3/18.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "SDAutoLayout.h"
#import "maxPlayers.h"
#import "theGamePlayer.h"



@interface theGameBetterCell : UITableViewCell

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIButton *leftBT;
@property (strong, nonatomic) UIButton *rightBT;
@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) maxPlayers *model;
@end
