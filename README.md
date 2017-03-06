# LBBanner

### 轮番图控件
##### 支持功能:
- 本地或网络图片
- 系统或自定义PageControl
- 标题切换
- 定时轮番
- 可监听当前图片的索引
- 可监听点击事件

##### 介绍
- 集成非常简单
- LBBanner的自定义能力也非常强
- 性能也是尽量做到最佳
- 在LBBannerImgs文件夹下面有几张默认的图片，使用时可以删除掉，在LBBannerTools文件夹下面是我使用的工具类，不可删除，如果在你的项目中也用到了，可删除掉一个

#### 使用方式
##### 初始化
```OBJC
/**
 *  这个初始化方法用来初始化本地图片
 */
- (instancetype)initWithImageNames:(NSArray *)imageNames andFrame:(CGRect)frame;

/**
 *  这个初始化方法用来初始化网络图片
 */
- (instancetype)initWithImageURLArray:(NSArray *)imageURLArray andFrame:(CGRect)frame;
```
##### 自定义PageControl
```OBJC
/**
 *  自定义PageControl试图，调用这个方法后，系统的PageControl就会被移除掉
 */
- (void)customPageControlWithNormalPageView:(UIView *)normalPageView andCurrentPageView:(UIView *)currentPageView andPageViewPadding:(CGFloat)pageViewPadding;
```

#### 设置标题
```OBJC
/**
 *  图片展示标题，和图片数组对应
 */
- (void)showTitleWithTitles:(NSArray *)titles;
```
#### 监听事件
```OBJC
/**
 *  点击页面后调用
 *
 *  @param banner       当前轮番器
 *  @param index 点击的第几个页面
 */
- (void)banner:(LBBanner *)banner didClickViewWithIndex:(NSInteger)index;

/**
 *  当前页面索引位置
 *
 *  @param banner        当前轮番器
 *  @param index 当前显示的是第几个页面
 */
- (void)banner:(LBBanner *)banner didChangeViewWithIndex:(NSInteger)index;
```
#### 效果图
![](http://i1.piimg.com/567571/bc34512adce65fa6.gif)    
![](http://i1.piimg.com/567571/5911f3d547f7f35b.gif)

