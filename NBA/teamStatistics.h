//
//  teamStatistics.h
//  NBA
//
//  Created by zdx on 2017/3/23.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "theGameTeamStatistics.h"
@interface teamStatistics : UITableViewCell

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic)theGameTeamStatistics *model;
@end
