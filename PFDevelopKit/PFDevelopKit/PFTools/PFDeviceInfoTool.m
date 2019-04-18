//
//  PFDeviceInfoTool.m
//  Test01
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import "PFDeviceInfoTool.h"

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <objc/runtime.h>        // 通过运行时获取手机安装的应用

@implementation PFDeviceInfoTool

/**
 查询手机信息总览

 @return 手机信息字典
 */
+ (NSDictionary *)phoneInfoOverview {
    
    /** UIDevice.currentDevice 的一些属性
     @property(nonatomic,readonly,strong) NSString    *name;              // e.g. "My iPhone"
     @property(nonatomic,readonly,strong) NSString    *model;             // e.g. @"iPhone", @"iPod touch"
     @property(nonatomic,readonly,strong) NSString    *localizedModel;    // localized version of model
     @property(nonatomic,readonly,strong) NSString    *systemName;        // e.g. @"iOS"
     @property(nonatomic,readonly,strong) NSString    *systemVersion;     // e.g. @"4.0"
     @property(nonatomic,readonly) UIDeviceOrientation orientation __TVOS_PROHIBITED;       // return current device orientation.  this will return UIDeviceOrientationUnknown unless device orientation notifications are being generated.
     
     @property(nullable, nonatomic,readonly,strong) NSUUID      *identifierForVendor NS_AVAILABLE_IOS(6_0);
     */
    
    NSDictionary *infoDict = [NSDictionary dictionary].mutableCopy;
    [infoDict setValue:UIDevice.currentDevice.name forKey:@"name"];
    [infoDict setValue:UIDevice.currentDevice.model forKey:@"model"];
    [infoDict setValue:UIDevice.currentDevice.localizedModel forKey:@"localizedModel"];
    [infoDict setValue:UIDevice.currentDevice.systemName forKey:@"systemName"];
    [infoDict setValue:UIDevice.currentDevice.systemVersion forKey:@"systemVersion"];
    [infoDict setValue:UIDevice.currentDevice.identifierForVendor forKey:@"identifierForVendor"];
    return infoDict;
}


#pragma mark - 获取手机系统版本

+ (NSString *)phoneSystemVersion {
    return UIDevice.currentDevice.systemVersion;
}


#pragma mark - 获取手机型号

+ (NSString *)phoneModel {
    // 获取设备名
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    // 返回该设备对应的型号
    if ([machineName isEqualToString:@"iPhone3,1"] ||
        [machineName isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([machineName isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([machineName isEqualToString:@"iPhone5,1"] ||
        [machineName isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([machineName isEqualToString:@"iPhone5,3"] ||
        [machineName isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([machineName isEqualToString:@"iPhone6,1"] ||
        [machineName isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([machineName isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([machineName isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([machineName isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([machineName isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([machineName isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([machineName isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([machineName isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([machineName isEqualToString:@"iPhone10,1"] ||
        [machineName isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([machineName isEqualToString:@"iPhone10,2"] ||
        [machineName isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([machineName isEqualToString:@"iPhone10,3"] ||
        [machineName isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([machineName isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([machineName isEqualToString:@"iPad2,1"] ||
        [machineName isEqualToString:@"iPad2,2"] ||
        [machineName isEqualToString:@"iPad2,3"] ||
        [machineName isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([machineName isEqualToString:@"iPad3,1"] ||
        [machineName isEqualToString:@"iPad3,2"] ||
        [machineName isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([machineName isEqualToString:@"iPad3,4"] ||
        [machineName isEqualToString:@"iPad3,5"] ||
        [machineName isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([machineName isEqualToString:@"iPad4,1"] ||
        [machineName isEqualToString:@"iPad4,2"] ||
        [machineName isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([machineName isEqualToString:@"iPad5,3"] ||
        [machineName isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([machineName isEqualToString:@"iPad6,3"] ||
        [machineName isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    if ([machineName isEqualToString:@"iPad6,7"] ||
        [machineName isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if ([machineName isEqualToString:@"iPad6,11"] ||
        [machineName isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([machineName isEqualToString:@"iPad7,1"] ||
        [machineName isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([machineName isEqualToString:@"iPad7,3"] ||
        [machineName isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    if ([machineName isEqualToString:@"iPad2,5"] ||
        [machineName isEqualToString:@"iPad2,6"] ||
        [machineName isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([machineName isEqualToString:@"iPad4,4"] ||
        [machineName isEqualToString:@"iPad4,5"] ||
        [machineName isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([machineName isEqualToString:@"iPad4,7"] ||
        [machineName isEqualToString:@"iPad4,8"] ||
        [machineName isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([machineName isEqualToString:@"iPad5,1"] ||
        [machineName isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    if ([machineName isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([machineName isEqualToString:@"iPod2,1"]) return @"iTouch2";
    if ([machineName isEqualToString:@"iPod3,1"]) return @"iTouch3";
    if ([machineName isEqualToString:@"iPod4,1"]) return @"iTouch4";
    if ([machineName isEqualToString:@"iPod5,1"]) return @"iTouch5";
    if ([machineName isEqualToString:@"iPod7,1"]) return @"iTouch6";
    
    if ([machineName isEqualToString:@"i386"] ||
        [machineName isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return @"Unknown";
}


#pragma mark - 获取电池电量

/**
 获取当前剩余电量百分比

 @return 剩余电量百分比
 */
+ (float)batteryLevel {
    // 注意，100%电量返回是 -1
    return [[UIDevice currentDevice] batteryLevel];
}


/**
 判断是否iPhoneX

 @return 判断结果
 */
+ (BOOL)isIphoneX {
    /** YPF：CoreGraphics/CGGeometry.h
     __CGSizeEqualToSize(CGSize size1, CGSize size2) {
        return size1.width == size2.width && size1.height == size2.height;
     }
     */
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}


#pragma mark - 获取手机上的所有应用信息

- (void)getIphoneAllApplications {
    Class LSApplicationWorkspace_class =objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSArray *apps= [workspace performSelector:@selector(allApplications)];
    
    Class LSApplicationProxy_class = objc_getClass("LSApplicationProxy");
    for (int i = 0; i < apps.count; i++) {
        NSObject *temp = apps[i];
        if ([temp isKindOfClass:LSApplicationProxy_class]) {
            //应用的bundleId
            NSString *appBundleId = [temp performSelector:NSSelectorFromString(@"applicationIdentifier")];
            
            //应用的名称
            NSString *appName = [temp performSelector:NSSelectorFromString(@"localizedName")];
            
            //应用的类型是系统的应用还是第三方的应用
            NSString * type = [temp performSelector:NSSelectorFromString(@"applicationType")];
            
            //应用的版本
            NSString * shortVersionString = [temp performSelector:NSSelectorFromString(@"shortVersionString")];
            NSString * resourcesDirectoryURL = [temp performSelector:NSSelectorFromString(@"containerURL")];
            
            NSLog(@"类型=%@应用的BundleId=%@ ++++应用的名称=%@版本号=%@\n%@",type,appBundleId,appName,shortVersionString,resourcesDirectoryURL);
        }
    }
    
}


#pragma mark - 应用内打开其他的App

- (void)openApp {
    
    Class lsawsc = objc_getClass("LSApplicationWorkspace");
    
    NSObject* workspace = [lsawsc performSelector:NSSelectorFromString(@"defaultWorkspace")];
    
    // iOS6 没有defaultWorkspace
    if ([workspace respondsToSelector:NSSelectorFromString(@"openApplicationWithBundleID:")]) {
        //通过App的BundleID 就可以访问
        [workspace performSelector:NSSelectorFromString(@"openApplicationWithBundleID:") withObject:@"com.galanz.GPlus"];
    }
    
}


@end
