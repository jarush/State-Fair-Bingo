//
//  HeaderView.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/29/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect imageViewFrame = CGRectInset(frame, 4, 4);
        imageViewFrame.size.height = 62;
        imageViewFrame.origin.y = frame.size.height - 64;

        _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        _imageView.image = [UIImage imageNamed:@"header.jpg"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
    }
    return self;
}

@end
