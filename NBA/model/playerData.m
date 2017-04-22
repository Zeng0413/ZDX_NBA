//
//  playerData.m
//  NBA
//
//  Created by zdx on 2017/4/9.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "playerData.h"

@implementation playerData

+(instancetype)initWithPlayerData:(NSDictionary *)dict{
    playerData *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
