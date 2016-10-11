//
//  LBPageControl.h
//  MXClassroom
//
//  Created by 你个LB on 16/9/9.
//  Copyright © 2016年 你个LB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPageControl : UIControl

/**
 *  页面总数
 */
@property (nonatomic, assign) NSInteger numberOfPages;

/**
 *  当前展示的页
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 *  正常状态的试图（非当前页）
 */
@property (nonatomic, strong) UIView * normalPageView;

/**
 *  选中状态的试图（当前页）
 */
@property (nonatomic, strong) UIView * currentPageView;

/**
 *  分页控件的试图之间的间距
 */
@property (nonatomic, assign) CGFloat padding;
@end
