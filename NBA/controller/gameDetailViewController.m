//
//  gameDetailViewController.m
//  NBA
//
//  Created by zdx on 2017/3/16.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "gameDetailViewController.h"
#import "matchViewController.h"
#import "match.h"
#import "comnous.h"
#import "AFNetworking.h"
#import "maxPlayers.h"
#import "theGameBetterCell.h"
#import "JYJTableCell.h"
#import "JYJConst.h"
#import "tableViewHeadView.h"
#import "UINavigationBar+Awesome.h"
#import "teamScore.h"
#import "theGameTeamStatistics.h"
#import "teamStatistics.h"
#import "SDAutoLayout.h"
#import "playerVC.h"

#define NAVBAR_CHANGE_POINT 50


@interface gameDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) match *model;
@property (strong, nonatomic) tableViewHeadView *tableHeadView;
@property (strong, nonatomic) NSArray *list1;

@property (strong, nonatomic) NSMutableArray *scoreArray;
@property (strong, nonatomic) NSMutableArray *widthArray;
@property (strong, nonatomic) UINavigationBar *bar;
@property (strong, nonatomic) UIView *leftLineView;
@property (strong, nonatomic) UIView *rightLineView;

@property (strong, nonatomic) teamStatistics *teamCell;
@property (strong, nonatomic) NSMutableArray *cellArray;
@property (strong, nonatomic) NSMutableArray *statisticsDataArray;
@property (strong, nonatomic) NSMutableArray *statisticsWidthArray;
@property (strong, nonatomic) NSMutableArray *array1;
@property (strong, nonatomic) NSMutableArray *array2;
@property (assign, nonatomic) BOOL isReload;
@property (assign, nonatomic) NSInteger status;
@end

@implementation gameDetailViewController
{
    UIButton *leftButton;
    UIButton *rightButton;
    UIView *leftLineView;
    UIView *rightLineView;
    UIButton *leftTeamBT;
    UIButton *rightTeamBT;

}

-(NSMutableArray *)array1{
    if (!_array1) {
        _array1 = [NSMutableArray array];
    }
    return _array1;
}

-(NSMutableArray *)array2{
    if (!_array2) {
        _array2 = [NSMutableArray array];
    }
    return _array2;
}
-(NSMutableArray *)statisticsDataArray{
    if (!_statisticsDataArray) {
        _statisticsDataArray = [NSMutableArray array];
    }
    return _statisticsDataArray;
}

-(NSMutableArray *)statisticsWidthArray{
    if (!_statisticsWidthArray) {
        _statisticsWidthArray = [NSMutableArray array];
    }
    return _statisticsWidthArray;
}

-(NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

-(NSMutableArray *)scoreArray{
    if (!_scoreArray) {
        _scoreArray = [NSMutableArray array];
    }
    return _scoreArray;
}


-(NSMutableArray *)widthArray{
    if (!_widthArray) {
        _widthArray = [NSMutableArray array];
    }
    return _widthArray;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self scrollViewDidScroll:self.tableView];
    [self.bar setShadowImage:[UIImage new]];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.tableView.delegate = nil;
//    [self.bar lt_reset];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = 1;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [user objectForKey:@"model"];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\":"];
    NSArray *strList = [str componentsSeparatedByCharactersInSet:set];
    NSString *str1 = strList[0];
    NSString *str2 = strList[1];
    [self initWithTable];
    
    [self initWithNavigationBar];
    
    [self initWithData:str1 :str2];

    [self.bar lt_setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
}



-(void)initWithTable{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[theGameBetterCell class] forCellReuseIdentifier:@"theGameBetterCell"];
    [self.tableView registerClass:[teamStatistics class] forCellReuseIdentifier:@"teamStatisticsCell"];
    [self.view addSubview:self.tableView];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *leftAddress = [user objectForKey:@"leftAddress"];
    NSString *rightAddress = [user objectForKey:@"rightAddress"];
    NSString *leftScore = [user objectForKey:@"leftScroe"];
    NSString *rightScore = [user objectForKey:@"rightScroe"];
    NSString *status = [user objectForKey:@"status"];
    NSString *title = [user objectForKey:@"matchDesc"];
    NSString *time = [user objectForKey:@"time"];
    NSString *date = [user objectForKey:@"date"];
    teamScore *model = [[teamScore alloc] init];
    model.leftImageAddress = leftAddress;
    model.rightImageAddress = rightAddress;
    model.leftScore = leftScore;
    model.rightScore = rightScore;
    model.status = status;
    model.title = title;
    model.time = [NSString stringWithFormat:@"%@  %@",date,time];
    [self setTableHeadView:[tableViewHeadView initWithHeadView:model]];
    [self.tableView setTableHeaderView:self.tableHeadView];
    [self initWithSubHeadView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}


//-(teamScore *)initWithTabData{
//    
//    
//}

-(void)initWithSubHeadView{
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tableHeadView.bounds)-35, screenWidth, 35)];
    subView.backgroundColor = [UIColor whiteColor];
    
    leftLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(subView.bounds)-3, screenWidth/2, 3)];
    [subView addSubview:leftLineView];
    
    rightLineView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth/2, CGRectGetHeight(subView.bounds)-3, screenWidth/2, 3)];
    [rightLineView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
    [subView addSubview:rightLineView];
    
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, screenWidth/2, 20)];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [leftLineView setBackgroundColor:[UIColor blueColor]];
    [leftButton setTitle:@"数据" forState:UIControlStateNormal];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2, 5, screenWidth/2, 20)];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.selected = YES;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightButton setTitle:@"统计" forState:UIControlStateNormal];
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [subView addSubview:rightButton];
    [subView addSubview:leftButton];
    
    [self.tableHeadView addSubview:subView];
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
    imageView.image = [UIImage imageNamed:@"navbar_ic_back"];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(18, 23, 60, 30)];
    [bt setTitle:@"比赛" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bt setBackgroundColor:[UIColor clearColor]];

    bt.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, screenWidth-80, 40)];
    [title setTextAlignment:NSTextAlignmentCenter];

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    NSString *leftName = [user objectForKey:@"leftName"];
    NSString *rightName = [user objectForKey:@"rightName"];
    title.text = [NSString stringWithFormat:@"%@ @ %@",leftName,rightName];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];

    [self.bar addSubview:title];
    [self.bar addSubview:imageView];
    [self.bar addSubview:bt];
    [self.view addSubview:self.bar];
}

-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"dsad");
}

-(void)initWithData:(NSString *)str1 :(NSString *)str2{
    NSString *str = [NSString stringWithFormat:@"%@%@%@",str1,@"%3A",str2];    
    NSString *stringUrl = [NSString stringWithFormat:@"%@mid=%@&_=1489483437608",urlMatchDetailsSting,str];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:stringUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        NSDictionary *teamInfoDict = dict[@"teamInfo"];
        
        NSString *leftStr = teamInfoDict[@"leftName"];
        NSString *rightStr = teamInfoDict[@"rightName"];
        
        
        NSDictionary *periodDic = dict[@"periodGoals"];
        NSArray *headList = periodDic[@"head"];
        NSArray *rows = periodDic[@"rows"];
        NSArray *leftTeamRow = rows[0];
        NSArray *rightTeamRow = rows[1];
        
        NSArray *list1 = @[@"球队",leftStr,rightStr];
        NSNumber *width = [NSNumber numberWithFloat:screenWidth/6];
        [self.scoreArray addObject:list1];
        [self.widthArray addObject:width];
        for (int i=0; i<=8; i++) {
            NSString *headStr = headList[i];
            NSString *leftStr = leftTeamRow[i+1];
            NSString *rightStr = rightTeamRow[i+1];
            NSArray *list = @[headStr, leftStr, rightStr];
            if (![leftStr isEqualToString:@"-"]) {
                [self.scoreArray addObject:list];
                [self.widthArray addObject:width];
            }
        }
        NSDictionary *playStatsDic = dict[@"playerStats"];
        NSArray *leftArray = playStatsDic[@"left"];
        NSMutableArray *scoreTemp = [NSMutableArray array];
        NSMutableArray *widthTemp = [NSMutableArray array];
        
        for (int j=0; j<=12; j++) {
            
            NSMutableArray *temp = [NSMutableArray array];
            for (int i=0; i<leftArray.count; i++) {
                NSDictionary *tempDict = leftArray[i];
                NSArray *tempArray;
                if (i==0) {
                    tempArray = tempDict[@"head"];
                }else{
                    tempArray = tempDict[@"row"];
                }
                
                NSString *str = tempArray[j];
                [temp addObject:str];
            }
            NSNumber *width;
            
            if (j==0) {
                width = [NSNumber numberWithFloat:120];
            }else{
                width = [NSNumber numberWithFloat:screenWidth/6];
                
            }
            [scoreTemp addObject:temp];
            [self.statisticsWidthArray addObject:width];
        }
        [self.array1 addObject:scoreTemp];
        
        NSArray *rightArray = playStatsDic[@"right"];
        scoreTemp = [NSMutableArray array];
        widthTemp = [NSMutableArray array];
        
        for (int j=0; j<=12; j++) {
            
            NSMutableArray *temp = [NSMutableArray array];
            for (int i=0; i<rightArray.count; i++) {
                NSDictionary *tempDict = rightArray[i];
                NSArray *tempArray;
                if (i==0) {
                    tempArray = tempDict[@"head"];
                }else{
                    tempArray = tempDict[@"row"];
                }
                
                NSString *str = tempArray[j];
                [temp addObject:str];
            }
            
            [scoreTemp addObject:temp];
        }
        [self.array1 addObject:scoreTemp];
       
        self.statisticsDataArray = self.array1[0];
        
        NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        [dict1 setValue:periodDic forKey:@"比分"];

        
        NSMutableArray *array = [NSMutableArray array];
        NSArray *maxPlayersList = dict[@"maxPlayers"];
        for (NSDictionary *dict in maxPlayersList) {
            maxPlayers *model = [maxPlayers initWithData:dict];
            [array addObject:model];
            
        }
        
        
        NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
        [dict2 setValue:array forKey:@"本场最佳"];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSData *leftData = [user objectForKey:@"leftData"];
        NSData *rightData = [user objectForKey:@"rightData"];
        
        NSMutableArray *teamStatsList = [NSMutableArray array];
        theGameTeamStatistics *model = [[theGameTeamStatistics alloc] init];
        model.leftData = leftData;
        model.rightData = rightData;
        model.text = @"vs";
        [teamStatsList addObject:model];
        NSArray *teamStats = dict[@"teamStats"];
        
        NSMutableDictionary *dict3 = [[NSMutableDictionary alloc] init];
        for (NSDictionary *dict in teamStats) {
            theGameTeamStatistics *model = [theGameTeamStatistics initWithData:dict];
            [teamStatsList addObject:model];
        }
        [dict3 setValue:teamStatsList forKey:@"球队统计"];
        
        self.list1 = @[dict1,dict2,dict3];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.status==1) {
        return self.list1.count;

    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.status == 1) {
        NSDictionary *dic = self.list1[section];
        
        NSArray *list = [dic allKeys];
        NSString *str = [list firstObject];
        
        if ([str isEqualToString:@"比分"]){
            return 1;
        }else if ([str isEqualToString:@"球队统计"]){
            NSArray *list1 = dic[str];
            
            
            
            return list1.count;
        }else{
            NSArray *list1 = dic[str];
            
            return list1.count;
        }
    }
    
    return 1;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.status==1) {
        NSDictionary *dic = self.list1[indexPath.section];
        
        NSArray *list = [dic allKeys];
        NSString *str = [list firstObject];
        if ([str isEqualToString:@"比分"]) {
            JYJTableCell *jyjCell = [JYJTableCell cellWithTableView:tableView];
            jyjCell.data = self.scoreArray;
            jyjCell.widthArray = self.widthArray;
            return jyjCell;
        }else if ([str isEqualToString:@"本场最佳"]){
            theGameBetterCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"theGameBetterCell"];
            NSArray *list1 = dic[str];
            
            maxPlayers *model = list1[indexPath.row];
            
            cell1.model = model;
            cell1.leftBT.tag = indexPath.row;
            cell1.rightBT.tag = indexPath.row;
            [cell1.leftBT addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
            [cell1.rightBT addTarget:self action:@selector(right1:) forControlEvents:UIControlEventTouchUpInside];
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell1;
            
        }else if ([str isEqualToString:@"球队统计"]){
            teamStatistics *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[teamStatistics alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"teamStatisticsCell"];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            NSArray *list1 = dic[str];
            
            NSLog(@"%zd",indexPath.row);
            theGameTeamStatistics *model = list1[indexPath.row];
            if (model.leftData!=nil) {
                cell.leftImageView.image = [UIImage imageWithData:model.leftData];
                cell.rightImageView.image = [UIImage imageWithData:model.rightData];
            }else{
                
                cell.leftImageView.image = nil;
                cell.rightImageView.image = nil;
                
                
                NSInteger normallenght = 200;
                if (model.leftVal!=nil || model.rightVal!=nil) {
                    float leftNum = [model.leftVal floatValue];
                    float rightNum = [model.rightVal floatValue];
                    float aa = leftNum/(rightNum+leftNum);
                    float bb = rightNum/(leftNum+rightNum);
                    self.leftLineView = [[UIView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-normallenght*aa-3, 30, normallenght*aa-3, 2)];
                    self.rightLineView = [[UIView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-3, 30, normallenght*bb, 2)];
                    if (leftNum>rightNum) {
                        
                        [self.leftLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
                        [self.rightLineView setBackgroundColor:[UIColor grayColor]];
                        
                    }else if(leftNum<rightNum){
                        [self.rightLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
                        [self.leftLineView setBackgroundColor:[UIColor grayColor]];
                        
                    }else{
                        [self.rightLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
                        [self.leftLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
                    }
                    [cell.contentView addSubview:self.leftLineView];
                    
                    [cell.contentView addSubview:self.rightLineView];
                }
                
            }
            cell.model = model;
            return cell;
            
        }
    }else{
        JYJTableCell *jyjCell = [JYJTableCell cellWithTableView:tableView];
        
        jyjCell.data = self.statisticsDataArray;
        jyjCell.widthArray = self.statisticsWidthArray;
        return jyjCell;
    }
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"selected");
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.status == 1) {
        return 35;
    }
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    if (self.status == 1) {
        NSDictionary *dic = self.list1[section];
        NSArray *list = [dic allKeys];
        NSString *str = [list firstObject];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
        [lable setTextAlignment:NSTextAlignmentCenter];
        lable.text = str;
        [lable setFont:[UIFont systemFontOfSize:12]];
        [lable setTextColor:[UIColor darkGrayColor]];
        [headView addSubview:lable];
    }else{
        float width = screenWidth/4+10;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSString *leftName = [user objectForKey:@"leftName"];
        NSString *rightName = [user objectForKey:@"rightName"];
        leftTeamBT = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/4-10, 15, width, 30)];
        [leftTeamBT setTitle:leftName forState:UIControlStateNormal];
//        [leftTeamBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        leftTeamBT.backgroundColor = [UIColor whiteColor];
        leftTeamBT.titleLabel.font = [UIFont systemFontOfSize:13];
        [leftTeamBT addTarget:self action:@selector(leftTeamActin:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:leftTeamBT];
        
        float x = leftTeamBT.frame.origin.x+leftTeamBT.frame.size.width;
        rightTeamBT = [[UIButton alloc] initWithFrame:CGRectMake(x, 15, width, 30)];
        [rightTeamBT setTitle:rightName forState:UIControlStateNormal];
//        [rightTeamBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        rightTeamBT.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];;
        rightTeamBT.titleLabel.font = [UIFont systemFontOfSize:13];
        [rightTeamBT addTarget:self action:@selector(rightTeamActin:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:rightTeamBT];
        if (self.isReload) {
            [rightTeamBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            rightTeamBT.backgroundColor = [UIColor whiteColor];
            
            [leftTeamBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            leftTeamBT.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        }else{
            
            [leftTeamBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            leftTeamBT.backgroundColor = [UIColor whiteColor];
            [rightTeamBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            rightTeamBT.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        }
    }
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.status == 1) {
        NSDictionary *dic = self.list1[indexPath.section];
        
        NSArray *list = [dic allKeys];
        NSString *str = [list firstObject];
        
        if ([str isEqualToString:@"本场最佳"]) {
            NSArray *list1 = dic[str];
            
            maxPlayers *model = list1[indexPath.row];
            
            return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[theGameBetterCell class] contentViewWidth:[self cellContentViewWith]];
        }
        if ([str isEqualToString:@"比分"]) {
            NSArray *array = [self.scoreArray firstObject];
            return itemCellH * array.count +20;
        }
        if ([str isEqualToString:@"球队统计"]) {
            NSArray *list = dic[str];
            
            teamStatistics *model = list[indexPath.row];
            return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[teamStatistics class] contentViewWidth:[self cellContentViewWith]];
        }
    }else{
        NSArray *array = [self.statisticsDataArray firstObject];
        return itemCellH * array.count+20;
    }
    return 20;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 10; //sectionHeaderHeight
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            
        }
    }
    
    UIColor * color = [UIColor blueColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.bar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.bar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark - action事件

-(void)leftTeamActin:(UIButton *)sender{
    self.isReload = NO;
    self.statisticsDataArray = self.array1[0];
    [self.tableView reloadData];
   
}

-(void)rightTeamActin:(UIButton *)sender{
    self.isReload = YES;
    self.statisticsDataArray = self.array1[1];
    [self.tableView reloadData];
}

-(void)leftAction:(UIButton *)sender{
    self.status = 1;
    [self.tableView reloadData];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [leftLineView setBackgroundColor:[UIColor blueColor]];
    
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightLineView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
}

-(void)rightAction:(UIButton *)sender{
    self.status = 2;
    [self.tableView reloadData];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [rightLineView setBackgroundColor:[UIColor blueColor]];
    
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftLineView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
}


-(void)left:(UIButton *)sender{
    NSDictionary *dic = self.list1[1];
    NSArray *list1 = dic[@"本场最佳"];
    
    maxPlayers *model = list1[sender.tag];
    [self initAction:model.leftPlayer];
}

-(void)right1:(UIButton *)sender{
    NSDictionary *dic = self.list1[1];
    NSArray *list1 = dic[@"本场最佳"];
    maxPlayers *model = list1[sender.tag];
    [self initAction:model.rightPlayer];
}

-(void)initAction:(NSDictionary *)player{
    NSDictionary *dict = player;
    NSString *playerId = dict[@"playerId"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:playerId forKey:@"id"];
    playerVC *vc = [[playerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [self setFrame:frame];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//        if (self.count<10) {
//            teamStatistics *cell = [tableView dequeueReusableCellWithIdentifier:@"teamStatisticsCell"];
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//            NSArray *list1 = dic[str];
//
//            NSLog(@"%zd",indexPath.row);
//            theGameTeamStatistics *model = list1[indexPath.row];
//            if ([model.text isEqualToString:@"vs"] && indexPath.row==0) {
//                cell.leftImageView.image = [UIImage imageWithData:model.leftData];
//                cell.rightImageView.image = [UIImage imageWithData:model.rightData];
//                cell.model = model;
//            }else{
//
//                cell.leftImageView.image = nil;
//                cell.rightImageView.image = nil;
//
//
//                NSInteger normallenght = 200;
//                float leftNum = [model.leftVal floatValue];
//                float rightNum = [model.rightVal floatValue];
//                float aa = leftNum/(rightNum+leftNum);
//                float bb = rightNum/(leftNum+rightNum);
//                self.leftLineView = [[UIView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-normallenght*aa-3, 30, normallenght*aa-3, 2)];
//                self.rightLineView = [[UIView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-3, 30, normallenght*bb, 2)];
//                if (leftNum>rightNum) {
//
//                    [self.leftLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
//                    [self.rightLineView setBackgroundColor:[UIColor grayColor]];
//
//                }else if(leftNum<rightNum){
//                    [self.rightLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
//                    [self.leftLineView setBackgroundColor:[UIColor grayColor]];
//
//                }else{
//                    [self.rightLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
//                    [self.leftLineView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:206/255.0 blue:27/255.0 alpha:1]];
//                }
//                [cell.contentView addSubview:self.leftLineView];
//
//                [cell.contentView addSubview:self.rightLineView];
//
//
//                cell.model = model;
//
//            }self.teamCell = cell;
//            if (indexPath.row == self.count) {
//                [self.cellArray addObject:self.teamCell];
//                self.count = indexPath.row+1;
//
//            }
//
//
//            return cell;
//        }else{
//            return self.cellArray[indexPath.row];
//        }
//
@end
