//
//  betterData.m
//  NBA
//
//  Created by zdx on 2017/3/28.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "betterData.h"

@implementation betterData

+(instancetype)initWithBetterData:(NSDictionary *)dict{
    betterData *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
