//
//  seasonDataModel.h
//  NBA
//
//  Created by zdx on 2017/4/10.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface seasonDataModel : NSObject

@property (copy, nonatomic) NSString *seasonId;
@property (copy, nonatomic) NSString *seasonType;
@property (copy, nonatomic) NSString *seasonName;
@property (copy, nonatomic) NSString *games;
@property (copy, nonatomic) NSString *gamesStarted;
@property (copy, nonatomic) NSString *minutesPG;
@property (copy, nonatomic) NSString *pointsPG;
@property (copy, nonatomic) NSString *reboundsPG;
@property (copy, nonatomic) NSString *assistsPG;
@property (copy, nonatomic) NSString *stealsPG;
@property (copy, nonatomic) NSString *blocksPG;
@property (copy, nonatomic) NSString *fgPCT; //投篮命中率
@property (copy, nonatomic) NSString *threesPCT; //三分命中率
@property (copy, nonatomic) NSString *ftPCT; //罚球命中率
@property (copy, nonatomic) NSString *offensiveReboundsPG; //前板
@property (copy, nonatomic) NSString *defensiveReboundsPG; //后板
@property (copy, nonatomic) NSString *turnoversPG;
@property (copy, nonatomic) NSString *foulsPG;

+(instancetype)initWithSeasonData:(NSDictionary *)dict;


@end
