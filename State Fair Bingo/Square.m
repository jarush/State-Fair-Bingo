//
//  Square.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/29/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "Square.h"

@implementation Square

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        self.selected = NO;
    }
    return self;
}

#pragma mark - NSCoder

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _text = [coder decodeObjectForKey:@"text"];
        _selected = [coder decodeBoolForKey:@"selected"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.text forKey:@"text"];
    [coder encodeBool:self.selected forKey:@"selected"];
}

@end