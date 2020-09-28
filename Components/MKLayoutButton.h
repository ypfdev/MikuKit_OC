//
//  MKLayoutButton.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/6/28.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MCButtonLayoutImgTop,
    MCButtonLayoutImgLeft,
    MCButtonLayoutImgBottom,
    MCButtonLayoutImgRight,
} MCButtonLayout;

typedef NS_ENUM(NSInteger, ImageStyle){
    imageTop,    // The picture is under the title.
    imageLeft,   // The picture is in the left title on the right.
    imageBottom, // The title is under the picture.
    imageRight   // The title is in the left picture on the right.
};


@interface MKLayoutButton : UIButton

@property (nonatomic, assign, readwrite) ImageStyle buttonStyle;
@property (nonatomic, assign) CGFloat    imgScale; ///<- scaling of the picture

@end
