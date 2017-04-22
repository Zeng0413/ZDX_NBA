//
//  playerTableHeadView.m
//  NBA
//
//  Created by zdx on 2017/4/4.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "playerTableHeadView.h"
#import "comnous.h"
#import "SDAutoLayout.h"

@implementation playerTableHeadView

+(instancetype)initWithPlayerHeadView:(playerModel *)playerModel :(playerData *)dataModel{
    NSInteger height = 80;
    playerTableHeadView *view = [[self alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/4-15+height+45)];
    if (playerModel && dataModel) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)-height+25-45)];
        imageView.alpha = 0.9;
        imageView.image = [UIImage imageNamed:@"timg"];
        
        [view addSubview:imageView];
        
        UIImageView *imagePlayer = [UIImageView new];
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSData *data = [user objectForKey:@"picData"];
        NSURL *url = [NSURL URLWithString:playerModel.picFromSIB];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError) {
                NSLog(@"%@",connectionError);
                return;
            }
            imagePlayer.image = [UIImage imageWithData:data];
        
        }];
        
        
        [view addSubview:imagePlayer];
        
        UILabel *playerName = [UILabel new];
        playerName.textColor = [UIColor whiteColor];
        playerName.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        NSString *num = playerModel.jerseyNum;
        NSString *name = playerModel.cnName;
        playerName.text = [NSString stringWithFormat:@"%@  %@",num,name];
        [playerName setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:playerName];
        
        UILabel *enName = [UILabel new];
        NSString *enName1 = playerModel.enName;
        enName.text = enName1;
        enName.textColor = [UIColor whiteColor];
        enName.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [enName setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:enName];
        
        UILabel *detail1 = [UILabel new];
        NSString *position = playerModel.position;
        NSString *height1 = playerModel.height;
        NSString *weight = playerModel.weight;
        detail1.text = [NSString stringWithFormat:@"%@  %@  %@",position,height1,weight];
        detail1.textColor = [UIColor whiteColor];
        detail1.font = [UIFont systemFontOfSize:13];
        [detail1 setTextAlignment:NSTextAlignmentLeft];
        [view addSubview:detail1];
        
        UILabel *detail2 = [UILabel new];
        detail2.textColor = [UIColor whiteColor];
        detail2.font = [UIFont systemFontOfSize:13];
        [detail2 setTextAlignment:NSTextAlignmentLeft];
        [view addSubview:detail2];
        NSString *birth = playerModel.birthDate;
        NSString *draftYear = playerModel.draftYear;
        detail2.text = [NSString stringWithFormat:@"生日：%@  选秀：%@",birth,draftYear];
        
        imagePlayer.sd_layout
        .widthIs(84)
        .heightIs(70)
        .leftSpaceToView(view, 10)
        .bottomSpaceToView(view, 2+height-25+45);
        
        detail2.sd_layout
        .leftSpaceToView(imagePlayer, 5)
        .widthIs(250)
        .heightIs(15)
        .bottomSpaceToView(view, 8+height-25+45);
        
        detail1.sd_layout
        .leftSpaceToView(imagePlayer, 5)
        .widthIs(200)
        .heightIs(15)
        .bottomSpaceToView(detail2, 5);
        
        
        enName.sd_layout
        .leftSpaceToView(view, 40)
        .rightSpaceToView(view, 40)
        .heightIs(10)
        .bottomSpaceToView(detail1, 15);
        
        playerName.sd_layout
        .leftSpaceToView(view, 40)
        .rightSpaceToView(view, 40)
        .heightIs(20)
        .bottomSpaceToView(enName, 5);
        
        
        UIView *scoreView = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height, screenWidth, height-25)];
        scoreView.backgroundColor = [UIColor yellowColor];
        [view addSubview:scoreView];
        
        for (int i=0; i<5; i++) {
            UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(screenWidth/5*i, 0, screenWidth/5, height-25)];
            subView.tag = i;
            subView.backgroundColor = [UIColor whiteColor];
            [scoreView addSubview:subView];
        }
        NSArray *temp = scoreView.subviews;
        
        if (dataModel) {
            
            NSArray *scoreArray = @[dataModel.pointsPG,dataModel.reboundsPG,dataModel.assistsPG,dataModel.blocksPG,dataModel.stealsPG];
            NSArray *titleArray = @[@"场均得分",@"场均篮板",@"场均助攻",@"场均盖帽",@"场均抢断"];
            
            for (UIView *subView in temp) {
                UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, subView.frame.size.width, 16)];
                score.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
                score.textColor = [UIColor blackColor];
                [score setTextAlignment:NSTextAlignmentCenter];
                
                UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, score.frame.origin.y+score.frame.size.height+8, subView.frame.size.width, 15)];
                title.font = [UIFont systemFontOfSize:12];
                title.textColor = [UIColor grayColor];
                [title setTextAlignment:NSTextAlignmentCenter];
                
                score.text = scoreArray[subView.tag];
                title.text = titleArray[subView.tag];
                [subView addSubview:score];
                [subView addSubview:title];
            }
        }
       
    }
    view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    return view;
}


-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    
}
@end
