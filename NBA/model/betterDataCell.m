//
//  betterDataCell.m
//  NBA
//
//  Created by zdx on 2017/3/29.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "betterDataCell.h"


@implementation betterDataCell
{
    UILabel *lableRank;
    UILabel *lableScore;
    UILabel *lableName;
    UILabel *lableTeamName;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSetup];
    }
    return self;
}

-(void)initSetup{
    _playerImage = [UIImageView new];
    [self.contentView addSubview:_playerImage];
    
    _lableRank = [UILabel new];
    _lableRank.textColor = [UIColor grayColor];
    _lableRank.font = [UIFont systemFontOfSize:12];
    [_lableRank setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_lableRank];
    
    lableScore = [UILabel new];
    lableScore.textColor = [UIColor blackColor];
    lableScore.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    [lableScore setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:lableScore];
    
    lableName = [UILabel new];
    lableName.textColor = [UIColor grayColor];
    lableName.font = [UIFont systemFontOfSize:13];
    [lableName setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:lableName];
    
    lableTeamName = [UILabel new];
    lableTeamName.textColor = [UIColor lightGrayColor];
    lableTeamName.font = [UIFont systemFontOfSize:12];
    [lableTeamName setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:lableTeamName];
    
    _lableRank.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .widthIs(25)
    .heightIs(10);
    
    lableScore.sd_layout
    .leftSpaceToView(self.contentView, 11)
    .topSpaceToView(_lableRank, 5)
    .widthIs(50)
    .heightIs(30);
    
    lableName.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(lableScore, 10)
    .widthIs(120)
    .heightIs(10);
    
    lableTeamName.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(lableName, 10)
    .widthIs(100)
    .heightIs(10);
    
    _playerImage.sd_layout
    .widthIs(100)
    .heightIs(80)
    .bottomSpaceToView(self.contentView, 5)
    .rightSpaceToView(self.contentView, 20);
    
    [self setupAutoHeightWithBottomView:lableTeamName bottomMargin:5];
    
}

-(void)setModel:(betterData *)model{
    float pg = [model.PG floatValue];
    lableScore.text = [NSString stringWithFormat:@"%.1f",pg];
    lableName.text = model.cnName;
    lableTeamName.text = model.teamName;
    
    if(model.picData){
        self.playerImage.image = [UIImage imageWithData:model.picData];
    }
    
    
}








@end
