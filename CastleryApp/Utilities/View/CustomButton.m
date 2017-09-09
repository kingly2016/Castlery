//
//  CustomButton.m
//  CastleryApp
//
//  Created by Apple on 17/8/29.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect imageRect = self.imageView.frame;
    //0 图左字右 1 图右字左 2图上字下
    switch (self.orientation) {
        case 0:{

            break;
        }
        case 1:{
            imageRect.size = CGSizeMake(30, 30);
            imageRect.origin.x = (self.frame.size.width - 30) ;
            imageRect.origin.y = (self.frame.size.height  - 30)/2.0f;
            CGRect titleRect = self.titleLabel.frame;
            titleRect.origin.x = (self.frame.size.width - imageRect.size.width- titleRect.size.width);
            titleRect.origin.y = (self.frame.size.height - titleRect.size.height)/2.0f;
            self.imageView.frame = imageRect;
            self.titleLabel.frame = titleRect;
            break;
        }
        case 2:{
            imageRect.size = CGSizeMake(30, 30);
            imageRect.origin.x = (self.frame.size.width - 30) * 0.5;
            imageRect.origin.y = self.frame.size.height * 0.5 - 40;
            CGRect titleRect = self.titleLabel.frame;

            titleRect.origin.x = (self.frame.size.width - titleRect.size.width) * 0.5;

            titleRect.origin.y = self.frame.size.height * 0.5 ;
            self.imageView.frame = imageRect;
            self.titleLabel.frame = titleRect;

            break;
        }
        default:
            break;
    }
}

@end
