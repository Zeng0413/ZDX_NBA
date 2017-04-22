//
//  nearGamesModel.m
//  NBA
//
//  Created by zdx on 2017/4/10.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "nearGamesModel.h"

@implementation nearGamesModel

+(instancetype)initWithNearGames:(NSDictionary *)dict{
    nearGamesModel *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
