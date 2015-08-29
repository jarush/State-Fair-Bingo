//
//  SquareCell.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/28/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "SquareCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SquareCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
        self.backgroundView.layer.borderWidth = 1.0f;

        CGRect labelFrame = CGRectInset(self.bounds, 2, 2);
        self.label = [[UILabel alloc] initWithFrame:labelFrame];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:10.0f];
        self.label.text = @"This is a Test";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 0;
        
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
