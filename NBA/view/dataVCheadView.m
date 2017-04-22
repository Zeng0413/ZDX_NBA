//
//  dataVCheadView.m
//  NBA
//
//  Created by zdx on 2017/3/26.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "dataVCheadView.h"
#import "comnous.h"

@implementation dataVCheadView

+(instancetype)initWithView{
    dataVCheadView *view = [[self alloc] initWithFrame:CGRectMake(0, 44+20, screenWidth, 73)];
    
    [view setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];

    return view;
}

@end
