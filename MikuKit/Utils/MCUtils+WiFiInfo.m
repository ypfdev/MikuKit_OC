//
//  MCUtils+WiFiInfo.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/25.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils+WiFiInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <net/if.h>

@implementation MCUtils (WiFiInfo)

/// WLAN开关状态（关闭返回NO；打开&已连接、打开&未连接都返回YES，即只能知道开关已打开，但无法区分是否已连接到热点）
+ (BOOL)ap_WLANState {
    NSCountedSet *cset = [NSCountedSet new];
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    BOOL state = [cset countForObject:@"awdl0"] > 1 ? YES : NO;
    return state;
}


/// WLAN连接性（关闭、打开&未连接都返回NO；打开&已连接返回YES）
+ (BOOL)ap_WLANConnection {
    BOOL ret = YES;
    NSMutableArray *activeInterfaceNames = [[NSMutableArray alloc] init];
    struct ifaddrs *first_ifaddr, *current_ifaddr;
    getifaddrs(&first_ifaddr);
    current_ifaddr = first_ifaddr;
    while (current_ifaddr!=NULL) {
        if (current_ifaddr->ifa_addr->sa_family == 0x02) {
            [activeInterfaceNames addObject:[NSString stringWithFormat:@"%s", current_ifaddr->ifa_name]];
        }
        current_ifaddr = current_ifaddr->ifa_next;
    }
    ret = [activeInterfaceNames containsObject:@"en0"] || [activeInterfaceNames containsObject:@"en1"];
    
    return ret;
}

+ (NSString *)getWiFiMacAddress {
    NSDictionary *infoDict = nil;
    NSArray *interfaceArr = CFBridgingRelease(CNCopySupportedInterfaces());
    for (NSString *ifname in interfaceArr) {
        infoDict = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifname);
        if (infoDict && [infoDict count]) {
            break;
        }
    }
    NSString *macAddress = [infoDict objectForKey:@"BSSID"];
    return macAddress;
}


+ (NSString *)getWiFiSSID {
    // 写法1
    NSArray *interfaceArr = CFBridgingRelease(CNCopySupportedInterfaces());
    NSDictionary * infoDict = nil;
    for (NSString *ifname in interfaceArr) {
        infoDict = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifname);
        if (infoDict && [infoDict count]) {
            break;
        }
    }
    return [[infoDict objectForKey:@"SSID"] lowercaseString];
    
    // 写法2
//    __block NSString *ssid = [NSString new];
//    CFArrayRef interfaces = CNCopySupportedInterfaces();
//    NSArray<NSString *> *interfaceArr = CFBridgingRelease(interfaces);
//    for (NSString *interfaceName in interfaceArr) {
//        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
//        if (dictRef) {
//            NSDictionary *infoDict = (__bridge NSDictionary *)dictRef;
//            ssid = [infoDict objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
//            CFRelease(dictRef);
//            break;
//        }
//    }
//    return ssid;
}


+ (NSString *)getWifiName {
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            PFLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    
    return wifiName;
}


+ (NSString *)getMacAddress {
    //get route mac
    NSString *rountMac = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            rountMac = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return rountMac;
}


+ (NSString *)getBroadCastAddress {
    NSString * broadCastAddr = @"error";
    struct ifaddrs *interface = NULL;
    struct ifaddrs *cursor_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interface);
    if (success == 0) {
        cursor_addr = interface;
        while (cursor_addr != NULL) {
            if (cursor_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:cursor_addr->ifa_name] isEqualToString:@"en0"]) {
                    unsigned int ipAddrInt = ((struct sockaddr_in*)cursor_addr->ifa_addr)->sin_addr.s_addr;
                    unsigned int maskAddrInt = ((struct sockaddr_in*)cursor_addr->ifa_netmask)->sin_addr.s_addr;
                    unsigned int broadcast = (ipAddrInt & maskAddrInt)|(~ maskAddrInt);
                    struct in_addr inaddr;
                    inaddr.s_addr = broadcast;
                    broadCastAddr = [NSString stringWithUTF8String:inet_ntoa(inaddr)];
                    break;
                }
            }
            cursor_addr = cursor_addr->ifa_next;
        }
    } else {
        PFLog(@"%s  %d  %@",__func__,__LINE__,@"getifaddrs failed");
        broadCastAddr = [[NSMutableString alloc] initWithString:[MCConfig schemeIP_HS]];
    }
    
    if (interface) {
        freeifaddrs(interface);
    }
    
    return broadCastAddr;
}


+ (NSString *)getHostIP {
    NSMutableString * ipAddress = nil;
    struct ifaddrs *interface = NULL;
    struct ifaddrs *cursor_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interface);
    if (success == 0) {
        cursor_addr = interface;
        while (cursor_addr != NULL) {
            if (cursor_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:cursor_addr->ifa_name] isEqualToString:@"en0"]) {
                    struct in_addr ipAddrInt = ((struct sockaddr_in*)cursor_addr->ifa_addr)->sin_addr;
                    ipAddress = [[NSMutableString alloc] initWithCString:inet_ntoa(ipAddrInt) encoding:NSUTF8StringEncoding];
                    NSRange range;
                    range.location = [ipAddress rangeOfString:@"." options:NSBackwardsSearch].location +1;
                    range.length = ipAddress.length - range.location;
                    //将本机地址的最后一个字段替换为1，得到网关地址
                    [ipAddress replaceCharactersInRange:range withString:@"1"];
                    break;
                }
            }
            cursor_addr = cursor_addr->ifa_next;
        }
    } else {
        PFLog(@"%s  %d  %@",__func__,__LINE__,@"getifaddrs failed");
        ipAddress = [[NSMutableString alloc] initWithString:CameraIP_Null];
    }
    
    if (interface) {
        freeifaddrs(interface);
    }
    
    return ipAddress;
}

@end
