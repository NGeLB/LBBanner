// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBBanner




#import <UIKit/UIKit.h>

@class LBBanner;

@protocol LBBannerDelegate <NSObject>

/**
 *  点击页面后调用
 *
 *  @param banner       当前轮番器
 *  @param index 点击的第几个页面
 */
- (void)banner:(LBBanner *)banner didClickViewWithIndex:(NSInteger)index;

/**
 *  页面已经发生改变时调用
 *
 *  @param banner        当前轮番器
 *  @param index 当前显示的是第几个页面
 */
- (void)banner:(LBBanner *)banner didChangeViewWithIndex:(NSInteger)index;
@end

@interface LBBanner : UIView <UIScrollViewDelegate>

/**
 *  本地图片-初始化
 */
- (instancetype)initWithImageNames:(NSArray *)imageNames andFrame:(CGRect)frame;

/**
 *  网络图片-初始化
 */
- (instancetype)initWithImageURLArray:(NSArray *)imageURLArray andFrame:(CGRect)frame;

/**
 *  自定义PageControl试图
 */
- (void)customPageControlWithNormalPageView:(UIView *)normalPageView andCurrentPageView:(UIView *)currentPageView andPageViewPadding:(CGFloat)pageViewPadding;

/**
 *  本地图片数组
 */
@property (strong, nonatomic) NSArray * imageNames;

/**
 *  网络图片数组
 */
@property (strong, nonatomic) NSArray * imageURLArray;

/**
 *  翻页时间间隔(默认不自动滑动)
 */
@property (nonatomic, assign) CGFloat pageTurnTime;

/**
 *  每张图片展示标题
 */
- (void)showTitleWithTitles:(NSArray *)titles;

/**
 *  PageControl中心点位置
 */
@property (nonatomic, assign , readwrite) CGPoint pageControlCenter;

/**
 *  签订协议
 */
@property (nonatomic, weak) id <LBBannerDelegate> delegate;

@end
