//
//  MKPhotoManager.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2018/5/17.
//  Copyright © 2018 中软国际. All rights reserved.
//

#import "MKPhotoManager.h"

@interface MKPhotoManager ()

@property (nonatomic, copy) NSString *albumName;

@end

@implementation MKPhotoManager

#pragma mark - Initializer

// MARK: 单例写法1（推荐，更符合苹果范儿）

/// Returns the default singleton instance.
+ (instancetype)sharedManager {
    static MKPhotoManager *_singleton = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _singleton = [[self alloc] init];
    });
    
    return _singleton;
}

// MARK: 单例写法2

/// 用GCD实现创建单例
+ (instancetype)defaultManager {
   static MKPhotoManager *_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /** 注意！
         因为已经重写了allocWithZone方法，不能再使用alloc方法，所以这里要调用父类的分配空间的方法
         */
        _singleton = [[super allocWithZone:NULL] init];
    });
    return _singleton;
}

/** 防止外部调用alloc.init或new方法造成错误
 调用alloc.init和new的实质，最终都是调用了allocWithZone方法。
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [MKPhotoManager defaultManager];
}

/** 防止外部调用copy方法造成错误
 个人感觉，当单例类不遵循NSCopying协议时，外部调用copy本身就会出错。如果不是业务需求不遵循协议，该方法也可以不写。
 */
- (id)copyWithZone:(NSZone *)zone {
    return [MKPhotoManager defaultManager];
}

/** 防止外部调用mutableCopy造成错误
 个人感觉，当单例类不遵循NSMutableCopying协议时，外部调用mutableCopy本身就会出错。如果不是业务需求不遵循协议，该方法也可以不写。
 */
- (id)mutableCopyWithZone:(NSZone *)zone {
    return [MKPhotoManager defaultManager];
}


#pragma mark - 相册权限

+ (PHAuthorizationStatus)authorizationStatus {
    return [PHPhotoLibrary authorizationStatus];
}

+ (void)validateAuthorizationStatus:(void (^)(void))authorizedHandler {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        if (authorizedHandler) {
            authorizedHandler();
        }
    } else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if (authorizedHandler) {
                    authorizedHandler();
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MCAlertView showAlertWithTitle:nil
                                            message:MCLocal(@"tip_denied_album_permissions_byself")
                                             imgStr:nil
                                     cancelBtnTitle:MCLocal(@"cancel")
                                destructiveBtnTitle:MCLocal(@"tip_authorize")
                                        cancelBlock:^{
                        
                    } destructiveBlock:^{
                        // 跳转到该App的权限设置（>=iOS8）
                        NSURL *appSettingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:appSettingURL]) {
                            [[UIApplication sharedApplication] openURL:appSettingURL];
                        }
                    }];
                });
            }
        }];
    }
}


#pragma mark - 自定义相簿

/** PHAssetCollectionSubtype - 相簿类型枚举
// PHAssetCollectionTypeAlbum regular subtypes
PHAssetCollectionSubtypeAlbumRegular         = 2,  // 用户在Photos中创建的相册，可理解为逻辑相册
PHAssetCollectionSubtypeAlbumSyncedEvent     = 3,  // 使用iTunes从Photos照片库或者iPhoto照片库同步过来的事件。然而，在iTunes 12以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
PHAssetCollectionSubtypeAlbumSyncedFaces     = 4,  // 使用iTunes从    Photos照片库或者iPhoto照片库同步的人物相册。
PHAssetCollectionSubtypeAlbumSyncedAlbum     = 5,  // 做了AlbumSyncedEvent应该做的事
PHAssetCollectionSubtypeAlbumImported        = 6,  // 从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。

// PHAssetCollectionTypeAlbum shared subtypes
PHAssetCollectionSubtypeAlbumMyPhotoStream   = 100,    // 用户的iCloud照片流
PHAssetCollectionSubtypeAlbumCloudShared     = 101,    // 用户使用iCloud共享的相册

// PHAssetCollectionTypeSmartAlbum subtypes
PHAssetCollectionSubtypeSmartAlbumGeneric    = 200,    // 文档解释为非特殊类型的相册，主要包括从iPhoto同步过来的相册。由于本人的iPhoto已被Photos替代，无法验证。不过，在我的iPad mini上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
PHAssetCollectionSubtypeSmartAlbumPanoramas  = 201,    // 相机拍摄的全景照片
PHAssetCollectionSubtypeSmartAlbumVideos     = 202,    // 相机拍摄的视频
PHAssetCollectionSubtypeSmartAlbumFavorites  = 203,    // 收藏文件夹
PHAssetCollectionSubtypeSmartAlbumTimelapses = 204,    // 延时视频文件夹，同时也会出现在视频文件夹中
PHAssetCollectionSubtypeSmartAlbumAllHidden  = 205,    // 包含隐藏照片或视频的文件夹
PHAssetCollectionSubtypeSmartAlbumRecentlyAdded = 206, // 相机近期拍摄的照片或视频
PHAssetCollectionSubtypeSmartAlbumBursts     = 207,    // 连拍模式拍摄的照片，在iPad mini上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
PHAssetCollectionSubtypeSmartAlbumSlomoVideos = 208,   // Slomo是slow motion的缩写，高速摄影慢动作解析，在该模式下，iOS设备以120帧拍摄。不过我的iPad mini不支持，没法验证。
PHAssetCollectionSubtypeSmartAlbumUserLibrary = 209,   // 相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
PHAssetCollectionSubtypeSmartAlbumSelfPortraits API_AVAILABLE(ios(9)) = 210,
PHAssetCollectionSubtypeSmartAlbumScreenshots API_AVAILABLE(ios(9)) = 211,
PHAssetCollectionSubtypeSmartAlbumDepthEffect API_AVAILABLE(macos(10.13), ios(10.2), tvos(10.1)) = 212,
PHAssetCollectionSubtypeSmartAlbumLivePhotos API_AVAILABLE(macos(10.13), ios(10.3), tvos(10.2)) = 213,
PHAssetCollectionSubtypeSmartAlbumAnimated API_AVAILABLE(macos(10.15), ios(11), tvos(11)) = 214,
PHAssetCollectionSubtypeSmartAlbumLongExposures API_AVAILABLE(macos(10.15), ios(11), tvos(11)) = 215,
PHAssetCollectionSubtypeSmartAlbumUnableToUpload API_AVAILABLE(macos(10.15), ios(13), tvos(13)) = 216,

// Used for fetching, if you don't care about the exact subtype
PHAssetCollectionSubtypeAny = NSIntegerMax // 包含所有类型
*/

+ (BOOL)assetCollectionExistsWithLocalizedTitle:(NSString *)localizedTitle {
    // 取出所有自定义相簿，并比对标题
    PHFetchResult<PHAssetCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in result) {
        if ([collection.localizedTitle isEqualToString:localizedTitle]) {
            return YES;
        }
    }
    return NO;
}

+ (PHAssetCollection *)assetCollectionWithLocalizedTitle:(NSString *)localizedTitle {
    // 取出所有自定义相簿
    PHFetchResult<PHAssetCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 如果匹配到同名相簿，就返回该相簿
    for (PHAssetCollection *collection in result) {
        if ([collection.localizedTitle isEqualToString:localizedTitle]) {
            return collection;
        }
    }
    
    // 如果没有匹配到同名相簿，就创建一个
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:localizedTitle];
    } error:nil];
    
    // 再次取出所有自定义相簿
    result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 找到并返回新创建的相簿
    __block PHAssetCollection *newCollection;
    [result enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([assetCollection.localizedTitle isEqualToString:localizedTitle]) {
            newCollection = assetCollection;
            *stop = YES;
        }
    }];
    return newCollection;
}

+ (PHAssetCollection *)appAssetCollection {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *displayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return [MKPhotoManager assetCollectionWithLocalizedTitle:displayName];
}


#pragma mark - 相册元数据

+ (PHFetchResult<PHAsset *> *)assetsInAssetCollection:(PHAssetCollection *)assetCollection {
    // 获取该相簿的所有元数据，并返回
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    return [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
}

+ (void)imageFromAsset:(PHAsset *)asset completionHandler:(void (^)(UIImage * _Nullable image))completionHandler {
    if (asset.mediaType != PHAssetMediaTypeImage) {
        if (completionHandler) {
            completionHandler(nil);
        }
        return;
    }
    
    // 1. 生成图片请求配置
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    /** 同步请求开关，默认为NO
     YES：每次只返回一张照片，因为同步执行图片请求
     */
    imageOptions.synchronous = YES;
    /* 图像缩放枚举
     None：不缩放
     Fast：尽快地提供接近或稍微大于要求的尺寸
     Exact：精准提供要求的尺寸
     */
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    /* 图像质量枚举，只在synchronous为true时有效
     Opportunistic：在速度与质量中均衡
     HighQualityFormat：不管花费多长时间，提供高质量图像
     FastFormat：以最快速度提供好的质量
     */
    imageOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    // 用于对原始尺寸的图像进行裁剪，基于比例坐标。只在resizeMode为Exact时有效
    //    imageOptions.normalizedCropRect = CGRectMake(0, 0, kAdaptedWidth(120), kAdaptedWidth(120));
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(kAdaptedWidth(360), kAdaptedWidth(360))
                                              contentMode:PHImageContentModeDefault
                                                  options:imageOptions
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completionHandler) {
            completionHandler(result);
        }
    }];
}

+ (void)avAssetFromAsset:(PHAsset *)asset completionHandler:(void(^)(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix))completionHandler {
    if (asset.mediaType != PHAssetMediaTypeVideo) {
        if (completionHandler) {
            completionHandler(nil, nil);
        }
        return;
    }
    
    // 生成视频请求配置
    PHVideoRequestOptions *videoOptions = [[PHVideoRequestOptions alloc] init];
    videoOptions.networkAccessAllowed = YES;
    videoOptions.version = PHVideoRequestOptionsVersionCurrent;
    videoOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    // 实现进度回调
//    videoOptions.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//
//    };
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:videoOptions resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        if (completionHandler) {
            completionHandler(asset, audioMix);
        }
    }];
}

+ (void)playerItemForVideo:(PHAsset *)asset completionHandler:(void (^)(AVPlayerItem *__nullable playerItem))completionHandler {
    if (asset.mediaType != PHAssetMediaTypeVideo) {
        if (completionHandler) {
            completionHandler(nil);
        }
        return;
    }
    
     PHVideoRequestOptions *videoOptions = [[PHVideoRequestOptions alloc] init];
    videoOptions.networkAccessAllowed = YES;
    videoOptions.version = PHVideoRequestOptionsVersionCurrent;
    videoOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    // 实现进度回调
//    videoOptions.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//        
//    };
    
    [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:videoOptions resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        if (completionHandler) {
            completionHandler(playerItem);
        }
    }];
}


#pragma mark - 扩展方法

+ (void)generateCoverOfAsset:(PHAsset *)asset
                   coverSize:(MCCoverSize)coverSize
           completionHandler:(void(^)(UIImage * _Nullable cover, NSDictionary * _Nullable info))completionHandler {
    // 1. 创建图片请求配置
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    // 同步请求开关，默认为NO（YES时每次只会返回1张照片，因为图片请求是同步执行的）
    imageOptions.synchronous = YES;
    /* 图像缩放枚举
     None：不缩放
     Fast：尽快地提供接近或稍微大于要求的尺寸
     Exact：精准提供要求的尺寸
     */
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    /* 图像质量枚举，只在synchronous为true时有效
     Opportunistic：在速度与质量中均衡
     HighQualityFormat：不管花费多长时间，提供高质量图像
     FastFormat：以最快速度提供好的质量
     */
    imageOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    // 用于对原始尺寸的图像进行裁剪，基于比例坐标。只在resizeMode为Exact时有效
    //    imageOptions.normalizedCropRect = CGRectMake(0, 0, kAdaptedWidth(120), kAdaptedWidth(120));
    
    // 2. 换算图片目标尺寸
    CGSize targetSize;
    if (coverSize == MCCoverSizeAlbumCL) {
        targetSize = CGSizeMake(200, 200);
    } else if (coverSize == MCCoverSizeAlbumBrowser) {
        targetSize = CGSizeMake(500, 500);
    } else {
        targetSize = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    // 3. 获取图片
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:targetSize
                                              contentMode:PHImageContentModeDefault
                                                  options:imageOptions
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completionHandler) {
            completionHandler(result, info);
        }
    }];
}

- (void)saveMediumToAlbum:(NSString *)albumName mediumURL:(NSURL *)mediumURL completionHandler:(void(^)(BOOL success, NSError * _Nullable error))completetionHandler {
    /** 注意！
    修改系统相册建议用PHPhotoLibrary单例调用performChanges方法，否则苹果会报错，并提醒你使用这个API
    */
    
    // 检查手机相册中是否存在App自定义相簿，如果没有，就创建一个
    if ([MKPhotoManager assetCollectionExistsWithLocalizedTitle:MKAppName] == NO) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:MKAppName];
        } error:nil];
    }
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 生成请求配置（可设置原始文件名，这里设置为与sd卡对应文件相同）
        PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
        options.originalFilename = [[mediumURL.absoluteString componentsSeparatedByString:@"/"].lastObject componentsSeparatedByString:@"."].firstObject;
        // 生成创建元数据的请求
        PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest creationRequestForAsset];;
        if ([mediumURL.absoluteString containsString:@".JPG"] || [mediumURL.absoluteString containsString:@".jpg"]) {
            [assetCreationRequest addResourceWithType:PHAssetResourceTypePhoto fileURL:mediumURL options:options];
        } else {
            [assetCreationRequest addResourceWithType:PHAssetResourceTypeVideo fileURL:mediumURL options:options];
        }
        
        // 生成修改相簿的请求（主要是为了将最新文件的占位图设置为相册封面）
        PHAssetCollection *assetCollection = [MKPhotoManager assetCollectionWithLocalizedTitle:MKAppName];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        // 创建占位图片
        // 原因：performChanges是异步执行的，使用占位图片先为图片分配一个内存，方便将占位图设置为封面，等到有图片的时候，再对内存进行赋值
        PHObjectPlaceholder *placeholder = [assetCreationRequest placeholderForCreatedAsset];
        if (placeholder) {
            // 将占位图设置为相簿的封面
            [assetCollectionChangeRequest insertAssets:@[placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (completetionHandler) {
            completetionHandler(success, error);
        }
    }];
    
    
    // 异步保存媒体文件
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        // 1. 创建一个操作图库的对象
//        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
//
//        // 2. 获取指定名称的相册，如果不存在就创建一个
//        // 2.1 获取所有相册
//        PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//        PHAssetCollection *assetCollection;
//        // 2.2 遍历相册数组,是否已创建该相册
//        for (PHAssetCollection *ac in result) {
//            if ([ac.localizedTitle isEqualToString:[MCConfig appName]]) {
//                assetCollection = ac;
//            }
//        }
//        // 2.3 如果相册不存在，就创建一个
//        if (assetCollection) {
//            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
//        } else {
//            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:[MCConfig appName]];
//        }
//
//        // 3. 保存图片/视频
//        PHAssetChangeRequest *assetChangeRequest;
//        if (self.type == MCMediumTypePhoto) {
//            assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:filePath];
//        } else if (self.type == MCMediumTypeVideo) {
//            assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:filePath];
//        }
//
//        // 4. 把创建好的图片添加到自己相册
//        // 使用占位图片的原因：这个block是异步执行的，使用占位图片先为图片分配一个内存，等到有图片的时候，再对内存进行赋值
//        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
//        // 最后添加的作为封面
//        [assetCollectionChangeRequest insertAssets:@[placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];
//
//        // 将下载的媒体在手机相册的localIdentifier缓存到磁盘
//        NSString *fileName = [filePath.absoluteString componentsSeparatedByString:@"/"].lastObject;
//        [[MCLocalIdentifierCache localIdentifierCache] addIdentifier:placeholder.localIdentifier forKey:fileName];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        // 操作结束的回调
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (success) {
//                // 更新任务状态
//                self.state = MCDownloadTaskStateSuccess;
//                // 发送下载成功的通知
//                NSString *fileName = [relativePath componentsSeparatedByString:@"/"].lastObject;
//                [[NSNotificationCenter defaultCenter] postNotificationName:MCDownloadTaskSucceedNotification object:nil userInfo:@{@"fileName":fileName}];
//            } else {
//                // 如果下载失败，移除磁盘缓存的localIdentifier
//                NSString *fileName = [self.relativePath componentsSeparatedByString:@"/"].lastObject;
//                [[MCLocalIdentifierCache localIdentifierCache] removeObjectForKey:fileName];
//                // 更新任务状态
//                self.state = MCDownloadTaskStateFailure;
//                self.failureCount += 1; // 失败次数+1
//            }
//            // 发送下载任务数量改变的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:MCDownloadTaskNumChangedNotification object:nil];
//            // 更新下载器任务队列
//            [MCDownloadManager sharedManager].currentConcurrency -= 1;
//            [[MCDownloadManager sharedManager] updateTaskQueue];
//        });
//    }];
    
    
     // 方法1
     // 异步保存媒体文件
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        if (self.type == MCMediumTypePhoto) {
//            [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:filePath];
//        } else if (self.type == MCMediumTypeVideo) {
//            [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:filePath];
//        }
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        // 保存结束的回调
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (success) {
//                NSLog(@"保存成功");
//                self.state = MCDownloadTaskStateSuccess;
//
//            } else {
//                NSLog(@"保存失败, error = %@", error);
//                self.state = MCDownloadTaskStateFailure;
//                // 失败次数+1
//                self.failureCount += 1;
//            }
//            // 发送下载任务数量改变的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:MCDownloadTaskNumChangedNotification object:nil];
//            // 更新下载器任务队列
//            [MCDownloadManager sharedManager].currentConcurrency -= 1;
//            [[MCDownloadManager sharedManager] updateTaskQueue];
//        });
//    }];
}


#pragma mark 使用UIKit保存图片/视频到相册

- (void)saveMediumWithFilePath:(NSString *)filePath {
    // 先判断文件是否存在
    BOOL isDirectory = NO;
    BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isFileExist) {
        if ([filePath containsString:@".JPG"]) {
            // Adds a photo to the saved photos album.  The optional completionSelector should have the form:
            //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
            UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:filePath], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        } else if ([filePath containsString:@".MP4"]) {
            // Is a specific video eligible to be saved to the saved photos album?
            BOOL isVideoCompatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(filePath);
            if (isVideoCompatible) {
                // Adds a video to the saved photos album. The optional completionSelector should have the form:
                //  - (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
                UISaveVideoAtPathToSavedPhotosAlbum(filePath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            } else {
                NSLog(@"该视频无法保存至相册");
            }
        }
    } else {
        NSLog(@"文件不存在");
    }
}

/// UIKit保存图片完成回调（固定格式）（注意图片过大可能会crash）
/// @param image 图片对象
/// @param error 错误对象
/// @param contextInfo 上下文信息
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存图片失败：%@", error.localizedDescription);
    }
}

/// UIKit保存视频完成回调（固定格式）
/// @param videoPath 视频文件路径
/// @param error 错误对象
/// @param contextInfo 上下文信息
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败：%@", error.localizedDescription);
    }
}


#pragma mark - 待整理API

+ (void)savePhoto:(UIImage *)photo toAlbum:(NSString *)albumName {
    PHAuthorizationStatus status = [self authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        // 系统授权弹窗
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                // 保存图片
            } else if (status == PHAuthorizationStatusDenied) {
                
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        // 保存图片
    } else {
        // 如果权限是拒绝，弹窗提示用户授权
        NSString *msg = [NSString stringWithFormat:@"%@ needs album write permission to save pictures to album,  please authorize.", [MCUtils appName]];
        [MCAlertView showAlertWithTitle:nil
                                message:msg
                                 imgStr:nil
                         cancelBtnTitle:MCLocal(@"cancel")
                    destructiveBtnTitle:MCLocal(@"ok")
                            cancelBlock:nil
                       destructiveBlock:^{
            // 跳转到该App的权限设置（>=iOS8）
            NSURL *appSettingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:appSettingURL]) {
                [[UIApplication sharedApplication] openURL:appSettingURL];
            }
        }];
    }
}

- (void)saveimageIntoAlbum:(nonnull UIImage *)image  {
    // 1.先保存图片到【相机胶卷】
    PHFetchResult<PHAsset *> *createdAssets = [self createdAssets:image];
    if (createdAssets == nil) {
         NSLog(@"保存图片失败");
    }
    // 2.拥有一个【自定义相册】
    PHAssetCollection * assetCollection = self.createCollection;
    if (assetCollection == nil) {
         NSLog(@"创建相册失败");
    }
    // 3.将刚才保存到【相机胶卷】里面的图片引用到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        PHAssetCollectionChangeRequest *requtes = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        // [requtes addAssets:@[placeholder]];
        [requtes insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if (error) {
         NSLog(@"保存图片失败");
    } else {
         NSLog(@"保存图片成功");
    }
}

- (void)saveToNewThumb:(nonnull UIImage *)image {
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    // 检查用户访问权限
    // 如果用户还没有做出选择，会自动弹框
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied ) { // 用户拒绝当前App访问权限
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    NSLog(@"提醒用户打开开关");
                }
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问
                [self saveimageIntoAlbum:image];
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                NSLog(@"因系统原因，无法访问相册");
            }
        });
    }];
}

/// 将图片存入相册，并返回对应的元数据
/// @param image 图片
- (PHFetchResult<PHAsset *> *)createdAssets:(nonnull UIImage *)image {
    // 同步执行修改操作
    NSError *error = nil;
    __block NSString *assertId = nil;
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        assertId =  [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if (error) {
        PFLog(@"保存失败");
        return nil;
    }
    // 获取相片
    PHFetchResult<PHAsset *> *createdAssets = [PHAsset fetchAssetsWithLocalIdentifiers:@[assertId] options:nil];
    return createdAssets;
}

/// 获取app对应的自定义相簿
- (PHAssetCollection*)createCollection {
    //获取App名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString*)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查询当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    // 当前对应的app相册没有被创建
    NSError *error = nil;
    __block NSString *createCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        //创建一个【自定义相册】(需要这个block执行完，相册才创建成功)
        createCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        PFLog(@"创建相册失败");
        return nil;
    }
    // 根据唯一标识，获得刚才创建的相册
    PHAssetCollection *createCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createCollectionID] options:nil].firstObject;
    
    return createCollection;
}

@end
