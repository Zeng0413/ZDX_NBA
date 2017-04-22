//
//  maxPlayers.h
//  NBA
//
//  Created by zdx on 2017/3/18.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "theGamePlayer.h"


@protocol playerDelegate <NSObject>

-(void)initWithTheGameData:(theGamePlayer *)model;

@end

@interface maxPlayers : NSObject

@property (weak, nonatomic) id<playerDelegate>delegate;

@property (copy, nonatomic) NSString *leftVal;
@property (copy, nonatomic) NSString *rightVal;
@property (strong, nonatomic) NSDictionary *leftPlayer;
@property (strong, nonatomic) NSDictionary *rightPlayer;
@property (copy, nonatomic) NSString *text;
+(instancetype)initWithData:(NSDictionary *)dict;

@end
