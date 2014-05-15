//
//  ACJSONUtil.h
//  ACJ2ObjCFramework
//
//  Created by Albert Chu on 14-4-29.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACJSONUtil : NSObject

+ (instancetype)sharedInstance;

- (void)parsingJSONDataFromMainBundleByFile:(NSString *)fileString
                                    success:(void (^)(id responseObj))success
                                    failure:(void (^)(NSString *failureString))failure;

@end
