//
//  theGameTeamStatistics.h
//  NBA
//
//  Created by zdx on 2017/3/23.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface theGameTeamStatistics : NSObject

@property (copy, nonatomic) NSString *leftVal;

@property (copy, nonatomic) NSString *rightVal;

@property (copy, nonatomic) NSString *text;

@property (strong, nonatomic) NSData *leftData;

@property (strong, nonatomic) NSData *rightData;

+(instancetype)initWithData:(NSDictionary *)dict;
@end
