//
//  SexangleProgess.h
//  六边形进度条demo
//
//  Created by asun on 15/11/10.
//  Copyright © 2015年 yinyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexangleProgess : UIView
/* 剩余进度颜色 默认灰色 */
@property (nonatomic,strong)UIColor *progressBackgroundColor;

/* 完成进度颜色 默认蓝色  */
@property (nonatomic,strong)UIColor *completeColor;

/* 宽度 默认10 */
@property (nonatomic,assign)CGFloat lineWidth;

/* 进度(0 ~ 100)  */
@property (nonatomic,assign)CGFloat progress;

/* 中间图片 如果有图片时候，线宽要除2 */
@property (nonatomic,strong)UIImage *image;

/* 中间背景颜色  */
@property (nonatomic,strong)UIColor *centerBackgroundColor;

/*
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame progressBackgroundColor:(UIColor*)progressBackgroundColor completeColor:(UIColor*)completeColor lineWidth:(CGFloat)lineWidth;

@end
