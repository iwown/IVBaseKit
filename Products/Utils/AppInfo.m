//
//  AppInfo.m
//  ZeronerHealthPro
//
//  Created by CY on 2017/4/24.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (NSDictionary *)mainBundleInfo {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)getDisplayName {
    NSString *app_name = [[self mainBundleInfo] objectForKey:(NSString *)kCFBundleNameKey];
    return app_name;
}

+ (NSString *)getMajorVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return majorVersion;
}

+ (NSString *)getBuildVersion {
    NSString *buildVersion = [[self mainBundleInfo] objectForKey:(NSString *)kCFBundleVersionKey];
    return buildVersion;
}

+ (NSString *)getAppVersion {
    NSString *majorVersion = [self getMajorVersion];
    NSString *buildVersionString = [self getBuildVersion];
    NSString *appversion = [NSString stringWithFormat:@"%@(%@)",majorVersion,buildVersionString];
    return appversion;
}

@end
