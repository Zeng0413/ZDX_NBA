//
//  ZDXTabBarViewController.m
//  NBA
//
//  Created by zdx on 2017/4/22.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "ZDXTabBarViewController.h"
#import "matchViewController.h"
#import "betterDataViewController.h"
#import "personViewController.h"
#import "comnous.h"
#import "navigationViewController.h"

@interface ZDXTabBarViewController ()

@end

@implementation ZDXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    matchViewController *vc1 = [[matchViewController alloc] init];
    [self addChildVc:vc1 title:@"比赛" image:@"ic_tabbar_01_nor" selectedImage:@"ic_tabbar_01_focus"];
    
    betterDataViewController *vc2 = [[betterDataViewController alloc] init];
    [self addChildVc:vc2 title:@"数据" image:@"ic_tabbar_04_nor" selectedImage:@"ic_tabbar_04_focus"];
    
    personViewController *vc3 = [[personViewController alloc] init];
    [self addChildVc:vc3 title:@"更多" image:@"ic_tabbar_05_nor" selectedImage:@"ic_tabbar_05_focus"];
    
    [self.tabBar setBarTintColor:ZDXColor(20, 70, 130)];
    
    //取消透明效果
    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = ZDXColor(241, 241, 241);
    NSMutableDictionary *selectedTextAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
    

    navigationViewController *nav = [[navigationViewController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}












@end
