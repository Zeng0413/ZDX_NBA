//
//  headView.h
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "match.h"

@protocol actionDelegate <NSObject>

-(void)actionDE:(NSUInteger)index;

@end

@interface headView : UIView

@property (copy, nonatomic) NSString *lable;

@property (weak, nonatomic) id<actionDelegate>delegate;

+(instancetype)initWithHeadView:(NSInteger)totalGame:(match *)model :(CGRect)rect;


@end
