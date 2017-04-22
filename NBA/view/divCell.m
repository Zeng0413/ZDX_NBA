//
//  divCell.m
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "divCell.h"


@implementation divCell
{
    UILabel *lableTitle;
    UILabel *lableStatus;
    UIView *view1;
    UILabel *lablePlayer1Name;
    UILabel *lable1;
    UILabel *lable2;
    UILabel *lablePlayer1Score;
    UIView *view2;
    UILabel *lablePlayer2Score;
    UILabel *lablePlayer2Name;
    UIView *view3;
    UIButton *button;


}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSetup];
    }
    return self;
}


-(void)initSetup{
    lableTitle = [UILabel new];
    lableTitle.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    lableTitle.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:lableTitle];
    
    lableStatus = [UILabel new];
    lableStatus.textColor = [UIColor blackColor];
    lableStatus.font = [UIFont systemFontOfSize:13];
    [lableStatus setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:lableStatus];
    
    view1 = [[UIView alloc] init];
    [view1 setBackgroundColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
    [self.contentView addSubview:view1];
    
    _imagePlayer1 = [UIImageView new];
    [self.contentView addSubview:_imagePlayer1];
    
    lablePlayer1Name = [UILabel new];
    lablePlayer1Name.textColor = [UIColor darkGrayColor];
    lablePlayer1Name.font = [UIFont systemFontOfSize:12];
    lablePlayer1Name.numberOfLines = 0;
    [lablePlayer1Name setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:lablePlayer1Name];
    
    lable1 = [UILabel new];
    lable1.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    lable1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lable1];
    
    lable2 = [UILabel new];
    lable2.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    lable2.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lable2];
    
    lablePlayer1Score = [UILabel new];
    lablePlayer1Score.textColor = [UIColor blackColor];
    lablePlayer1Score.font = [UIFont systemFontOfSize:20];
    [lablePlayer1Score setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:lablePlayer1Score];
    
    view2 = [[UIView alloc] init];
    [view2 setBackgroundColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
    [self.contentView addSubview:view2];
    
    lablePlayer2Score = [UILabel new];
    lablePlayer2Score.textColor = [UIColor blackColor];
    lablePlayer2Score.font = [UIFont systemFontOfSize:20];
    [lablePlayer2Score setTextAlignment:NSTextAlignmentCenter];

    [self.contentView addSubview:lablePlayer2Score];
    
    _imagePlayer2 = [UIImageView new];
    [self.contentView addSubview:_imagePlayer2];
    
    lablePlayer2Name = [UILabel new];
    lablePlayer2Name.textColor = [UIColor darkGrayColor];
    lablePlayer2Name.font = [UIFont systemFontOfSize:12];
    [lablePlayer2Name setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:lablePlayer2Name];
    
    
    view3 = [[UIView alloc] init];
    [view3 setBackgroundColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
    [self.contentView addSubview:view3];
    
    button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    
    CGFloat margin = 10;
    int center = CGRectGetWidth(self.contentView.bounds)/2;
    NSLog(@"%d",center);
    
    UIView *contentView = self.contentView;
    
    lableTitle.sd_layout
    .autoHeightRatio(0)
    .widthIs(57)
    .topSpaceToView(contentView, margin)
    .leftSpaceToView(contentView, margin);
    

    lableStatus.sd_layout
    .rightSpaceToView(contentView, 80)
    .topEqualToView(lableTitle)
    .leftSpaceToView(contentView, 80);
    
    
    view1.sd_layout
    .rightSpaceToView(contentView, 0)
    .heightIs(1)
    .topSpaceToView(lableTitle, 4)
    .leftSpaceToView(contentView, 0);
    
    self.imagePlayer1.sd_layout
    .widthIs(78)
    .heightIs(78)
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(view1, 30);
    
    lablePlayer1Name.sd_layout
    .leftSpaceToView(contentView, 20)
    .rightSpaceToView(contentView, center+center/2)
    .heightIs(10)
    .topSpaceToView(self.imagePlayer1, 5);
    
    lable1.sd_layout
    .rightSpaceToView(contentView, center)
    .widthIs(65)
    .heightIs(10)
    .topSpaceToView(view1, 10);
    
    
    view2.sd_layout
    .widthIs(1)
    .heightIs(30)
    .topSpaceToView(lable1, 20)
    .rightEqualToView(lable1);
    

    lablePlayer1Score.sd_layout
    .widthIs(35)
    .heightIs(25)
    .rightSpaceToView(view2, 10)
    .topSpaceToView(lable1, 20);
    
    lable2.sd_layout
    .leftSpaceToView(view2, 10)
    .widthIs(55)
    .heightIs(10)
    .topSpaceToView(view1, 10);
    
    lablePlayer2Score.sd_layout
    .widthIs(35)
    .heightIs(25)
    .topSpaceToView(lable2, 20)
    .leftSpaceToView(view2, 10);
    
    _imagePlayer2.sd_layout
    .widthIs(78)
    .heightIs(78)
    .rightSpaceToView(contentView, 20)
    .topSpaceToView(view1, 30);
    
    lablePlayer2Name.sd_layout
    .rightSpaceToView(contentView, 30)
    .leftSpaceToView(contentView, center+center/2)
    .heightIs(10)
    .topSpaceToView(_imagePlayer2, 5);
    
    view3.sd_layout
    .rightSpaceToView(contentView, 0)
    .heightIs(1)
    .topSpaceToView(lablePlayer2Name, 8)
    .leftSpaceToView(contentView, 0);
    
    button.sd_layout
    .widthIs(70)
    .heightIs(20)
    .leftSpaceToView(contentView, center-40)
    .topSpaceToView(view3, 4);
    [self setupAutoHeightWithBottomView:button bottomMargin:4];
}

-(void)setModel:(match *)model{
    _model = model;
    lableTitle.text = model.matchDesc;
    int status = [model.matchPeriod intValue];
    if (status == 1) {
        NSString *str1 = @"直播";
        NSString *str2 = model.quarter;
        NSString *str3 = model.quarterTime;
        lableStatus.text = [NSString stringWithFormat:@"%@ %@ %@",str1, str2, str3];
        lableStatus.textColor = [UIColor redColor];
    }else if (status == 0){
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
        NSArray *strList = [model.startTime componentsSeparatedByCharactersInSet:set];
        NSString *str = strList[1];
        set = [NSCharacterSet characterSetWithCharactersInString:@"\":"];
        strList = [str componentsSeparatedByCharactersInSet:set];
        lableStatus.text = [NSString stringWithFormat:@"%@:%@",strList[0],strList[1]];
        
    }else if (status == 2){
        lableStatus.text = @"已结束";
    }
    lablePlayer1Name.text = model.leftName;
    lablePlayer2Name.text = model.rightName;
    
    lable1.text = @"NBA联盟通";
    lable2.text = @"BesTV";
    int socre1 = [model.leftGoal intValue];
    int socre2 = [model.rightGoal intValue];
    if (socre1>socre2) {
        lablePlayer2Score.textColor = [UIColor grayColor];
    }else{
        lablePlayer1Score.textColor = [UIColor grayColor];
    }
    lablePlayer1Score.text = model.leftGoal;
    lablePlayer2Score.text = model.rightGoal;

    if(model.leftBadgeData){
        self.imagePlayer1.image = [UIImage imageWithData:model.leftBadgeData];
    }
    if(model.rightBadgeData){
        self.imagePlayer2.image = [UIImage imageWithData:model.rightBadgeData];
    }
    [button setTitle:@"技术统计" forState:UIControlStateNormal];
    
}

-(void)action:(UIButton *)sender{
    NSLog(@"%d",1);
}

-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    
}

@end
