//
//  MCBaseVC.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/5.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "HCBaseRequest.h"

@implementation HCBaseRequest

#ifdef DEBUG //处于开发测试阶段
//命名空间
NSString * const HCNetworkNamespace = @"http://lenwin.cn/";
//端口号
NSString * const HCNetworkPort = @"http://api.puregarden.cn:59911/";

///< 关闭https SSL 验证
#define kOpenHttpsAuth NO

#else //处于发布正式阶段

NSString * const HCNetworkNamespace = @"http://lenwin.cn/";
NSString * const HCNetworkPort = @"http://api.lenwin.cn:53621/";

///< 开启https SSL 验证
#define kOpenHttpsAuth YES

#endif

static AFHTTPSessionManager *manager;

+ (AFHTTPSessionManager *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这里写成单例是因为afn的manager不是单例,每次获取都会重新创建,造成内存泄漏
        manager =[AFHTTPSessionManager manager];

//
//        //    常遇到下面的几种情况:
//        //    1、 服务端需要返回一段普通文本给客户端，Content-Type="text/plain"
//        //    2 、服务端需要返回一段HTML代码给客户端 ，Content-Type="text/html"
//        //    3 、服务端需要返回一段XML代码给客户端 ，Content-Type="text/xml"
//        //    4 、服务端需要返回一段JavaScript代码给客户端 Content-Type="text/javascript "
//        //    5 、服务端需要返回一段json串给客户端 Content-Type="application/json"
//        //设置请求头
//        [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
//        //使用soap返回的是xml
//        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml", nil];
        
        //接口调整,http协议
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    
    return manager;
}

/*
 
 soap body格式说明
 <方法名 xmlns="webservice命名空间">
 <参数1>参数值1</参数1>
 <参数2>参数值2</参数2>
 </方法名>
 
 NSString * soapBodyStr = [NSString stringWithFormat:@"<UserLogin xmlns=\"http://lenwin.cn/\">\n"
                                                    "<username>%@</username>\n"
                                                    "<password>%@</password>\n"
                                                    "</UserLogin>",@"测试门店01",@"4297f44b13955235245b2497399d7a93"];
 
*/


/*
 afn3.0可以使用代理获取数据解析,需要遵守代理<NSXMLParserDelegate>
 通过这个方法可以获取数据
 
 -(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

 */


//自动生成Soap的body
+ (NSString *)generateSOAPBodyWithMethodName:(NSString *)methodName parameter:(NSDictionary *)parameter{
  
    NSString *soapBodyStr;
    
    @try {
        
        //字典转字符串
        NSMutableString *parameterStr = [NSMutableString string];
        [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [parameterStr appendFormat:@"<%@>%@</%@>\n",key,obj,key];
        }];

        //公共参数 @"sign":@"",@"t":INTERVAL_STRING,@"from":@"iOS",@"UserId":0
        //记录:sign只是安全验证(张科说的)
        NSDictionary *publicParameter = @{@"sign":@"",@"t":INTERVAL_STRING,@"from":@"iOS",@"UserId":@([LYUser defaultUser].userId)};
        [publicParameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [parameterStr appendFormat:@"<%@>%@</%@>\n",key,obj,key];
        }];

        //拼接字符串
        soapBodyStr = [NSString stringWithFormat:@"<%@ xmlns=\"%@\">\n%@</%@>",methodName,HCNetworkNamespace,parameterStr,methodName];

        
    } @catch (NSException *exception) {
        NSLog(@"generateSOAPBody fail");
    } @finally {
        return soapBodyStr;
    }
 
}



+ (NSURLSessionDataTask *)SOAPPOST:(NSString *)URLString
                    soapBodyStr:(NSString *)soapBodyStr
                      progress:(void (^)(NSProgress *))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{


    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "%@"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n"
                             ,soapBodyStr];


//    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//
////    常遇到下面的几种情况:
////    1、 服务端需要返回一段普通文本给客户端，Content-Type="text/plain"
////    2 、服务端需要返回一段HTML代码给客户端 ，Content-Type="text/html"
////    3 、服务端需要返回一段XML代码给客户端 ，Content-Type="text/xml"
////    4 、服务端需要返回一段JavaScript代码给客户端 Content-Type="text/javascript "
////    5 、服务端需要返回一段json串给客户端 Content-Type="application/json"
//    //设置请求头
//    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//
//    //使用soap返回的是xml
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml", nil];

    AFHTTPSessionManager *manager =[HCBaseRequest shareManager];

    // 设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {

        return soapMessage;
    }];

    //拼接端口名
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HCNetworkPort,URLString];

    //post请求
    return [manager POST:urlStr parameters:soapMessage progress:uploadProgress success:success failure:failure];
    return nil;
}



//用于联调的测试方法,没有自动拼接url,可以直接输入指定到ip地址的url(只是临时测试的时候使用)
+ (NSURLSessionDataTask *)SOAPPOSTTest:(NSString *)URLString
                       soapBodyStr:(NSString *)soapBodyStr
                          progress:(void (^)(NSProgress *))uploadProgress
                           success:(void (^)(NSURLSessionDataTask *, id))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    

    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "%@"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n"
                             ,soapBodyStr];

    AFHTTPSessionManager *manager =[HCBaseRequest shareManager];

    // 设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {

        return soapMessage;
    }];

    //post请求
    return [manager POST:URLString parameters:soapMessage progress:uploadProgress success:success failure:failure];

}

#pragma mark - SOAPPOST使用说明
//@property (strong, nonatomic) NSString *jsonString
//@property(nonatomic,strong)NSString *methodName;
//
//- (void)getNetWorking{
//
//    NSString *soapBody = [HCBaseRequest generateSOAPBodyWithMethodName:@"GetIndexAd" parameter:@{@"barId":@(1)}];
//
//    [HCBaseRequest SOAPPOST:@"HomePage.asmx?WSDL" soapBodyStr:soapBody progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        [responseObject setDelegate:self];
//        [responseObject parse];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//
//}
//
//// 开始解析XML文档调用
//- (void)parserDidStartDocument:(NSXMLParser *)parser{
//    self.jsonString = [NSMutableString string];
//}
//
////解析节点的时候,记录这是在解析哪个方法(这个方法可以在一个.m文件中有多个请求的时候区分请求是哪一个)
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
//
//    if ([elementName isEqualToString:@"GetIndexAdResponse"]) {//这里的写法是"方法名+Response",因为xml的标签就是这样规定的
//        self.methodName = @"GetIndexAd";
//    }else if([elementName isEqualToString:@"GetCategoryResponse"]){
//        self.methodName = @"GetCategory";
//    }
//}
//
////解析每个节点数据
//-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    [self.jsonString appendString:string];
//}
//
//// 结束解析XML文档调用
//- (void)parserDidEndDocument:(NSXMLParser *)parser{
//    //这里是最后解析出json字符串,然后转Model
//     LYAdBaseModel *result = [LYAdBaseModel yy_modelWithJSON:self.jsonString];
//
//    if (result == nil) {
//        NSLog(@"json格式有误");
//        return;
//    }
//
//    //解析数据后,判断errCode
//    if (result.errCode == 0) {
//        //没有问题后就可以做需要使用数据的操作了
//    }else{
//        NSLog(@"%@",result.errMsg);
//        return;
//    }
//}


@end
