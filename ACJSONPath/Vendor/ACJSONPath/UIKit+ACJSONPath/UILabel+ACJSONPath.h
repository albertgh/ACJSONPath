//
//  UILabel+ACJSONPath.h
//  ACJSONPath
//
//  Created by Albert Chu on 14-5-15.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ACJSONPath)

- (void)ac_setTextWithJSON:(NSDictionary *)dict andPath:(NSString *)path;

@end
