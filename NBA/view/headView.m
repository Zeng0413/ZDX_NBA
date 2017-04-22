//
//  headView.m
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "headView.h"
#import "matchViewController.h"

@implementation headView

+(instancetype)initWithHeadView:(NSInteger)totalGame :(match *)model :(CGRect)rect{
    headView *view = [[self alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, [UIScreen mainScreen].bounds.size.width-80, 10)];
    lable.textColor = [UIColor darkGrayColor];
    lable.font = [UIFont systemFontOfSize:12];
    NSString *week = model.week;
    week = [week substringFromIndex:2];
    week = [NSString stringWithFormat:@"周%@",week];
    [lable setTextAlignment:NSTextAlignmentCenter];
    NSString *date = model.startTime;
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
    NSArray *strList = [date componentsSeparatedByCharactersInSet:set];
    date = strList[0];
    set = [NSCharacterSet characterSetWithCharactersInString:@"\"-"];
    strList = [date componentsSeparatedByCharactersInSet:set];
    NSString *str1 = strList[1];
    NSString *str2 = strList[2];
    date = [NSString stringWithFormat:@"%@/%@",str1,str2];
    
    if (model == nil) {
        lable.text = @"得分";

    }else{
        lable.text = [NSString stringWithFormat:@"%@ %@ (%zd场比赛)",week,date,totalGame];
    }
    [view addSubview:lable];
    
    matchViewController *cv = [[matchViewController alloc] init];
    UIButton *leftBT = [[UIButton alloc] initWithFrame:CGRectMake(3, 10, 30, 10)];
    [leftBT addTarget:cv action:@selector(leftaction:) forControlEvents:UIControlEventTouchUpInside];
    leftBT.titleLabel.font = [UIFont systemFontOfSize:8];
    [leftBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBT setTitle:@"前一天" forState:UIControlStateNormal];
    [view addSubview:leftBT];
    
    UIButton *rigthBT = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-25, 10, 30, 10)];
    [rigthBT addTarget:cv action:@selector(rigthaction:) forControlEvents:UIControlEventTouchUpInside];
    rigthBT.titleLabel.font = [UIFont systemFontOfSize:8];
    [rigthBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rigthBT setTitle:@"后一天" forState:UIControlStateNormal];
    [view addSubview:rigthBT];
    return view;
}

-(void)leftaction:(UIButton *)sender{
    sender.tag=1;
    NSUInteger index = sender.tag;
    [self.delegate actionDE:index];
}

-(void)rigthaction:(UIButton *)sender{
    sender.tag=2;
    NSUInteger index = sender.tag;
    [self.delegate actionDE:index];
}

@end
