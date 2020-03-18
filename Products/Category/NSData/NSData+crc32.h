//
//  NSData+crc32.h
//  IVBaseKit
//
//  Created by A$CE on 2020/3/18.
//  Copyright © 2020 Iwown. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (crc32)

- (uint32_t)crc32;

@end

NS_ASSUME_NONNULL_END
