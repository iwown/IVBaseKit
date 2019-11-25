//
//  BKUtils+File.m
//  linyi
//
//  Created by caike on 16/12/20.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//
#include <CommonCrypto/CommonDigest.h>
#import "BKUtils+File.h"

@implementation BKUtils (File)

#pragma mark -File Handel
+ (void)checkFlieProtection:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathSqlite = path;
    NSDictionary *attributeSql = [fileManager attributesOfItemAtPath:pathSqlite error:nil];
    if ([[attributeSql objectForKey:NSFileProtectionKey] isEqualToString:NSFileProtectionComplete]) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObject:NSFileProtectionCompleteUntilFirstUserAuthentication
                                                              forKey:NSFileProtectionKey];
        [fileManager setAttributes:attribute ofItemAtPath:pathSqlite error:nil];
        NSLog(@"改变文件权限 %@ : %@",path,attribute);
    }
}

+ (BOOL)isFileExistAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (NSUInteger)fileSizes:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:&error];
    if (error) {
        return 0;
    }
    unsigned long long length = [fileAttributes fileSize];
    return (NSUInteger)length;
}

//创建文件夹
+ (BOOL)createDirWithPath:(NSString *)path Name:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [path stringByAppendingPathComponent:name];
    
    if ([fileManager fileExistsAtPath:testDirectory]) {
        return YES;
    }
    else
    {
        // 创建目录
        BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            NSLog(@"文件夹创建成功");
        }else
            NSLog(@"文件夹创建失败");
        
        return res;
    }
}

//创建文件
+ (BOOL)createFileWithPath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    else
    {
        return [self createFile:path];
    }
}

+ (BOOL)createFileWithPath:(NSString *)path
             andFileHeader:(NSString *)fileHeader {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    else
    {
        if ([self createFile:path]) {
            [self writeFile:fileHeader toPath:path];
            return YES;
        }
        return NO;
    }
}

+ (BOOL)createFile:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:NSFileProtectionNone
                                                           forKey:NSFileProtectionKey];
    BOOL res=[fileManager createFileAtPath:path contents:nil attributes:attributes];
    if (res) {
        NSLog(@"文件创建成功: %@" ,path);
    }else
        NSLog(@"文件创建失败");
    return res;
}

//删除文件
+ (void)deleteFileByPath:(NSString *)path {
    NSError *err ;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:&err];
}

//写文件
+ (BOOL)writeFileHead:(NSString *)str toPath:(NSString *)path {
    BOOL res=[str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else
        NSLog(@"文件写入失败");
    
    return res;
}

//写文件
+ (void)writeFile:(NSString *)str toPath:(NSString *)path {
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    [fileHandle seekToEndOfFile];  // 将节点跳到文件的末尾
    
    NSData* stringData  = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    @try {
        [fileHandle writeData:stringData]; //追加写入数据
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        [fileHandle closeFile];
    }
}

+ (NSArray *)selectAllFileInDir:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *arr = [fileManager contentsOfDirectoryAtPath:dirPath error:&error];
    if (error) {
        return nil;
    }
    return arr;
}

#define FileHashDefaultChunkSizeForReadingData 1024*8
+ (NSString*)getFileMD5WithPath:(NSString*)path {
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

@end
