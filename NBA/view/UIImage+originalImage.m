//
//  UIImage+originalImage.m
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "UIImage+originalImage.h"

@implementation UIImage (originalImage)

+(UIImage *)originalImageName:(NSString *)imageName{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
}

@end
