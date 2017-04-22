//
//  playerModel.m
//  NBA
//
//  Created by zdx on 2017/3/28.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "playerModel.h"

@implementation playerModel

+(instancetype)initWithPlayerData:(NSDictionary *)dict{
    playerModel *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
