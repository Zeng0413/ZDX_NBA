//
//  maxPlayers.m
//  NBA
//
//  Created by zdx on 2017/3/18.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "maxPlayers.h"

@implementation maxPlayers

+(instancetype)initWithData:(NSDictionary *)dict{
    maxPlayers *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


//-(void)setLeftPlayer:(NSDictionary *)leftPlayer{
//    
//    
//    theGamePlayer *model = [[theGamePlayer alloc] init];
//    
//    [model setValuesForKeysWithDictionary:leftPlayer];
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(initWithTheGameData:)]) {
//        [self.delegate initWithTheGameData:model];
//
//    }
//    
//}

@end
