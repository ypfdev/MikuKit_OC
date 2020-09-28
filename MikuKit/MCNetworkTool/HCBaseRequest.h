//
//  MCBaseVC.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/5.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

//extern NSString * const HCNetworkDomain;

#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>

@interface HCBaseRequest : NSObject
////单例类,以防内存泄漏
//+ (AFHTTPSessionManager *)shareManager;

//post方法
+ (NSURLSessionDataTask *)SOAPPOST:(NSString *)URLString
                             soapBodyStr:(NSString *)soapBodyStr
                               progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;
//
////post方法,测试图片上传
//+ (NSURLSessionDataTask *)testSOAPPOST:(NSString *)URLString
//                       soapBodyStr:(NSString *)soapBodyStr
//                           imgData:(NSData *)imgData
//                          progress:(void (^)(NSProgress *uploadProgress))uploadProgress
//                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


//生成body
+ (NSString *)generateSOAPBodyWithMethodName:(NSString *)methodName
                     parameter:(NSDictionary *)parameter;



/**
 这是一个用于测试的方法,没有进行url的拼接,测试的时候可以直接根据url访问
 */
//+ (NSURLSessionDataTask *)SOAPPOSTTest:(NSString *)URLString
//                       soapBodyStr:(NSString *)soapBodyStr
//                          progress:(void (^)(NSProgress *uploadProgress))uploadProgress
//                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;
//

@end
