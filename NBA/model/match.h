//
//  match.h
//  NBA
//
//  Created by zdx on 2017/3/15.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface match : NSObject

@property (copy, nonatomic) NSString *mid; //传给下一个比赛详情视图的参数
@property (copy, nonatomic) NSString *leftId; //左边球队id
@property (copy, nonatomic) NSString *leftName; //左边球队名称
@property (copy, nonatomic) NSString *leftBadge; //左边球队图片地址
@property (strong, nonatomic) NSData *leftBadgeData;
@property (copy, nonatomic) NSString *leftGoal; //左边球队比分
@property (copy, nonatomic) NSString *rightId; //右边球队id
@property (copy, nonatomic) NSString *rightName; //右边球队名称
@property (copy, nonatomic) NSString *rightBadge; //右边图片地址
@property (strong, nonatomic) NSData *rightBadgeData;
@property (copy, nonatomic) NSString *rightGoal; //右边球队比分
@property (copy, nonatomic) NSString *matchDesc; //title;
@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *matchPeriod; //比赛状态
@property (copy, nonatomic) NSString *quarter; //正在直播第几节
@property (copy, nonatomic) NSString *quarterTime; //离比赛结束还有多长时间
@property (copy, nonatomic) NSString *week;


+(instancetype)initWithMatch:(NSDictionary *)dict;

@end
