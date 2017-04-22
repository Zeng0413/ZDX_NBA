//
//  matchViewController.m
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "matchViewController.h"
#import "divCell.h"
#import "comnous.h"
#import "headView.h"
#import "AFNetworking.h"
#import "gameDetailViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UIImageView+WebCache.h"

#define NAVBAR_CHANGE_POINT 50


@interface matchViewController ()<UITableViewDataSource, UITableViewDelegate, actionDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) headView *headView;
@property (strong, nonatomic) NSMutableArray *matchList;
@property (strong, nonatomic) NSDate *currentDate;



@end

@implementation matchViewController

-(NSMutableArray *)matchList{
    if (!_matchList) {
        _matchList = [NSMutableArray array];
    }
    return _matchList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"比赛"];
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:nil image:@"NavBar_logo_NBA" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:nil image:@"NavBar_ic_mine" highImage:nil];
    
    self.currentDate = [NSDate date];
    
    [self initWithTableView];
    
    [self jiexishuju:[self getTime:self.currentDate]];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Swipe:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Swipe:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.tableView addGestureRecognizer:leftSwipe];
    

}

-(void)Swipe:(UISwipeGestureRecognizer *)sender{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.currentDate];
        self.currentDate = lastDay;
        NSString *time = [self getTime:self.currentDate];
        [self jiexishuju:time];
        [self.matchList removeAllObjects];
        [self.headView removeFromSuperview];
        self.headView = nil;
        [self.tableView reloadData];
    }else{
        NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:self.currentDate];
        self.currentDate = nextDay;
        NSString *time = [self getTime:self.currentDate];
        [self jiexishuju:time];
        [self.matchList removeAllObjects];
        [self.headView removeFromSuperview];
        self.headView = nil;
        [self.tableView reloadData];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

-(NSString *)getTime:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}





-(void)jiexishuju:(NSString *)time{
    NSString *stringUrl = [NSString stringWithFormat:@"%@from=NBA_PC&columnId=100000&startTime=%@&endTime=%@&_=1489482069675",urlMatchString,time,time];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:stringUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        NSArray *list = data[@"%@",time];
        for (NSDictionary *dict in list) {
            match *model = [match initWithMatch:dict];
            
            [self.matchList addObject:model];
        }
        
        
        
        match *model = [[match alloc] init];
        if (self.matchList.count!=0) {
            model = self.matchList[0];
        }else{
            model = nil;
        }
        
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
        [self setHeadView:[headView initWithHeadView:self.matchList.count :model :rect]];
        self.headView.delegate = self;
        
        [self.view addSubview:self.headView];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)initWithTableView{
    CGFloat tableViewY = 30;
    CGFloat tableViewH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - tableViewY-15-self.navigationController.navigationBar.frame.size.height;
    CGRect tableFrame = CGRectMake(0, tableViewY, CGRectGetWidth([UIScreen mainScreen].bounds), tableViewH);
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[divCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.matchList.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    divCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[divCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (self.matchList.count!=0) {
        match *model = self.matchList[indexPath.section];
        
        NSURL *url = [NSURL URLWithString:model.leftBadge];
        [cell.imagePlayer1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_list_pic_video"]];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        if (model.leftBadgeData) {
//
//        }else{
//            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                if (connectionError) {
//                    NSLog(@"%@",connectionError);
//                    return;
//                }
//                UIImage *image = [UIImage imageWithData:data];
//                cell.imagePlayer1.image = image;
//                
//                model.leftBadgeData = data;
//
//            }];
//        }
        url = [NSURL URLWithString:model.rightBadge];
        [cell.imagePlayer2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_list_pic_video"]];

        
        cell.model = model;
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    match *model = self.matchList[indexPath.section];
    NSString *mid = model.mid;
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    [user setObject:mid forKey:@"model"];
   
    [user setObject:model.leftName forKey:@"leftName"];
    [user setObject:model.rightName forKey:@"rightName"];

    NSString *leftAddress = model.leftBadge;
    [user setObject:leftAddress forKey:@"leftAddress"];
    
    NSString *leftScroe = model.leftGoal;
    [user setObject:leftScroe forKey:@"leftScroe"];

    NSString *rightAddress = model.rightBadge;
    [user setObject:rightAddress forKey:@"rightAddress"];
    NSString *rightScroe = model.rightGoal;
    [user setObject:rightScroe forKey:@"rightScroe"];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
    NSArray *strList = [model.startTime componentsSeparatedByCharactersInSet:set];
    NSString *str = strList[1];
    set = [NSCharacterSet characterSetWithCharactersInString:@"\":"];
    NSArray *strList1 = [str componentsSeparatedByCharactersInSet:set];
    NSString *time = [NSString stringWithFormat:@"%@:%@",strList1[0],strList1[1]];
    [user setObject:time forKey:@"time"];
    
    
    str = strList[0];
    set = [NSCharacterSet characterSetWithCharactersInString:@"\"-"];
    strList = [str componentsSeparatedByCharactersInSet:set];
    NSString *str1 = strList[1];
    NSString *str2 = strList[2];
    NSString *date = [NSString stringWithFormat:@"%@月%@日",str1,str2];
    [user setObject:date forKey:@"date"];
    
    NSString *matchDesc = model.matchDesc;
    matchDesc = [matchDesc substringFromIndex:3];
    [user setObject:matchDesc forKey:@"matchDesc"];
    
    if ([model.matchPeriod isEqualToString:@"2"]) {
        [user setObject:@"已结束" forKey:@"status"];
    }else if([model.matchPeriod isEqualToString:@"0"]){
        [user setObject:@"未开始" forKey:@"status"];

    }else{
        [user setObject:@"直播中" forKey:@"status"];
    }
    


    [self.navigationController setNavigationBarHidden:YES];

    gameDetailViewController *vc = [[gameDetailViewController alloc] init];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
    
    if (self.matchList.count!=0) {
        match *model = self.matchList[indexPath.section];
        
        
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[divCell class] contentViewWidth:[self cellContentViewWith]];
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
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 10; //sectionHeaderHeight
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            
        }
    }
    
}

#pragma mark - actionDelegate
-(void)actionDE:(NSUInteger)index{

    if (index == 1) {
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.currentDate];
        self.currentDate = lastDay;
        NSString *time = [self getTime:self.currentDate];
        [self jiexishuju:time];
        [self.matchList removeAllObjects];
        [self.headView removeFromSuperview];
        self.headView = nil;
        [self.tableView reloadData];
    }else{
        NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:self.currentDate];
        self.currentDate = nextDay;
        NSString *time = [self getTime:self.currentDate];
        [self jiexishuju:time];
        [self.matchList removeAllObjects];
        [self.headView removeFromSuperview];
        self.headView = nil;
        [self.tableView reloadData];
    }
    
}

//            NSString *imagePath1 = dict1[@"player1logobig"];
//            NSString *imagePath2 = dict1[@"player2logobig"];
//
//            NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:imagePath1]];
//            NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:imagePath2]];
//
//            NSURLSessionDownloadTask *tesk = [manager downloadTaskWithRequest:request1 progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//
//                NSData *data = [NSData dataWithContentsOfURL:targetPath];
//                model.player1LogoImageData = data;
//                [self.liveList removeAllObjects];
//                [self.liveList addObject:model];
//                [self.tableView reloadData];
//
//                return nil;
//            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//                NSLog(@"request1_error=%@",error);
//
//            }];
//            [tesk resume];
//
//
//           NSURLSessionDownloadTask *tesk1 = [manager downloadTaskWithRequest:request2 progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//                NSData *data = [NSData dataWithContentsOfURL:targetPath];
//                model.player2LogoImageData = data;
//               [self.liveList removeAllObjects];
//               [self.liveList addObject:model];
//               [self.tableView reloadData];
//                return nil;
//
//            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//
//                NSLog(@"request2_error=%@",error);
//
//            }];
//            [tesk1 resume];



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destin = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"toGameDetail"]) {
        
    }
    
    
}


@end
