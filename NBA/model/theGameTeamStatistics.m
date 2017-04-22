//
//  theGameTeamStatistics.m
//  NBA
//
//  Created by zdx on 2017/3/23.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "theGameTeamStatistics.h"

@implementation theGameTeamStatistics


+(instancetype)initWithData:(NSDictionary *)dict{
    theGameTeamStatistics *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
