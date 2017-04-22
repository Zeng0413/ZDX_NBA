//
//  tableViewHeadView.h
//  NBA
//
//  Created by zdx on 2017/3/21.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "teamScore.h"
#import "SDAutoLayout.h"
@interface tableViewHeadView : UIView

+(instancetype)initWithHeadView:(teamScore *)model;

@end
