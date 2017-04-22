//
//  playerVC.m
//  NBA
//
//  Created by zdx on 2017/3/30.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "playerVC.h"
#import "comnous.h"
#import "UINavigationBar+Awesome.h"
#import "playerTableHeadView.h"
#import "AFNetworking.h"
#import "playerModel.h"
#import "seasonDataModel.h"
#import "playerData.h"
#import "JYJTableCell.h"
#import "JYJConst.h"
#import "nearGamesModel.h"
#define NAVBAR_CHANGE_POINT 50

@interface playerVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UINavigationBar *bar;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) playerTableHeadView *tableHeadView;
@property (strong, nonatomic) playerModel *playerModel;
@property (strong, nonatomic) playerData *dataModel;
@property (strong, nonatomic) NSMutableArray *seasonArray;
@property (strong, nonatomic) NSMutableArray *curSeasonArray;

@property (strong, nonatomic) NSMutableArray *curformDataArray;
@property (strong, nonatomic) NSMutableArray *curformWidthArray;

@property (strong, nonatomic) NSMutableArray *nearGamesformDataArray;
@property (strong, nonatomic) NSMutableArray *nearWidthformDataArray;

@property (strong, nonatomic) NSMutableArray *careerFormDataArray;



@end

@implementation playerVC
{
    UIButton *leftTeamBT;
    UIButton *rightTeamBT;
    NSInteger status;
}

-(NSMutableArray *)careerFormDataArray{
    if (!_careerFormDataArray) {
        _careerFormDataArray = [NSMutableArray array];
    }
    return _careerFormDataArray;
}

-(NSMutableArray *)nearWidthformDataArray{
    if (!_nearWidthformDataArray) {
        _nearWidthformDataArray = [NSMutableArray array];
    }
    return _nearWidthformDataArray;
}

-(NSMutableArray *)nearGamesformDataArray{
    if (!_nearGamesformDataArray) {
        _nearGamesformDataArray = [NSMutableArray array];
    }
    return _nearGamesformDataArray;
}

-(NSMutableArray *)curformDataArray{
    if (!_curformDataArray) {
        _curformDataArray = [NSMutableArray array];
    }
    return _curformDataArray;
}

-(NSMutableArray *)curformWidthArray{
    if (!_curformWidthArray) {
        _curformWidthArray = [NSMutableArray array];
    }
    return _curformWidthArray;
}

-(NSMutableArray *)curSeasonArray{
    if (!_curSeasonArray) {
        _curSeasonArray = [NSMutableArray array];
    }
    return _curSeasonArray;
}

-(NSMutableArray *)seasonArray{
    if (!_seasonArray) {
        _seasonArray = [NSMutableArray array];
    }
    return _seasonArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self scrollViewDidScroll:self.tableView];
    [self.bar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    status = 1;
    [super viewDidLoad];
    [self initWithTableView];
    [self initWithNavigationBar];
    [self.bar lt_setBackgroundColor:[UIColor clearColor]];
    
    [self initWithSeason];
    [self initWithNearGame];
}

-(void)initWithNearGame{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *playerid = [user objectForKey:@"id"];
    NSString *str = @"cubeId=9&dimId=7%2C8&params=t27%3A2016%7Ct28%3A1%7Ct1%3A";
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@%@&from=sportsdatabase",urlDataString,str,playerid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:stringUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        NSArray *temp = dic[@"nbaPlayerMatch"];
        NSLog(@"%zd",temp.count);
        NSInteger count = temp.count-1;
        NSMutableArray *nearTemp = [NSMutableArray array];
        for (NSInteger i=count; i>count-5; i--) {
            nearGamesModel *model = [nearGamesModel initWithNearGames:temp[i]];
            
            [nearTemp addObject:model];
        }
        NSArray *titleArray = @[@"日期",@"对手",@"时间",@"得分",@"篮板",@"助攻",@"抢断",@"盖帽",@"投篮",@"投篮%",@"三分",@"三分%",@"罚球",@"罚球%",@"前板",@"后板",@"失误",@"犯规"];
        for (int j=0; j<titleArray.count; j++) {
            NSMutableArray *temp1 = [NSMutableArray array];
            NSString *titleStr = titleArray[j];
            [temp1 addObject:titleStr];
            for (nearGamesModel *model in nearTemp) {
                NSString *str;
                if (j==0) {
                    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
                    NSArray *strList = [model.startTime componentsSeparatedByCharactersInSet:set];
                    NSString *str1 = strList[0];
                    set = [NSCharacterSet characterSetWithCharactersInString:@"\"-"];
                    strList = [str1 componentsSeparatedByCharactersInSet:set];
                    str = [NSString stringWithFormat:@"%@年%@月%@日",strList[0],strList[1],strList[2]];
                    
                }
                if (j==1) {
                    NSString *teamId = [user objectForKey:@"teamId"];
                    if (![model.awayId isEqualToString:teamId]) {
                        str = model.awayName;
                    }
                    if (![model.homeId isEqualToString:teamId]) {
                        str = model.homeName;
                    }
                }
                if (j==2) str = model.minutes;
                
                if (j==3) str =model.points;
                
                if (j==4) str = model.rebounds;
                
                if (j==5) str = model.assists;
                
                if (j==6) str = model.steals;
                
                if (j==7) str = model.blocked;
                
                if (j==8){
                    NSString *fieldGoals = model.fieldGoals;
                    NSString *fieldGoalsAttempted = model.fieldGoalsAttempted;
                    str = [NSString stringWithFormat:@"%@/%@",fieldGoals,fieldGoalsAttempted];
                }
             
                if (j==9){
                    float ftTcp = model.fieldGoals.floatValue/model.fieldGoalsAttempted.floatValue;
                    str = [NSString stringWithFormat:@"%.1f",ftTcp*100];
                }
                
                if (j==10){
                    NSString *threePointGoals = model.threePointGoals;
                    NSString *threePointAttempted = model.threePointAttempted;
                    str = [NSString stringWithFormat:@"%@/%@",threePointGoals,threePointAttempted];
                }
                
                if (j==11) {
                    float threeTcp = model.threePointGoals.floatValue/model.threePointAttempted.floatValue;
                    str = [NSString stringWithFormat:@"%.1f",threeTcp*100];
                }
                if (j==12) {
                    NSString *freeThrows = model.freeThrows;
                    NSString *freeThrowsAttempted = model.freeThrowsAttempted;
                    str = [NSString stringWithFormat:@"%@/%@",freeThrows,freeThrowsAttempted];
                }
                if (j==13){
                    float freeTcp = model.freeThrows.floatValue/model.freeThrowsAttempted.floatValue;
                    str = [NSString stringWithFormat:@"%.1f",freeTcp*100];
                }
                
                if (j==14) str = model.offensiveRebounds;
                
                if (j==15) str = model.defensiveRebounds;
                
                if (j==16) str = model.turnovers;
                
                if (j==17) str= model.personalFouls;
                if(str!=nil) [temp1 addObject:str];
                
                
            }
            NSNumber *width;
            if (j==0) {
                width = [NSNumber numberWithFloat:120];
            }else{
                width = [NSNumber numberWithFloat:screenWidth/6];
            }
            [self.nearWidthformDataArray addObject:width];
            [self.nearGamesformDataArray addObject:temp1];
            
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)initWithSeason{

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *playerid = [user objectForKey:@"id"];
    NSString *str = @"cubeId=10&dimId=23&params=t1%3A";
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@%@&from=sportsdatabase",urlDataString,str,playerid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:stringUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSArray *temp = dic[@"nbaPlayerCareer"];
        for (NSDictionary *dict in temp) {
            seasonDataModel *model = [seasonDataModel initWithSeasonData:dict];
            
            [self.seasonArray addObject:model];
        }
        
        for (seasonDataModel *model in self.seasonArray) {
            if ([model.seasonId isEqualToString:@"2016"]) {
                [self.curSeasonArray addObject:model];
            }
        }
        for (int i=0; i<17; i++) {
            NSNumber *width;
            if (i==0) {
                width = [NSNumber numberWithFloat:70];
            }else{
                width = [NSNumber numberWithFloat:screenWidth/6];
            }
            [self.curformWidthArray addObject:width];
        }
        
        NSMutableArray *preseasonGames = [NSMutableArray array];
        NSMutableArray *regularSeason = [NSMutableArray array];
        NSMutableArray *postSeason = [NSMutableArray array];
        for (seasonDataModel *model in self.seasonArray) {
            if ([model.seasonType isEqualToString:@"0"]) {
                [preseasonGames addObject:model];
            }
            if ([model.seasonType isEqualToString:@"1"]) {
                [regularSeason addObject:model];
            }
            if ([model.seasonType isEqualToString:@"2"]) {
                [postSeason addObject:model];
            }
        }
        NSMutableArray *preseasonGames1 = [NSMutableArray array];
        NSMutableArray *regularSeason1 = [NSMutableArray array];
        NSMutableArray *postSeason1 = [NSMutableArray array];
        for (int i=0; i<17; i++) {
            [self.curformDataArray addObject:[self loadData:self.curSeasonArray :i]];
            [preseasonGames1 addObject:[self loadData:preseasonGames :i]];
            [regularSeason1 addObject:[self loadData:regularSeason :i]];
            [postSeason1 addObject:[self loadData:postSeason :i]];
        }
        [self.careerFormDataArray addObject:preseasonGames1];
        [self.careerFormDataArray addObject:regularSeason1];
        [self.careerFormDataArray addObject:preseasonGames1];

        
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(NSMutableArray *)loadData:(NSMutableArray *)array :(int)i{
    NSArray *titleArray = @[@"年度",@"赛季",@"场数",@"先发",@"时间",@"得分",@"篮板",@"助攻",@"抢断",@"盖帽",@"投篮%",@"三分%",@"罚球%",@"前板",@"后板",@"失误",@"犯规"];
    NSMutableArray *temp1 = [NSMutableArray array];
    NSString *titleStr = titleArray[i];
    [temp1 addObject:titleStr];
    for (seasonDataModel *model in array) {
        NSString *str;
        if (i==0) {
            str = [model.seasonId substringFromIndex:2];
            int year = str.intValue;
            str = [NSString stringWithFormat:@"%d/%d",year,year+1];
        }
        if (i==1) {
            if ([model.seasonType isEqualToString:@"0"]) {
                str = @"季前赛";
            }else if ([model.seasonType isEqualToString:@"1"]){
                str = @"常规赛";
            }else if ([model.seasonType isEqualToString:@"2"]){
                str = @"季后赛";
            }
        }
        if (i==2) str = model.games;
        
        if (i==3) str =model.gamesStarted;
        
        if (i==4) str = model.minutesPG;
        
        if (i==5) str = model.pointsPG;
        
        if (i==6) str = model.reboundsPG;
        
        if (i==7) str = model.assistsPG;
        
        if (i==8) str = model.stealsPG;
        
        if (i==9) str = model.blocksPG;
        
        if (i==10){
            float fgPCT = model.fgPCT.floatValue;
            fgPCT = fgPCT*100;
            str = [NSString stringWithFormat:@"%.1f",fgPCT];
        }
        
        if (i==11) {
            float threesPCT = model.threesPCT.floatValue;
            threesPCT = threesPCT*100;
            str = [NSString stringWithFormat:@"%.1f",threesPCT];
        }
        if (i==12) {
            float ftPCT = model.ftPCT.floatValue;
            ftPCT = ftPCT*100;
            str = [NSString stringWithFormat:@"%.1f",ftPCT];
        }
        if (i==13) str = model.offensiveReboundsPG;
        
        if (i==14) str = model.defensiveReboundsPG;
        
        if (i==15) str = model.turnoversPG;
        
        if (i==16) str = model.foulsPG;
        
        if(str!=nil) [temp1 addObject:str];
    }
    return temp1;
}

-(void)initWithTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *playerid = [user objectForKey:@"id"];
    NSString *str = @"&cubeId=8&dimId=5&params=t1%3A";
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@%@&from=sportsdatabase",urlDataString,str,playerid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:stringUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *data = responseObject[@"data"];;
        NSDictionary *dataDict = data[@"playerBaseInfo"];
        self.playerModel = [playerModel initWithPlayerData:dataDict];
        
        NSString *str1 = @"&cubeId=10&dimId=9%2C10&params=t2%3A2016%7Ct3%3A1%7Ct1%3A";
        NSString *stringUrl1 = [NSString stringWithFormat:@"%@%@%@&from=sportsdatabase",urlDataString,str1,playerid];
        AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        manager1.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager1 POST:stringUrl1 parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary *data = responseObject[@"data"];;
            NSDictionary *dataDict = data[@"nbaPlayerSeasonStat"];
            self.dataModel = [playerData initWithPlayerData:dataDict];
            [self setTableHeadView:[playerTableHeadView initWithPlayerHeadView:self.playerModel :self.dataModel]];
            [self.tableView setTableHeaderView:self.tableHeadView];
            
            float y = self.tableHeadView.frame.size.height-30;
            leftTeamBT = [[UIButton alloc] initWithFrame:CGRectMake(0, y, screenWidth/2, 30)];
            [leftTeamBT setTitle:@"赛季数据" forState:UIControlStateNormal];
            leftTeamBT.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            [leftTeamBT addTarget:self action:@selector(leftTeamActin1:) forControlEvents:UIControlEventTouchUpInside];
            [leftTeamBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            leftTeamBT.backgroundColor = [UIColor whiteColor];
            
            [self.tableHeadView addSubview:leftTeamBT];
            
            float x = leftTeamBT.frame.size.width;
            rightTeamBT = [[UIButton alloc] initWithFrame:CGRectMake(x, y, screenWidth/2, 30)];
            [rightTeamBT setTitle:@"生涯数据" forState:UIControlStateNormal];
            rightTeamBT.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            [rightTeamBT addTarget:self action:@selector(rightTeamActin1:) forControlEvents:UIControlEventTouchUpInside];
            [rightTeamBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            rightTeamBT.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
            [self.tableHeadView addSubview:rightTeamBT];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}

-(void)initWithNavigationBar{
    self.bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    //    [self.bar setBackgroundColor:[UIColor blueColor]];
    //设置透明的背景图，便于识别底部线条有没有被隐藏
    [self.bar setBackgroundImage:[[UIImage alloc] init]
                  forBarPosition:UIBarPositionAny
                      barMetrics:UIBarMetricsDefault];
    //此处使底部线条失效
    [self.bar setShadowImage:[UIImage new]];
    
    //    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"hello"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 25, 25)];
    imageView.image = [UIImage imageNamed:@"返回"];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(25, 23, 60, 30)];
    [bt setTitle:@"数据王" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bt setBackgroundColor:[UIColor clearColor]];
    
    bt.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, screenWidth-80, 40)];
    [title setTextAlignment:NSTextAlignmentCenter];

    title.text = @"详情";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    [self.bar addSubview:title];
    [self.bar addSubview:imageView];
    [self.bar addSubview:bt];
    [self.view addSubview:self.bar];
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (status == 1) {
        return 2;
    }
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (status == 1) {
        return 1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"hello world";
    if (status==1) {
        if (self.curformDataArray.count!=0 && self.curformWidthArray.count!=0) {
            if (indexPath.section==0) {
                JYJTableCell *jyjCell = [JYJTableCell cellWithTableView:tableView];
                
                jyjCell.data = self.curformDataArray;
                jyjCell.widthArray = self.curformWidthArray;
                return jyjCell;
            }
        }
        if (self.nearGamesformDataArray.count!=0 && self.nearWidthformDataArray.count!=0) {
            if (indexPath.section==1) {
                JYJTableCell *jyjCell = [JYJTableCell cellWithTableView:tableView];
                
                jyjCell.data = self.nearGamesformDataArray;
                jyjCell.widthArray = self.nearWidthformDataArray;
                return jyjCell;
            }
        }
    }else{
        if (self.careerFormDataArray.count!=0) {
            JYJTableCell *jyjCell = [JYJTableCell cellWithTableView:tableView];
            
            jyjCell.data = self.careerFormDataArray[indexPath.section];
            jyjCell.widthArray = self.curformWidthArray;
            return jyjCell;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (status == 1) {
        return 20;
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    NSArray *temp = @[@"本赛季平均",@"最近5场"];
    headView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArray = @[@"季前赛平均",@"常规赛平均",@"季后赛平均"];
    
    if (status == 1) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 80, 15)];
        [lable setTextAlignment:NSTextAlignmentLeft];
        lable.text = temp[section];
        [lable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [lable setTextColor:[UIColor blackColor]];
        [headView addSubview:lable];
    }else{
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 80, 15)];
        [lable setTextAlignment:NSTextAlignmentLeft];
        lable.text = titleArray[section];
        [lable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [lable setTextColor:[UIColor blackColor]];
        [headView addSubview:lable];
    }
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (status == 1){
        if (self.curformDataArray.count!=0 && self.curformWidthArray.count!=0){
            if (indexPath.section==0) {
                NSArray *array = [self.curformDataArray firstObject];
                return itemCellH * array.count +20;
            }
        }
        if (self.nearGamesformDataArray.count!=0 && self.nearWidthformDataArray.count!=0){
            if (indexPath.section==1) {
                NSArray *array = [self.nearGamesformDataArray firstObject];
                return itemCellH * array.count +20;
            }
        }
    }else{
        if (self.careerFormDataArray.count!=0) {
            NSArray *array = [self.careerFormDataArray[indexPath.section] firstObject];
            return itemCellH * array.count +20;
        }
    }
    return 20;
}



-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [self setFrame:frame];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    UIColor * color = [UIColor blueColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.bar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.bar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark - 点击事件action

-(void)leftTeamActin1:(UIButton *)sender{
    status=1;
    [self.tableView reloadData];
    [leftTeamBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftTeamBT.backgroundColor = [UIColor whiteColor];
    [rightTeamBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightTeamBT.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
}

-(void)rightTeamActin1:(UIButton *)sender{
    status=2;
    [self.tableView reloadData];
    [rightTeamBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightTeamBT.backgroundColor = [UIColor whiteColor];
    [leftTeamBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    leftTeamBT.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
}

-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
