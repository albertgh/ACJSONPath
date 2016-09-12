//
//  NSDictionary+ACObjectFromDictionaryPath.m
//  ACJSONPath
//
//  Created by Albert Chu on 16/9/12.
//  Copyright © 2016年 Albert Chu. All rights reserved.
//

#import "NSDictionary+ACObjectFromDictionaryPath.h"

@implementation NSDictionary (ACObjectFromDictionaryPath)

+ (id)ac_objectFrom:(NSDictionary *)dictionary path:(NSString *)pathString {
    return [NSDictionary ac_objectFrom:dictionary path:pathString type:[NSObject class]];
}

+ (id)ac_objectFrom:(NSDictionary *)dictionary path:(NSString *)pathString type:(Class)validateClassType {
    if (!dictionary
        || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil; // wrong object
    }
    
    NSArray *keys = [pathString componentsSeparatedByString:@"."];
    
    id container = dictionary;
    
    for (NSString *key in keys) {
        if (key.length > 0) {
            if ([key hasSuffix:@"]"]) {
                NSArray *keyAndArrayIndexArray = [key componentsSeparatedByString:@"["];
                
                NSString *keyForArrayObj = keyAndArrayIndexArray[0];
                
                // top array
                NSArray *arrayObj = (NSArray *)((NSDictionary *)container[keyForArrayObj]);
                
                for (NSInteger i = 1; i < [keyAndArrayIndexArray count]; i++) {
                    NSString *indexString = keyAndArrayIndexArray[i];
                    NSInteger indexForContainer =
                    [(NSString *)[indexString substringToIndex:(indexString.length - 1)] integerValue];
                    
                    id element;
                    
                    if (indexForContainer >= 0
                        && indexForContainer < [arrayObj count]) {
                        element = arrayObj[indexForContainer];
                    } else {
                        return nil; // wrong index
                    }
                    
                    if (i == ([keyAndArrayIndexArray count] - 1)) {
                        container = element; // last array
                    } else {
                        if ([element isKindOfClass:[NSArray class]]) {
                            arrayObj = element; // next array
                        } else {
                            return nil; // no array
                        }
                    }
                }
            } else {
                if ([container isKindOfClass:[NSDictionary class]]) {
                    container = container[key];
                } else {
                    return nil; // no dictionary
                }
            }
        } else {
            return nil; // wrong path
        }
    }
    
    if ([container isKindOfClass:validateClassType]) {
        return container;
    } else {
        return nil; // unexpect type
    }
}

@end
