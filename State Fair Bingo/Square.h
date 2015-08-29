//
//  Square.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/29/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Square : NSObject <NSCoding>

@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithText:(NSString *)text;

@end
