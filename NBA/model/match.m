//
//  match.m
//  NBA
//
//  Created by zdx on 2017/3/15.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "match.h"

@implementation match

+(instancetype)initWithMatch:(NSDictionary *)dict{
    match *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
