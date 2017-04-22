//
//  seasonDataModel.m
//  NBA
//
//  Created by zdx on 2017/4/10.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "seasonDataModel.h"

@implementation seasonDataModel

+(instancetype)initWithSeasonData:(NSDictionary *)dict{
    seasonDataModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
