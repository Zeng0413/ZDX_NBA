//
//  teamStatistics.m
//  NBA
//
//  Created by zdx on 2017/3/23.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "teamStatistics.h"
#import "SDAutoLayout.h"

@implementation teamStatistics
{
    UILabel *leftVal;
    UILabel *rightVal;
    UILabel *text;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSetup];
    }
    
    return self;
}



-(void)initSetup{
    
    
    
    leftVal = [UILabel new];
    leftVal.textColor = [UIColor blackColor];
    leftVal.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [leftVal setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:leftVal];
    
    _leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImageView];
    
    _rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImageView];
    
    rightVal = [UILabel new];
    rightVal.textColor = [UIColor blackColor];
    rightVal.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [rightVal setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:rightVal];
    
    text = [UILabel new];
    text.textColor = [UIColor grayColor];
    text.font = [UIFont systemFontOfSize:12];
    [text setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:text];
    
    _leftImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(25)
    .heightIs(25);
    
    _rightImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(25)
    .heightIs(25);
    
    leftVal.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(30)
    .heightIs(30);
    
    
    rightVal.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(30)
    .heightIs(30);
    
    text.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 50)
    .leftSpaceToView(self.contentView, 50)
    .heightIs(15);
    
    
    
    [self setupAutoHeightWithBottomView:leftVal bottomMargin:5];
}

-(void)setModel:(theGameTeamStatistics *)model{
    _model = model;
    leftVal.text = model.leftVal;
    rightVal.text = model.rightVal;
    text.text = model.text;
    
}
-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    
}
@end
