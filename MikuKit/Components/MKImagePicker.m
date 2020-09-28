//
//  MKImagePicker.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/11/26.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MKImagePicker.h"

@interface MKImagePicker ()

@end

@implementation MKImagePicker

- (instancetype)initWithDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //暂时注释
//        self.mediaTypes = [NSArray arrayWithObjects:kUTTypeImage, kUTTypeMovie, nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end
