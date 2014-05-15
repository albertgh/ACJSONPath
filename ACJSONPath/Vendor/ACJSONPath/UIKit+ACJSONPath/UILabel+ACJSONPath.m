//
//  UILabel+ACJSONPath.m
//  ACJSONPath
//
//  Created by Albert Chu on 14-5-15.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "UILabel+ACJSONPath.h"

#import "ACJSONPath.h"

@implementation UILabel (ACJSONPath)

- (void)ac_setTextWithJSON:(NSDictionary *)dict andPath:(NSString *)path
{
    self.text = [[ACJSONPath sharedInstance] getDataFromJSONObject:dict
                                                               byPath:path];
}

@end
