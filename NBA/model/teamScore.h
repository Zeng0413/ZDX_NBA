//
//  teamScore.h
//  NBA
//
//  Created by zdx on 2017/3/23.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface teamScore : NSObject

@property (copy, nonatomic) NSString *leftScore;
@property (copy, nonatomic) NSString *rightScore;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *time;

@property (strong, nonatomic) NSData *leftData;
@property (strong, nonatomic) NSData *rightData;

@property (copy, nonatomic) NSString *leftImageAddress;
@property (copy, nonatomic) NSString *rightImageAddress;
@end
