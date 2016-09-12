//
//  NSDictionary+ACObjectFromDictionaryPath.h
//  ACJSONPath
//
//  Created by Albert Chu on 16/9/12.
//  Copyright © 2016年 Albert Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ACObjectFromDictionaryPath)

+ (id)ac_objectFrom:(NSDictionary *)dictionary path:(NSString *)pathString;

+ (id)ac_objectFrom:(NSDictionary *)dictionary path:(NSString *)pathString type:(Class)validateClassType;

@end
