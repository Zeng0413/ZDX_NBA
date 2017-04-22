//
//  playerTableHeadView.h
//  NBA
//
//  Created by zdx on 2017/4/4.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playerModel.h"
#import "playerData.h"
@interface playerTableHeadView : UIView

+(instancetype)initWithPlayerHeadView:(playerModel *)playerModel :(playerData *)dataModel;

@end
