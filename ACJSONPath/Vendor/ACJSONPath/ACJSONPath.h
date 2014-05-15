//
//  ACJSONPath.h
//  ACJ2ObjCFramework
//
//  Created by Albert Chu on 14-5-15.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACJSONPath : NSObject

+ (instancetype)sharedInstance;

- (id)getDataFromJSONObject:(NSDictionary *)dictionary byPath:(NSString *)pathString;

@end
