//
//  MKPhotoManager.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2018/5/17.
//  Copyright © 2018 中软国际. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MCCoverSize) {
    MCCoverSizeOriginal     = 0,    // 原画
    MCCoverSizeAlbumCL      = 1,    // 相册页面CLCell
    MCCoverSizeAlbumBrowser = 2,    // 相册大图预览器
};

@interface MKPhotoManager : NSObject

#pragma mark - Initializer

// MARK: 单例写法1

+ (instancetype)sharedManager;

// 禁止外部调用
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;          // 没有遵循协议可以不写
- (id)mutableCopy NS_UNAVAILABLE;   // 没有遵循协议可以不写


#pragma mark - 相册权限

/// 相册授权信息
+ (PHAuthorizationStatus)authorizationStatus;

/// 验证相册权限
/// @param authorizedHandler 已授权回调
+ (void)validateAuthorizationStatus:(void (^)(void))authorizedHandler;


#pragma mark - 自定义相簿

/// 检查是否存在指定标题的自定义相簿
/// @param localizedTitle 相簿标题
+ (BOOL)assetCollectionExistsWithLocalizedTitle:(NSString *)localizedTitle;

/// 获取指定标题的自定义相簿（如果相簿不存在，就创建一个）
/// @param localizedTitle 相簿标题
+ (PHAssetCollection *)assetCollectionWithLocalizedTitle:(NSString *)localizedTitle;

/// 获取与App同名（DisplayName）的自定义相簿（如果不存在，就新建一个）
+ (PHAssetCollection *)appAssetCollection;


#pragma mark - 相册元数据

/// 获取指定相簿的所有元数据
/// @param assetCollection 指定相簿
+ (PHFetchResult<PHAsset *> *)assetsInAssetCollection:(PHAssetCollection *)assetCollection;

/// 获取指定元数据的图片
/// @param asset 指定元数据（asset.mediaType == PHAssetMediaTypeImage）
/// @param completionHandler 完成回调
+ (void)imageFromAsset:(PHAsset *)asset completionHandler:(void (^)(UIImage * _Nullable image))completionHandler;

/// 获取指定元数据的视频元
/// @param asset 指定元数据（asset.mediaType == PHAssetMediaTypeVideo）
/// @param completionHandler 完成回调
+ (void)avAssetFromAsset:(PHAsset *)asset completionHandler:(void(^)(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix))completionHandler;

/// /// 获取指定元数据的视频播放元
/// @param asset 指定元数据（asset.mediaType == PHAssetMediaTypeVideo）
/// @param completionHandler 完成回调
+ (void)playerItemForVideo:(PHAsset *)asset completionHandler:(void (^)(AVPlayerItem *__nullable playerItem))completionHandler;


#pragma mark - 扩展方法

/// 生成手机相册媒体对象（照片/视频）封面图
/// @param asset 相册媒体对象
/// @param coverSize 封面图尺寸枚举值
/// @param completionHandler 完成回调
+ (void)generateCoverOfAsset:(PHAsset *)asset
                   coverSize:(MCCoverSize)coverSize
               completionHandler:(void(^)(UIImage * _Nullable cover, NSDictionary * _Nullable info))completionHandler;

/// 将图片保存到指定名称的相簿
/// @param albumName 目标相簿名称
/// @param mediumURL 文件
- (void)saveMediumToAlbum:(NSString *)albumName
                mediumURL:(NSURL *)mediumURL
        completionHandler:(void(^)(BOOL success, NSError * _Nullable error))completetionHandler;

@end

NS_ASSUME_NONNULL_END
