//
//  playerModel.h
//  NBA
//
//  Created by zdx on 2017/3/28.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playerModel : NSObject

@property (copy, nonatomic) NSString *birthDate;
@property (copy, nonatomic) NSString *cnName;
@property (copy, nonatomic) NSString *curSeasonId;
@property (copy, nonatomic) NSString *draftYear;
@property (copy, nonatomic) NSString *enName;
@property (copy, nonatomic) NSString *height;
@property (copy, nonatomic) NSString *honor;
@property (copy, nonatomic) NSString *jerseyNum;
@property (copy, nonatomic) NSString *picFromSIB;
@property (copy, nonatomic) NSString *position;
@property (copy, nonatomic) NSString *playerId;
@property (copy, nonatomic) NSString *weight;
@property (copy, nonatomic) NSString *wage;

+(instancetype)initWithPlayerData:(NSDictionary *)dict;

@end
