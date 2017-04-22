//
//  tableViewHeadView.m
//  NBA
//
//  Created by zdx on 2017/3/21.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "tableViewHeadView.h"
#import "comnous.h"
#import "gameDetailViewController.h"
#import "UIImageView+WebCache.h"
@implementation tableViewHeadView


+(instancetype)initWithHeadView:(teamScore *)model{
    
    tableViewHeadView *view = [[self alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/4+38)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))];
    imageView.alpha = 1;
    imageView.image = [UIImage imageNamed:@"bg_games_details"];
    [view addSubview:imageView];
    
    UIImageView *leftImageView = [UIImageView new];
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.leftImageAddress] placeholderImage:[UIImage imageNamed:@"default_list_pic_video"]];
    [view addSubview:leftImageView];
    
    UIImageView *rightImage = [UIImageView new];
    [rightImage sd_setImageWithURL:[NSURL URLWithString:model.rightImageAddress] placeholderImage:[UIImage imageNamed:@"default_list_pic_video"]];
    [view addSubview:rightImage];
    
    UILabel *leftScore = [UILabel new];
    leftScore.textColor = [UIColor whiteColor];
    leftScore.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [leftScore setTextAlignment:NSTextAlignmentLeft];
    leftScore.text = model.leftScore;
    [view addSubview:leftScore];
    
    UILabel *rightScore = [UILabel new];
    rightScore.textColor = [UIColor whiteColor];
    rightScore.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [rightScore setTextAlignment:NSTextAlignmentRight];
    rightScore.text = model.rightScore;
    [view addSubview:rightScore];
    
    UILabel *status = [UILabel new];
    status.textColor = [UIColor whiteColor];
    status.font = [UIFont systemFontOfSize:13];
    [status setTextAlignment:NSTextAlignmentCenter];
    status.text = model.status;
    [view addSubview:status];
    
    UILabel *title = [UILabel new];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [title setTextAlignment:NSTextAlignmentCenter];
    title.text = model.title;
    [view addSubview:title];
    
    UILabel *time = [UILabel new];
    time.textColor = [UIColor whiteColor];
    time.font = [UIFont systemFontOfSize:12];
    [time setTextAlignment:NSTextAlignmentCenter];
    time.text = model.time;
    [view addSubview:time];
    
    float height = screenHeight/4+38;
    
    leftImageView.sd_layout
    .topSpaceToView(view,height/2-20)
    .leftSpaceToView(view, 10)
    .widthIs(45)
    .heightIs(45);
    
    rightImage.sd_layout
    .topEqualToView(leftImageView)
    .rightSpaceToView(view, 10)
    .widthIs(45)
    .heightIs(45);
    
    leftScore.sd_layout
    .topSpaceToView(view, height/2-12)
    .leftSpaceToView(leftImageView, 10)
    .widthIs(60)
    .heightIs(30);
    
    rightScore.sd_layout
    .topEqualToView(leftScore)
    .rightSpaceToView(rightImage, 10)
    .widthIs(60)
    .heightIs(30);
    
    status.sd_layout
    .topSpaceToView(view, height/2-40)
    .leftSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .heightIs(20);
    
    title.sd_layout
    .topEqualToView(leftScore)
    .leftSpaceToView(leftScore, 15)
    .rightSpaceToView(rightScore, 15)
    .heightIs(20);
    
    time.sd_layout
    .bottomSpaceToView(view, 70)
    .leftSpaceToView(view, 20)
    .rightSpaceToView(view, 20)
    .heightIs(20);
    
    return view;
}

-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    
}
@end
