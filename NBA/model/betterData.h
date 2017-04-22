//
//  betterData.h
//  NBA
//
//  Created by zdx on 2017/3/28.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface betterData : NSObject
@property (copy, nonatomic) NSString *cnName;
@property (copy, nonatomic) NSString *enName;
@property (copy, nonatomic) NSString *jerseyNum;
@property (copy, nonatomic) NSString *pic;
@property (copy, nonatomic) NSString *playerId;
@property (copy, nonatomic) NSString *seasonId;
@property (copy, nonatomic) NSString *teamId;
@property (copy, nonatomic) NSString *teamName;
@property (copy, nonatomic) NSString *PG;
@property (strong, nonatomic) NSData *picData;

+(instancetype)initWithBetterData:(NSDictionary *)dict;
@end
