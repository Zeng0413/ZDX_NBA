//
//  nearGamesModel.h
//  NBA
//
//  Created by zdx on 2017/4/10.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nearGamesModel : NSObject

@property (copy, nonatomic) NSString *assists;
@property (copy, nonatomic) NSString *blocked;
@property (copy, nonatomic) NSString *defensiveRebounds;
@property (copy, nonatomic) NSString *offensiveRebounds;
@property (copy, nonatomic) NSString *fieldGoals;
@property (copy, nonatomic) NSString *fieldGoalsAttempted;
@property (copy, nonatomic) NSString *freeThrows;
@property (copy, nonatomic) NSString *freeThrowsAttempted;
@property (copy, nonatomic) NSString *minutes;
@property (copy, nonatomic) NSString *personalFouls;
@property (copy, nonatomic) NSString *points;
@property (copy, nonatomic) NSString *rebounds;
@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *steals;
@property (copy, nonatomic) NSString *threePointGoals;
@property (copy, nonatomic) NSString *threePointAttempted;
@property (copy, nonatomic) NSString *turnovers;
@property (copy, nonatomic) NSString *awayId;
@property (copy, nonatomic) NSString *awayName;
@property (copy, nonatomic) NSString *homeId;
@property (copy, nonatomic) NSString *homeName;

+(instancetype)initWithNearGames:(NSDictionary *)dict;

@end
