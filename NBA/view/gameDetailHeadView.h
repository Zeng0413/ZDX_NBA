//
//  gameDetailHeadView.h
//  NBA
//
//  Created by zdx on 2017/3/17.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "matchDeatil.h"
@interface gameDetailHeadView : UIView


+(instancetype)initWithView:(matchDeatil *)model;
@property (strong, nonatomic) UIImageView *imagePlayer1;
@property (strong, nonatomic) UIImageView *imagePlayer2;

@end
