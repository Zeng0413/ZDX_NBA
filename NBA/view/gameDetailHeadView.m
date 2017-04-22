//
//  gameDetailHeadView.m
//  NBA
//
//  Created by zdx on 2017/3/17.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "gameDetailHeadView.h"
#import "SDAutoLayout.h"


@implementation gameDetailHeadView
{
    
}


+(instancetype)initWithView:(matchDeatil *)model{
    
    gameDetailHeadView *view = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/5)];
    
    
    
    return view;
}

@end
