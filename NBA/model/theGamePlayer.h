//
//  theGamePlayer.h
//  NBA
//
//  Created by zdx on 2017/3/18.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface theGamePlayer : NSObject

@property (copy, nonatomic) NSString *playerId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *enName;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *position;
@property (copy, nonatomic) NSString *jerseyNum;
@property (strong, nonatomic) NSData *iconData;

+(instancetype)initWithGamePlayerData:(NSDictionary *)dict;

@end
