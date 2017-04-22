//
//  theGamePlayer.m
//  NBA
//
//  Created by zdx on 2017/3/18.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "theGamePlayer.h"

@implementation theGamePlayer

+(instancetype)initWithGamePlayerData:(NSDictionary *)dict{
    
    theGamePlayer *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
