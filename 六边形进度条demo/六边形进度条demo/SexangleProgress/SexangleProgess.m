//
//  SexangleProgess.m
//  六边形进度条demo
//
//  Created by asun on 15/11/10.
//  Copyright © 2015年 yinyi. All rights reserved.
//

#import "SexangleProgess.h"

@implementation SexangleProgess
{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame progressBackgroundColor:(UIColor*)progressBackgroundColor completeColor:(UIColor*)completeColor lineWidth:(CGFloat)lineWidth {
    if (self = [self initWithFrame:frame]) {
        self.progressBackgroundColor = progressBackgroundColor;
        self.completeColor = completeColor;
        self.lineWidth = lineWidth;
    }
    return self;
}

-(CGFloat)lineWidth {
    return _lineWidth ? _lineWidth : 10;
}

- (UIColor *)progressBackgroundColor {
    return _progressBackgroundColor ? _progressBackgroundColor : [UIColor grayColor];
}

- (UIColor *)completeColor {
    return _completeColor ? _completeColor : [UIColor blueColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat sqrt3 = sqrtf(3);
    CGFloat edgeX = (2.5 - sqrt3)/5;
    // 画背景色
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置线宽
    CGContextSetLineWidth(ctx, self.lineWidth);
    
    // 背景六边形
    CGMutablePathRef path = CGPathCreateMutable();
    
    [self.progressBackgroundColor set];
    
    CGPathMoveToPoint(path, NULL, rect.size.width * edgeX, rect.size.height * .3);
    
    CGPathAddLineToPoint(path, NULL, rect.size.width * .5, rect.size.height * .1);
    
    CGPathAddLineToPoint(path, NULL, rect.size.width * (.5 + sqrt3/5), rect.size.height * .3);
    
    CGPathAddLineToPoint(path, NULL, rect.size.width * (.5 + sqrt3/5), rect.size.height * .7);
    
    CGPathAddLineToPoint(path, NULL, rect.size.width * .5, rect.size.height * .9);
    
    CGPathAddLineToPoint(path, NULL, rect.size.width * edgeX, rect.size.height * .7);
    
    CGPathCloseSubpath(path);
    
    if (self.centerBackgroundColor) {
        //        CGContextSetStrokeColorWithColor(ctx, self.centerBackgroundColor.CGColor);
        //        CGContextStrokePath(ctx);
        [self.centerBackgroundColor setFill];
        CGContextAddPath(ctx, path);
        CGContextFillPath(ctx);
    }
    
    
    CGContextAddPath(ctx, path);
    
    CGContextStrokePath(ctx);
    
    // 裁剪背景图片
    if (self.image != nil && _imageView.image != self.image) {
        CGColorSpaceRef colorRef = CGColorSpaceCreateDeviceRGB();
        CGContextRef contextRef = CGBitmapContextCreate(nil, rect.size.width, rect.size.height, 8, rect.size.width*4, colorRef, kCGImageAlphaPremultipliedFirst);
        CGContextAddPath(contextRef, path);
        CGContextClip(contextRef);
        CGContextDrawImage(contextRef, CGRectMake(0, 0, rect.size.width, rect.size.height), self.image.CGImage);
        CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
        UIImage* imageDst = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        CGContextRelease(contextRef);
        CGColorSpaceRelease(colorRef);
        _imageView.image = imageDst;
    }
    
    // 设置背景颜色
    // 进度条
    CGMutablePathRef completePath = CGPathCreateMutable();
    [self.completeColor set];
    if (self.progress > 0) {
        if (self.progress > 0 && self.progress <= 33) {
            CGFloat progress = self.progress / 33;
            CGPathMoveToPoint(completePath, NULL, rect.size.width * ((sqrt3/5) * progress + edgeX), rect.size.height * (0.2 * (1 - progress) + .1));
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .3);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * (.4 * progress + .3));
            
        } else if (self.progress > 33 && self.progress <= 66) {
            CGFloat progress = (self.progress - 33) / 33;
            
            CGPathMoveToPoint(completePath, NULL, rect.size.width * ((sqrt3/5) * progress + .5), rect.size.height * (0.2 * progress + .1));
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * .5, rect.size.height * .1);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .3);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .7);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * ((sqrt3/5) * progress + edgeX), rect.size.height * (.2 * progress + .7));
            
        } else if (self.progress > 66 && self.progress <= 99){
            CGFloat progress = (self.progress - 66) / 33;
            CGPathMoveToPoint(completePath, NULL, rect.size.width * (.5 + sqrt3/5), rect.size.height * (0.4 * progress + 0.3));
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * (.5 + sqrt3/5), rect.size.height * .3);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * .5, rect.size.height * .1);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .3);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .7);
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * .5, rect.size.height * .9);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * ((sqrt3/5) * progress + .5), rect.size.height * (.2 * (1 - progress) + .7));
        } else {
            CGPathMoveToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .3);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * .5, rect.size.height * .1);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * (.5 + sqrt3/5), rect.size.height * .3);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * (.5 + sqrt3/5), rect.size.height * .7);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * .5, rect.size.height * .9);
            
            CGPathAddLineToPoint(completePath, NULL, rect.size.width * edgeX, rect.size.height * .7);
            
            CGPathCloseSubpath(completePath);
        }
        CGContextAddPath(ctx, completePath);
    }
    CGContextStrokePath(ctx);
    
    CGPathRelease(path);
    CGPathRelease(completePath);
}

//-(void)setFrame:(CGRect)frame {
//    _frame = frame;
//    if (!_imageView) {
//        _imageView = [[UIImageView alloc] init];
//    }
//    _imageView.frame = self.bounds;
//}

- (void)setProgress:(CGFloat)progress {
    if (progress >= 0 && progress <= 100) {
        _progress = progress;
    } else if (progress >100) {
        _progress = 100;
    } else {
        _progress = 0;
    }
    [self setNeedsDisplay];
}


- (void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}

@end
