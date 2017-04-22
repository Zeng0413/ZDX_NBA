//
//  betterDataViewController.m
//  NBA
//
//  Created by zdx on 2017/3/26.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "betterDataViewController.h"
#import "dataVCheadView.h"
#import "comnous.h"
#import "betterData.h"
#import "AFNetworking.h"
#import "betterDataCell.h"
#import "playerVC.h"

@interface betterDataViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) dataVCheadView *dataHeadView;
@property (strong, nonatomic) UIView *leftLineView;
@property (strong, nonatomic) UIView *rightLineView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *betterDataArray;

@property (strong, nonatomic) NSMutableArray *appointArray;

@property (assign, nonatomic) NSInteger currentIndex;

@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) NSArray *titleArray;
@end


@implementation betterDataViewController
{
    UIButton *leftButton;
    UIButton *rightButton;
    UIView *leftLineView;
    UIView *rightLineView;
}

-(NSMutableArray *)appointArray{
    if (!_appointArray) {
        _appointArray = [NSMutableArray array];
    }
    return _appointArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"得分",@"篮板",@"助攻",@"盖帽",@"抢断"];

    self.currentIndex = 0;
    self.currentPage = 0;
    self.title = @"数据王";
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self initWithHeadView];
//    [self initWithScrollView];
    [self initWithTableView];
    [self initWithBetterPlayerData];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Swipe:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Swipe:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.tableView addGestureRecognizer:leftSwipe];

}

-(void)Swipe:(UISwipeGestureRecognizer *)sender{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        self.currentIndex--;
        if (self.currentIndex<0) {
            self.currentIndex = 4;
        }
        [self initSwipeData];
        
    }else{
        self.currentIndex++;
        if (self.currentIndex>4) {
            self.currentIndex = 0;
        }
        [self initSwipeData];
        
    }
    self.titleView = nil;
    [self.titleView removeFromSuperview];
    [self initWithTitleView:self.titleArray[self.currentIndex]];

}
-(void)leftAction{
    self.currentIndex--;
    if (self.currentIndex<0) {
        self.currentIndex = 4;
    }
    [self initSwipeData];

    self.titleView = nil;
    [self.titleView removeFromSuperview];
    [self initWithTitleView:self.titleArray[self.currentIndex]];
    [self.tableView reloadData];

    
}
-(void)rigthAction{
    self.currentIndex++;
    if (self.currentIndex>4) {
        self.currentIndex = 0;
    }
    [self initSwipeData];

    self.titleView = nil;
    [self.titleView removeFromSuperview];
    [self initWithTitleView:self.titleArray[self.currentIndex]];
}
-(void)initSwipeData{
    NSString *str;
    if (self.currentIndex==4) {
        str = @"stealsPG";
    }else if (self.currentIndex==3){
        str = @"blocksPG";
    }else if (self.currentIndex==2){
        str = @"assistsPG";
    }else if (self.currentIndex==1){
        str = @"reboundsPG";
    }else{
        str = @"pointsPG";
    }
    [self.appointArray removeAllObjects];
    NSArray *pointArray1 = self.betterDataArray[self.currentIndex];
    for (NSDictionary *dict in pointArray1) {
        betterData *model = [betterData initWithBetterData:dict];
        model.PG = dict[str];
        [self.appointArray addObject:model];
    }
    [self.tableView reloadData];
}

-(void)initWithBetterPlayerData{
    NSString *stringUrl = [NSString stringWithFormat:@"%@cubeId=10&dimId=53,54,55,56,57,58&from=sportsdatabase&limit=5&params=t2:2016|t3:1",urlDataString];
    stringUrl = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:stringUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDict = responseObject[@"data"];
        NSLog(@"%@",dataDict);
        NSArray *pointArray = dataDict[@"nbaPlayerSeasonPointsRank"];
        NSArray *assistsArray = dataDict[@"nbaPlayerSeasonAssistsRank"];
        NSArray *blockArray = dataDict[@"nbaPlayerSeasonBlocksRank"];
        NSArray *reboundArray = dataDict[@"nbaPlayerSeasonReboundsRank"];
        NSArray *stealArray = dataDict[@"nbaPlayerSeasonStealsRank"];
        _betterDataArray = @[pointArray,reboundArray,assistsArray,blockArray,stealArray];
        NSArray *pointArray1 = self.betterDataArray[0];
        for (NSDictionary *dict in pointArray1) {
            betterData *model = [betterData initWithBetterData:dict];
            if (dict[@"pointsPG"]) {
                model.PG = dict[@"pointsPG"];
            }
            
            [self.appointArray addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}

-(void)initWithTableView{
    CGFloat height = self.view.frame.size.height-73-64-self.tabBarController.tabBar.frame.size.height;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 137, self.view.frame.size.width, height) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
//    self.tableView.scrollEnabled = YES;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.edgesForExtendedLayout = UIRectEdgeBottom;
}


-(void)initWithHeadView{
    [self setDataHeadView:[dataVCheadView initWithView]];
    
    [self.view addSubview:self.dataHeadView];
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    subView.backgroundColor = [UIColor whiteColor];
    
    leftLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(subView.bounds)-3, screenWidth/2, 3)];
    [subView addSubview:leftLineView];
    
    rightLineView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth/2, CGRectGetHeight(subView.bounds)-3, screenWidth/2, 3)];
    [rightLineView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
    [subView addSubview:rightLineView];
    
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, screenWidth/2, 20)];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [leftLineView setBackgroundColor:[UIColor blueColor]];
    [leftButton setTitle:@"常规赛" forState:UIControlStateNormal];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2, 8, screenWidth/2, 20)];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.selected = YES;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton setTitle:@"每日" forState:UIControlStateNormal];
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [subView addSubview:rightButton];
    [subView addSubview:leftButton];
    
    [self initWithTitleView:@"得分"];
    
    [self.dataHeadView addSubview:subView];
}



-(void)initWithTitleView:(NSString *)str{
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, [UIScreen mainScreen].bounds.size.width, 30)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, [UIScreen mainScreen].bounds.size.width-80, 10)];
    lable.textColor = [UIColor darkGrayColor];
    lable.font = [UIFont systemFontOfSize:12];
    [lable setTextAlignment:NSTextAlignmentCenter];
    lable.text = str;
    [self.titleView addSubview:lable];
    
    UIButton *leftBT = [[UIButton alloc] initWithFrame:CGRectMake(3, 10, 30, 10)];
    [leftBT addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    leftBT.titleLabel.font = [UIFont systemFontOfSize:8];
    [leftBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBT setTitle:@"<" forState:UIControlStateNormal];
    [self.titleView addSubview:leftBT];
    
    UIButton *rigthBT = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-25, 10, 30, 10)];
    [rigthBT addTarget:self action:@selector(rigthAction) forControlEvents:UIControlEventTouchUpInside];
    rigthBT.titleLabel.font = [UIFont systemFontOfSize:8];
    [rigthBT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rigthBT setTitle:@">" forState:UIControlStateNormal];
    [self.titleView addSubview:rigthBT];
    [self.dataHeadView addSubview:self.titleView];
}
-(void)initWithScrollView{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = self.view.frame.size.height-73-64-self.tabBarController.tabBar.frame.size.height;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 73+64, width, height)];
    [self.scrollView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.scrollView];

    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(width * 5, 1000)];
//    _scrollView.contentOffset = CGPointMake(0, 0);
    //_scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)leftAction:(UIButton *)sender{
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [leftLineView setBackgroundColor:[UIColor blueColor]];
    
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightLineView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
}

-(void)rightAction:(UIButton *)sender{
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [rightLineView setBackgroundColor:[UIColor blueColor]];
    
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [leftLineView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
}


#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.appointArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    betterDataCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[betterDataCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    betterData *model = self.appointArray[indexPath.section];
    
    NSURL *url = [NSURL URLWithString:model.pic];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (model.picData) {
        
    }else{
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (connectionError) {
                    NSLog(@"%@",connectionError);
                    return;
                }
                UIImage *image = [UIImage imageWithData:data];
                cell.playerImage.image = image;
                
            model.picData = data;
            }];
    }
    cell.lableRank.text = [NSString stringWithFormat:@"第%zd",indexPath.section+1];
    cell.model = model;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    betterData *model = self.appointArray[indexPath.section];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:model.playerId forKey:@"id"];
    [user setObject:model.picData forKey:@"picData"];
    [user setObject:model.teamId forKey:@"teamId"];
    [self.navigationController setNavigationBarHidden:YES];
    
    playerVC *vc = [[playerVC alloc] init];
    vc.title = @"详情";
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.appointArray.count!=0) {
        betterData *model = self.appointArray[indexPath.section];
        
        
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[betterDataCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return 0;
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    int offsetX = (int)self.scrollView.contentOffset.x;
//    int widht = (int)CGRectGetWidth(self.scrollView.bounds);
//            NSLog(@"%f",self.scrollView.contentOffset.y);
//
//    if (offsetX % widht == 0) {
//        self.currentPage++;
//        if (self.currentPage>=5) {
//            self.currentPage = 0;
//        }
////        CGPointMake(self.currentPage * CGRectGetWidth(self.scrollView.frame)
////        [self.scrollView setContentOffset:CGPointMake(self.currentPage * CGRectGetWidth(self.scrollView.frame), 0) animated:YES];
////        NSLog(@"%f",self.scrollView.contentOffset.x);
//        [self.tableView removeFromSuperview];
//        self.tableView = nil;
//        [self initWithTableView];
//    }
}


@end
