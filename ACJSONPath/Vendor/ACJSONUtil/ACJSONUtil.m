//
//  ACJSONUtil.m
//  ACJ2ObjCFramework
//
//  Created by Albert Chu on 14-4-29.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "ACJSONUtil.h"


#define JSONFilesPath                           @""

//#define k_kACJSONUtilReturnType                 @"k_kACJSONUtilReturnType"
//#define k_kACJSONUtilReturnObject               @"k_kACJSONUtilReturnObject"
//
//#define k_vACJSONUtilReturnFileNotExsit         @"k_vACJSONUtilReturnFileNotExsit"
//#define k_vACJSONUtilReturnError                @"k_vACJSONUtilReturnError"
//#define k_vACJSONUtilReturnNSDictionary         @"k_vACJSONUtilReturnNSDictionary"
//#define k_vACJSONUtilReturnNSArray              @"k_vACJSONUtilReturnNSArray"


@interface ACJSONUtil ()

@end


@implementation ACJSONUtil

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static ACJSONUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [ACJSONUtil new];
    });
    return _sharedInstance;
}

#pragma mark - Public Method

- (void)parsingJSONDataFromMainBundleByFile:(NSString *)fileString
                                    success:(void (^)(id responseObj))success
                                    failure:(void (^)(NSString *failureString))failure
{
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *filePath =
    [mainBundleDirectory
     stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", JSONFilesPath, fileString]];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    // 初始化返回字典相关信息
    //NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    id jsonObject;
    NSError *error;
    
    //-- json 解析 ---------------------------------------------------------------------------------
    if (jsonData)
    {
        jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingAllowFragments // kNilOptions
                                                       error:&error];
        if (jsonObject && !error)
        {
            //NSLog(@"Successfully deserialized...");
            
            /**
            if ([jsonObject isKindOfClass:[NSDictionary class]])    // 顶层是字典
            {
                resultDict[k_kACJSONUtilReturnType] = k_vACJSONUtilReturnNSDictionary;
                resultDict[k_kACJSONUtilReturnObject] = (NSDictionary *)jsonObject;
                //NSLog(@"Dersialized JSON Dictionary = %@", resultDict);
            }
            else if ([jsonObject isKindOfClass:[NSArray class]])    // 顶层是数组
            {
                resultDict[k_kACJSONUtilReturnType] = k_vACJSONUtilReturnNSArray;
                resultDict[k_kACJSONUtilReturnObject] = (NSArray *)jsonObject;
                //NSLog(@"Dersialized JSON Array = %@", jsonObject);
            }
             */
            
            if (success) /** info 正确则返回给成功 block */
            {
                success(jsonObject);
            }
            
        }
        else    // 解析出错
        {
            /**
            resultDict[k_kACJSONUtilReturnType] = k_vACJSONUtilReturnError;
            resultDict[k_kACJSONUtilReturnObject] = error;
            //NSLog(@"%@", error);
             */
            if (failure) /** info 正确则返回给成功 block */
            {
                failure(@"parsing error");
            }
        }

    }
    else    // 文件不存在
    {
        /**
        resultDict[k_kACJSONUtilReturnType] = k_vACJSONUtilReturnFileNotExsit;
        resultDict[k_kACJSONUtilReturnObject] = k_vACJSONUtilReturnFileNotExsit;
         */
        if (failure) /** info 正确则返回给成功 block */
        {
            failure(@"file not exsit");
        }
    }
    //--------------------------------------------------------------------------------------------//
    
    //return resultDict;
}

@end
