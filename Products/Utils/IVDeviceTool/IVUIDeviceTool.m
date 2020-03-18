//
//  IVUIDeviceTool.m
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/8/30.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "IVUIDeviceTool.h"
#include <sys/types.h>
#include <sys/sysctl.h>
@implementation IVUIDeviceTool
//获得设备型号
+ (NSString *)GetCurrentDeviceModel {
    
    int mib[2];
    size_t len;
    char *machine;

    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);

    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
        
    if([platform isEqualToString:@"iPhone3,1"])return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"])return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"])return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])return @"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"])return @"iPhone 5(GSM+CDMA)";
    if([platform isEqualToString:@"iPhone5,3"])return @"iPhone 5c(GSM)";
    if([platform isEqualToString:@"iPhone5,4"])return @"iPhone 5c(GSM+CDMA)";
    
    if([platform isEqualToString:@"iPhone6,1"])return @"iPhone 5s(GSM)";
    if([platform isEqualToString:@"iPhone6,2"])return @"iPhone 5s(GSM+CDMA)";
    
    if([platform isEqualToString:@"iPhone7,1"])return @"iPhone 6 Plus";
    if([platform isEqualToString:@"iPhone7,2"])return @"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])return @"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"])return @"iPhone 6s Plus";
    if([platform isEqualToString:@"iPhone8,4"])return @"iPhone SE";
   
    if([platform isEqualToString:@"iPhone9,1"])return @"iPhone 7 国行、日版、港行";
    if([platform isEqualToString:@"iPhone9,2"])return @"iPhone 7 Plus 港行、国行";
    if([platform isEqualToString:@"iPhone9,3"])return @"iPhone 7 美版、台版";
    if([platform isEqualToString:@"iPhone9,4"])return @"iPhone 7 Plus 美版、台版";
    
    if([platform isEqualToString:@"iPhone10,1"])return @"iPhone 8 国行(A1863)、日行(A1906)";
    if([platform isEqualToString:@"iPhone10,4"])return @"iPhone 8 美版(Global/A1905)";
    
    if([platform isEqualToString:@"iPhone10,2"])return @"iPhone 8 Plus 国行(A1864)、日行(A1898)";
    if([platform isEqualToString:@"iPhone10,5"])return @"iPhone 8 Plus 美版(Global/A1897)";
    
    if([platform isEqualToString:@"iPhone10,3"])return @"iPhone X 国行(A1865)、日行(A1902)";
    if([platform isEqualToString:@"iPhone10,6"])return @"iPhone X 美版(Global/A1901)";
    
    if ([platform isEqualToString:@"iPhone11,2"])return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"])return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])return @"iPhone XR";
    
    if ([platform isEqualToString:@"iPhone12,1"])return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])return @"iPhone 11 Pro Max";
    
    if([platform isEqualToString:@"iPod1,1"])return @"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])return @"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])return @"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])return @"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])return @"iPod Touch(5 Gen)";
    
    if([platform isEqualToString:@"iPad1,1"])return @"iPad";
    if([platform isEqualToString:@"iPad1,2"])return @"iPad 3G";
    
    if([platform isEqualToString:@"iPad2,1"])return @"iPad 2(WiFi)";
    if([platform isEqualToString:@"iPad2,2"])return @"iPad 2";
    if([platform isEqualToString:@"iPad2,3"])return @"iPad 2(CDMA)";
    if([platform isEqualToString:@"iPad2,4"])return @"iPad 2";
    if([platform isEqualToString:@"iPad2,5"])return @"iPad Mini(WiFi)";
    if([platform isEqualToString:@"iPad2,6"])return @"iPad Mini";
    if([platform isEqualToString:@"iPad2,7"])return @"iPad Mini(GSM+CDMA)";
    
    if([platform isEqualToString:@"iPad3,1"])return @"iPad 3(WiFi)";
    if([platform isEqualToString:@"iPad3,2"])return @"iPad 3(GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,3"])return @"iPad 3";
    if([platform isEqualToString:@"iPad3,4"])return @"iPad 4(WiFi)";
    if([platform isEqualToString:@"iPad3,5"])return @"iPad 4";
    if([platform isEqualToString:@"iPad3,6"])return @"iPad 4(GSM+CDMA)";
    
    if([platform isEqualToString:@"iPad4,1"])return @"iPad Air(WiFi)";
    if([platform isEqualToString:@"iPad4,2"])return @"iPad Air(Cellular)";
    if([platform isEqualToString:@"iPad4,4"])return @"iPad Mini 2(WiFi)";
    if([platform isEqualToString:@"iPad4,5"])return @"iPad Mini 2(Cellular)";
    if([platform isEqualToString:@"iPad4,6"])return @"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,7"])return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"])return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"])return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])return @"iPad Mini 4(WiFi)";
    if([platform isEqualToString:@"iPad5,2"])return @"iPad Mini 4(LTE)";
    if([platform isEqualToString:@"iPad5,3"])return @"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"])return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"])return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"])return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"])return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,11"])return @"iPad 5(WiFi)";
    if([platform isEqualToString:@"iPad6,12"])return @"iPad 5(Cellular)";
    
    if([platform isEqualToString:@"iPad7,1"])return @"iPad Pro 12.9 inch 2nd gen(WiFi)";
    if([platform isEqualToString:@"iPad7,2"])return @"iPad Pro 12.9 inch 2nd gen(Cellular)";
    if([platform isEqualToString:@"iPad7,3"])return @"iPad Pro 10.5 inch(WiFi)";
    if([platform isEqualToString:@"iPad7,4"])return @"iPad Pro 10.5 inch(Cellular)";
    
    if([platform isEqualToString:@"AppleTV2,1"])return @"Apple TV 2";
    if([platform isEqualToString:@"AppleTV3,1"])return @"Apple TV 3";
    if([platform isEqualToString:@"AppleTV3,2"])return @"Apple TV 3";
    if([platform isEqualToString:@"AppleTV5,3"])return @"Apple TV 4";
    
    if([platform isEqualToString:@"i386"])return @"Simulator";
    if([platform isEqualToString:@"x86_64"])return @"Simulator";
    return platform;
}

@end
