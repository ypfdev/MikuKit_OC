//
//  PFRequestIPAddress.m
//  Galanz+
//
//  Created by 原鹏飞 on 2019/3/10.
//  Copyright © 2019 Galanz. All rights reserved.
//

#import "PFRequestIPAddress.h"
#import "PFIPAddressConfig.h"

#define IOS_VPN         @"utun0"
#define IOS_WIFI        @"en0"
#define IOS_CELLULAR    @"pdp_ip0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

// IPv4是32位地址长度，IPv6是128位地址长度

@implementation PFRequestIPAddress

+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    /* iPhone网络相关字段含义
     utun0：VPN
     en0：WiFi
     pdp_ip0：Cellular
     */
    // 构造目标key数组
    NSArray *keyArr;
    if (preferIPv4) {
        keyArr = @[@"utun0/ipv4",
//                   @"utun0/ipv6",
                   @"en0/ipv4",
                   @"en0/ipv6",
                   @"pdp_ip0/ipv4",
                   @"pdp_ip0/ipv6"];
        
    } else {
        keyArr = @[@"utun0/ipv6",
                   @"utun0/ipv4",
                   @"en0/ipv6",
                   @"en0/ipv4",
                   @"pdp_ip0/ipv6",
                   @"pdp_ip0/ipv4"];
    }
    
    // 取出iPhone的全部IP
    NSDictionary *addressDict = [self getIPAddresses];
    PFLog(@"addressDict: %@", addressDict);
    // 筛选出目标IP
    __block NSString *address;
    [keyArr enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addressDict[key];
        if (address) {
            *stop = YES;
        }
    }];
    return address ? address : @"0.0.0.0";
}

/// 获取iPhone的所有IP地址
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for (interface=interfaces; interface; interface = interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in *)interface->ifa_addr;
            char addrBuf[MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN)];
            if (addr && (addr->sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if (addr->sin_family == AF_INET) {
                    if (inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6 *)interface->ifa_addr;
                    if (inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if (type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

@end
