// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBBanner




#import "LBPageControl.h"

@interface LBPageControl ()

@end

@implementation LBPageControl

#pragma mark - Lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark - Custom Accessors

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    // 获取的试图
    UIView * currentPageView = self.subviews[currentPage];
    [currentPageView addSubview:_currentPageView];
}

- (void)setNormalPageView:(UIView *)normalPageView {
    _normalPageView = normalPageView;
}

- (void)setCurrentPageView:(UIView *)currentPageView {
    _currentPageView = currentPageView;
}

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    
    // 一组视图的宽度
    CGFloat allWidth = _numberOfPages * _normalPageView.bounds.size.width + (_numberOfPages - 1) * self.padding;
    // 创建正常状态的试图
    for (int i = 0; i < self.numberOfPages; i ++) {
        CGFloat pageViewX = ([UIScreen mainScreen].bounds.size.width - allWidth) / 2 + i * _normalPageView.bounds.size.width + i * self.padding;
        
        UIView * pageView = [self duplicate:_normalPageView];
        pageView.frame = CGRectMake(pageViewX, 0, _normalPageView.bounds.size.width, _normalPageView.bounds.size.height);
        [self addSubview:pageView];
        if (i == 0) {
            // 设置frame
            [pageView addSubview:_currentPageView];
        }
    }
}

/**
 *   复制（深拷贝）
 */
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}


@end
