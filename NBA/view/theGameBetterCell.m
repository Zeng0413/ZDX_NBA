//
//  theGameBetterCell.m
//  NBA
//
//  Created by zdx on 2017/3/18.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "theGameBetterCell.h"

@implementation theGameBetterCell
{
    UILabel *labelLeftPlayerName;
    UILabel *lableLeftplayerPosition;
    UILabel *lableLeftPlayerScore;
    UILabel *text;

    UILabel *labelRightPlayerName;
    UILabel *lableRightplayerPosition;
    UILabel *lableRightPlayerScore;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSetup];
    }
    return self;
}

-(void)initSetup{
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    _leftImageView.userInteractionEnabled = YES;
    _leftImageView.layer.masksToBounds = YES;
    _leftImageView.layer.cornerRadius = 20;
    _leftImageView.layer.borderWidth=1;
    _leftImageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    _leftBT = [UIButton new];
    [_leftBT setBackgroundColor:[UIColor clearColor]];
    [_leftImageView addSubview:_leftBT];
    
    labelLeftPlayerName = [UILabel new];
    labelLeftPlayerName.textColor = [UIColor darkGrayColor];
    labelLeftPlayerName.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:labelLeftPlayerName];
    
    lableLeftplayerPosition = [UILabel new];
    lableLeftplayerPosition.textColor = [UIColor darkGrayColor];
    lableLeftplayerPosition.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lableLeftplayerPosition];
    
    lableLeftPlayerScore = [UILabel new];
    lableLeftPlayerScore.textColor = [UIColor blackColor];
    lableLeftPlayerScore.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lableLeftPlayerScore];
    
    text = [UILabel new];
    text.textColor = [UIColor darkGrayColor];
    text.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [text setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:text];
    
    _rightImageView = [UIImageView new];
    [self.contentView addSubview:_rightImageView];
    _rightImageView.userInteractionEnabled = YES;
    _rightImageView.layer.masksToBounds = YES;
    _rightImageView.layer.cornerRadius = 20;
    _rightImageView.layer.borderWidth=1;
    _rightImageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    _rightBT = [UIButton new];
    [_rightBT setBackgroundColor:[UIColor clearColor]];
    [_rightImageView addSubview:_rightBT];
    
    labelRightPlayerName = [UILabel new];
    labelRightPlayerName.textColor = [UIColor darkGrayColor];
    labelRightPlayerName.font = [UIFont systemFontOfSize:12];
    labelRightPlayerName.numberOfLines = 0;
    [labelRightPlayerName setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:labelRightPlayerName];
    
    lableRightplayerPosition = [UILabel new];
    lableRightplayerPosition.textColor = [UIColor darkGrayColor];
    lableRightplayerPosition.font = [UIFont systemFontOfSize:12];
    [lableRightplayerPosition setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:lableRightplayerPosition];
    
    lableRightPlayerScore = [UILabel new];
    lableRightPlayerScore.textColor = [UIColor blackColor];
    lableRightPlayerScore.font = [UIFont systemFontOfSize:14];
    [lableRightPlayerScore setTextAlignment:NSTextAlignmentRight];

    [self.contentView addSubview:lableRightPlayerScore];
    
    _leftImageView.sd_layout
    .widthIs(35)
    .heightIs(35)
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 15);
    
    _leftBT.sd_layout
    .widthIs(35)
    .heightIs(35)
    .leftEqualToView(_leftImageView)
    .topEqualToView(_leftImageView);
    
    labelLeftPlayerName.sd_layout
    .leftEqualToView(_leftImageView)
    .topSpaceToView(_leftImageView, 5)
    .widthIs(1000)
    .heightIs(20);
    
    lableLeftplayerPosition.sd_layout
    .leftEqualToView(labelLeftPlayerName)
    .topSpaceToView(labelLeftPlayerName, 5)
    .widthIs(100)
    .heightIs(20);
    
    lableLeftPlayerScore.sd_layout
    .leftSpaceToView(_leftImageView, 10)
    .topSpaceToView(self.contentView, 20)
    .widthIs(30);
    
    
    
    
    _rightImageView.sd_layout
    .widthIs(35)
    .heightIs(35)
    .rightSpaceToView(self.contentView, 10)
    .topEqualToView(_leftImageView);
    
    _rightBT.sd_layout
    .widthIs(35)
    .heightIs(35)
    .rightEqualToView(_rightImageView)
    .topEqualToView(_rightImageView);
    
    labelRightPlayerName.sd_layout
    .rightEqualToView(_rightImageView)
    .topEqualToView(labelLeftPlayerName)
    .heightIs(20)
    .widthIs(100);
    
    lableRightplayerPosition.sd_layout
    .rightEqualToView(labelRightPlayerName)
    .topEqualToView(lableLeftplayerPosition)
    .widthIs(100)
    .heightIs(20);
    
    lableRightPlayerScore.sd_layout
    .rightSpaceToView(_rightImageView, 10)
    .topEqualToView(lableLeftPlayerScore)
    .widthIs(30);
    
    text.sd_layout
    .leftSpaceToView(_leftImageView, 5)
    .rightSpaceToView(_rightImageView,5)
    .topSpaceToView(_leftImageView, 0)
    .heightIs(15);
    
    [self setupAutoHeightWithBottomView:lableLeftplayerPosition bottomMargin:4];

    
}

-(void)setModel:(maxPlayers *)model{
    _model = model;
    
    text.text = model.text;
    lableLeftPlayerScore.text = model.leftVal;
    lableRightPlayerScore.text = model.rightVal;
    
    
    theGamePlayer *leftTheGameModel = [theGamePlayer initWithGamePlayerData:model.leftPlayer];
    labelLeftPlayerName.text = leftTheGameModel.name;
    NSString *playerNum = leftTheGameModel.jerseyNum;
    lableLeftplayerPosition.text = [NSString stringWithFormat:@"%@ #%@",leftTheGameModel.position,playerNum];
    
    theGamePlayer *rightTheGameModel = [theGamePlayer initWithGamePlayerData:model.rightPlayer];
    labelRightPlayerName.text = rightTheGameModel.name;
    playerNum = rightTheGameModel.jerseyNum;
    lableRightplayerPosition.text = [NSString stringWithFormat:@"%@ #%@",rightTheGameModel.position,playerNum];
    
    NSURL *url = [NSURL URLWithString:leftTheGameModel.icon];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (leftTheGameModel.iconData) {
        _leftImageView.image = [UIImage imageWithData:leftTheGameModel.iconData];
    }else{
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError) {
                NSLog(@"%@",connectionError);
                return;
            }
            UIImage *image = [UIImage imageWithData:data];
            _leftImageView.image = image;
            
            leftTheGameModel.iconData = data;
            //                ZDXDatabaseManager *manager = [ZDXDatabaseManager sharedMangager];
            //                [manager updateSigth:temp];
        }];
    }
    
    url = [NSURL URLWithString:rightTheGameModel.icon];
    request = [NSURLRequest requestWithURL:url];
    if (rightTheGameModel.iconData) {
        _rightImageView.image = [UIImage imageWithData:rightTheGameModel.iconData];
    }else{
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError) {
                NSLog(@"%@",connectionError);
                return;
            }
            UIImage *image = [UIImage imageWithData:data];
            _rightImageView.image = image;
            
            rightTheGameModel.iconData = data;
            //                ZDXDatabaseManager *manager = [ZDXDatabaseManager sharedMangager];
            //                [manager updateSigth:temp];
        }];
    }
    
}

-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
}
@end
