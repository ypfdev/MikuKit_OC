//
//  UIImage+Thumbnail.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/7.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "UIImage+Thumbnail.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Thumbnail)

+ (UIImage *)mk_thumbnailFromAsset:(PHAsset *)asset {
    __block UIImage *thumbnail;
    // 图片请求参数
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 请求图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        thumbnail = result;
    }];
    return thumbnail;
}


+ (UIImage *)mk_thumbnailFromAsset:(PHAsset *)asset size:(CGSize)size {
    __block UIImage *thumbnail;
    // 图片请求参数
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 请求图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        thumbnail = result;
    }];
    return thumbnail;
}


+ (void)mk_thumbnailFromAsset:(PHAsset *)asset completionHandler:(void (^)(UIImage * _Nullable thumbnail))completionHandler {
    // 图片请求参数
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 请求图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        completionHandler(result);
    }];
}


+ (void)mk_thumbnailFromAsset:(PHAsset *)asset size:(CGSize)size completionHandler:(void (^)(UIImage * _Nullable thumbnail))completionHandler {
    // 图片请求参数
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 请求图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        completionHandler(result);
    }];
}


+ (nullable UIImage *)mk_firstFrameFromVideo:(NSURL *)url {
    NSDictionary *optionDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:optionDict];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(200, 200);
    
    NSError *error = nil;
    CGImageRef image = [generator copyCGImageAtTime:CMTimeMake(1, 24) actualTime:NULL error:&error];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:image];
    /** 注意
    这里要手动释放图片对象，否则会造成内存泄露！
     如果直接用下面简写的方法返回图片 ，当方法多次调用时（例如视频TB、视频CL等），会因内存泄露被kill
     return [[UIImage alloc] initWithCGImage:image];
    */
    CGImageRelease(image);
    
    return thumbnail;
}


+ (nullable UIImage *)mk_firstFrameFromVideo:(NSURL *)url size:(CGSize)size {
    NSDictionary *optionDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:optionDict];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = size;
    
    NSError *error = nil;
    CGImageRef image = [generator copyCGImageAtTime:CMTimeMake(1, 24) actualTime:NULL error:&error];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:image];
    /** 注意
    这里要手动释放图片对象，否则会造成内存泄露！
     如果直接用下面简写的方法返回图片 ，当方法多次调用时（例如视频TB、视频CL等），会因内存泄露被kill
     return [[UIImage alloc] initWithCGImage:image];
    */
    CGImageRelease(image);
    
    return thumbnail;
}


+ (nullable UIImage *)mk_thumbnailFromVideo:(NSURL *)url {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(200, 200);
    
    CGImageRef image = [generator copyCGImageAtTime:CMTimeMakeWithSeconds(1, 120) actualTime:nil error:nil];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:image];
    /** 注意
    这里要手动释放图片对象，否则会造成内存泄露！
     如果直接用下面简写的方法返回图片 ，当方法多次调用时（例如视频TB、视频CL等），会因内存泄露被kill
     return [[UIImage alloc] initWithCGImage:image];
    */
    CGImageRelease(image);
    
    return thumbnail;
}


+ (nullable UIImage *)mk_thumbnailFromVideo:(NSURL *)url size:(CGSize)size {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = size;
    
    CGImageRef image = [generator copyCGImageAtTime:CMTimeMakeWithSeconds(1, 120) actualTime:nil error:nil];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:image];
    /** 注意
    这里要手动释放图片对象，否则会造成内存泄露！
     如果直接用下面简写的方法返回图片 ，当方法多次调用时（例如视频TB、视频CL等），会因内存泄露被kill
     return [[UIImage alloc] initWithCGImage:image];
    */
    CGImageRelease(image);
    
    return thumbnail;
}

@end
