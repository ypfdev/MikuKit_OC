//
//  MKImagePicker.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/11/26.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKImagePicker : UIImagePickerController

- (instancetype)initWithDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
