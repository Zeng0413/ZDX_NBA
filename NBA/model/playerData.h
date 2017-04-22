//
//  playerData.h
//  NBA
//
//  Created by zdx on 2017/4/9.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playerData : NSObject
@property (copy, nonatomic) NSString *pointsPG;
@property (copy, nonatomic) NSString *reboundsPG;
@property (copy, nonatomic) NSString *assistsPG;
@property (copy, nonatomic) NSString *blocksPG;
@property (copy, nonatomic) NSString *stealsPG;
@property (copy, nonatomic) NSString *games;
@property (copy, nonatomic) NSString *gamesStarted;
@property (copy, nonatomic) NSString *fgPCT;
@property (copy, nonatomic) NSString *threesPCT;
@property (copy, nonatomic) NSString *turnoversPG;
@property (copy, nonatomic) NSString *foulsPG;

+(instancetype)initWithPlayerData:(NSDictionary *)dict;

@end
