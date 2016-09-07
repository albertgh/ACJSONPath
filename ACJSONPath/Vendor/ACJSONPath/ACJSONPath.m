//
//  ACJSONPath.m
//  ACJ2ObjCFramework
//
//  Created by Albert Chu on 14-5-15.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "ACJSONPath.h"

@implementation ACJSONPath

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static ACJSONPath *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [ACJSONPath new];
    });
    return _sharedInstance;
}

- (id)getDataFromJSONObject:(NSDictionary *)dictionary byPath:(NSString *)pathString
{
    if (!dictionary
        || ![dictionary isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSArray *keys = [pathString componentsSeparatedByString:@"."];
    
    /** 中间容器 */
    id container = dictionary;
    
    for (NSString *key in keys)
    {
        if (key.length > 0)
        {
            //NSRange range1 = [key rangeOfString:@"["];
            //NSRange range2 = [key rangeOfString:@"]"];
            
            // key 开头且需要从数组下标取元素的分支
            if (
                [key hasSuffix:@"]"]
                //range1.location != NSNotFound
                //&& range2.location != NSNotFound
                )
            {
                NSArray *keyAndArrayIndexArray = [key componentsSeparatedByString:@"["];
                //DLog(@"%lu", (unsigned long)[keyAndArrayIndexArray count]);
                
                NSString *keyForArrayObj = keyAndArrayIndexArray[0];
                
                // 顶层数组对象
                NSArray *arrayObj = (NSArray *)((NSDictionary *)container[keyForArrayObj]);
                
                // 处理多级数组
                /** 数组层数 (从1开始) */
                for (NSInteger i = 1; i < [keyAndArrayIndexArray count]; i++)
                {
                    NSString *indexString = keyAndArrayIndexArray[i];
                    NSInteger indexForContainer =
                    [(NSString *)[indexString substringToIndex:(indexString.length - 1)] integerValue];
                    
                    id element;
                    
                    // 判断数组下标是否越界
                    if (
                        indexForContainer >= 0
                        && indexForContainer < [arrayObj count]
                        )
                    {
                        element = arrayObj[indexForContainer];
                    }
                    else
                    {
                        // 下标越界
                        return nil;
                    }
                    
                    // 判断是否最后一层，是则赋给中间容器
                    if ( i == ([keyAndArrayIndexArray count] - 1) )
                    {
                        container = element;
                    }
                    else
                    {
                        // 如果不是最后一层，则判断该元素如果是数组对象才可以进入下一次循环继续循环取下标元素
                        if ([element isKindOfClass:[NSArray class]])
                        {
                            // 替换为新数组
                            arrayObj = element;
                        }
                        else
                        {
                            // 不存在的数组
                            return nil;
                        }
                    }
                }
            }
            // 只有 key, 不需要从数组下标取元素的分支
            else
            {
                if ([container isKindOfClass:[NSDictionary class]]) {
                    container = container[key];
                }
                else
                {
                    return nil; //不存在的字典
                }
            }
        }
        else
        {
            // wrong path
            return nil;
        }
    }
    return container;
}

@end
