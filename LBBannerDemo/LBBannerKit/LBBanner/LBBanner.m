// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBBanner




#import "LBBanner.h"

#import "LBKitConst.h"
#import "LBPageControl.h"

@interface LBBanner ()

/**
 *  滑动试图
 */
@property (strong, nonatomic) UIScrollView * scrollView;

/**
 *  系统PageControl
 */
@property (strong, nonatomic) UIPageControl * systemPageCtrl;

/**
 *  自定义PageControl
 */
@property (strong, nonatomic) LBPageControl * customPageCtrl;

/**
 *  标题
 */
@property (strong, nonatomic) UILabel * titleLabel;

/**
 *  定时器
 */
@property (strong, nonatomic) NSTimer * timer;

/**
 *  是否允许定时器运行
 */
@property (assign, nonatomic) BOOL timingMove;

/**
 *  图片数组
 */
@property (strong, nonatomic) NSMutableArray * images;

/**
 *  标题数组
 */
@property (strong, nonatomic) NSArray * titles;

/**
 *  是否是自定义PageControl(NO:使用系统的  YES:自定义的) 默认情况是使用系统的
 */
@property (assign, nonatomic) BOOL isCustomPageCtrl;

@end

@implementation LBBanner

#pragma mark - Lifecycle

/**
 *  本地图片-初始化
 */
- (instancetype)initWithImageNames:(NSArray *)imageNames andFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化数据
        [self creatScrollView];
        
        [self creatSystemPageControll];
        [self creatCustomPageControl];
        
        [self initObject];
        
        self.imageNames = imageNames;
    }
    return self;
}

/**
 *  网络图片-初始化
 */
- (instancetype)initWithImageURLArray:(NSArray *)imageURLArray andFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化数据
        [self creatScrollView];
        
        [self creatSystemPageControll];
        [self creatCustomPageControl];
        
        [self initObject];
        
        self.imageURLArray = imageURLArray;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - Custom Accessors

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
    // 将图片名数组转换为图片数组
    for (NSString * imageName in imageNames) {
        UIImage * img = [UIImage imageNamed:imageName];
        [self.images addObject:img];
    }
    
    // 把这个图片数组添加首尾图片
    self.images = [[self addHeadAndTailImage:self.images] mutableCopy];
    
    [self setScrollViewData:self.images];
}

- (void)setImageURLArray:(NSArray *)imageURLArray {
    _imageURLArray = imageURLArray;
    
    // 将图片URL数组转换为图片数组
    
    //image
    dispatch_queue_t network_queue;
    
    network_queue = dispatch_queue_create("com.myapp.network", nil);
    
    dispatch_async(network_queue, ^{
        for (NSString * imageURL in imageURLArray) {
            UIImage * image = [self loadMyImageFromNetwork:imageURL];
            [self.images addObject:image];
        }
        
        //缓存到本地
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 显示图片到界面
            // 把这个图片数组添加首尾图片
            self.images = [[self addHeadAndTailImage:self.images] mutableCopy];
            
            [self setScrollViewData:self.images];
        });
    } );
}

-(UIImage*)loadMyImageFromNetwork:(NSString*)url
{
    NSData *dat = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *img = [UIImage imageWithData:dat];
    return img;
}

- (void)setPageTurnTime:(CGFloat)pageTurnTime {
    _pageTurnTime = pageTurnTime;
    
    [self addTimer];
    
    // 设置可以定时器开始
    self.timingMove = YES;
}

- (void)setPageControlCenter:(CGPoint)pageControlCenter {
    _pageControlCenter = pageControlCenter;
    
    // 设置PageControl的中心点
    self.systemPageCtrl.center = pageControlCenter;
    self.customPageCtrl.center = pageControlCenter;
}

#pragma mark - IBActions

/**
 *  图片按钮点击事件-通知代理
 */
- (void)imgViewBtnAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(banner:didClickViewWithIndex:)]) {
        [self.delegate banner:self didClickViewWithIndex:button.tag - 100];
    }
}

#pragma mark - Public

/**
 *  每张图片展示标题
 */
- (void)showTitleWithTitles:(NSArray *)titles  {
    self.titles = titles;
    
    // 创建标题标签
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, self.height - LBBannerTitleHeight, self.width, LBBannerTitleHeight);
    self.titleLabel.text = [titles firstObject];
    self.titleLabel.textColor = bannerColor_title_textColor;
    self.titleLabel.backgroundColor = bannerColor_title_bgColor;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.titleLabel];
}

/**
 *  自定义PageControl
 */
- (void)customPageControlWithNormalPageView:(UIView *)normalPageView andCurrentPageView:(UIView *)currentPageView andPageViewPadding:(CGFloat)pageViewPadding {
    self.isCustomPageCtrl = YES;
    self.systemPageCtrl = nil;
    self.customPageCtrl.normalPageView = normalPageView;
    self.customPageCtrl.currentPageView = currentPageView;
    self.customPageCtrl.padding = pageViewPadding;
}

#pragma mark - Private

/**
 *  初始化对象
 */
- (void)initObject {
    self.images = [NSMutableArray array];
    
    
    self.isCustomPageCtrl = NO;
}

/**
 *  创建滑动视图
 */
- (void)creatScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    // 隐藏水平导航栏
    self.scrollView.showsHorizontalScrollIndicator = NO;
    // 设置分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

/**
 *  创建分页控件
 */
- (void)creatSystemPageControll {
    self.systemPageCtrl = [[UIPageControl alloc] init];
    self.systemPageCtrl.frame = CGRectMake(0, self.height  - 20 - 40, self.width, 40);
    self.systemPageCtrl.enabled = NO;
//    [self.systemPageCtrl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.systemPageCtrl];
    [self insertSubview:self.systemPageCtrl aboveSubview:self.scrollView];
}

/**
 *  创建自定义分页控件
 */
- (void)creatCustomPageControl {
    self.customPageCtrl = [[LBPageControl alloc] init];
    self.customPageCtrl.frame = CGRectMake(0, self.height  - 20 - 40, self.width, 40);
    self.customPageCtrl.enabled = NO;
    [self addSubview:self.customPageCtrl];
    [self insertSubview:self.customPageCtrl aboveSubview:self.scrollView];
}

/**
 *  添加定时器
 */
- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:self.pageTurnTime target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    // 设置RunLoop模式，保证在tableView拖动的时候定时器仍然运行
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  切换到下一张图片
 */
- (void)nextImage{
    // 计算scrollView滚动的位置
    CGFloat offsetX = self.scrollView.contentOffset.x + self.width;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

/**
 *  为滑动试图设置数据
 */
- (void)setScrollViewData:(NSArray *)images {
    // 设置滑动视图的实际尺寸
    self.scrollView.contentSize = CGSizeMake(self.width * images.count, self.height);
    // 设置滑动视图的偏移量
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    for (int i = 0; i < images.count; i ++) {
        UIButton * imgViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgViewBtn.frame = CGRectMake(i * self.width, 0, self.width, self.height);
        [imgViewBtn setBackgroundImage:images[i] forState:UIControlStateNormal];
        [imgViewBtn setBackgroundImage:images[i] forState:UIControlStateHighlighted];
        imgViewBtn.tag = i + 100;
        [imgViewBtn addTarget:self action:@selector(imgViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.scrollView addSubview:imgViewBtn];
    }
    
    // 设置分页控件的页数
    self.systemPageCtrl.numberOfPages = self.images.count - 2;
    self.customPageCtrl.numberOfPages = self.images.count - 2;
}

/**
 *  设置PageControl的当前页
 */
- (void)setPageCtrlCurrentPage:(NSInteger)currentPage {
    if (self.isCustomPageCtrl == YES) {
        self.customPageCtrl.currentPage = currentPage;
    } else {
        self.systemPageCtrl.currentPage = currentPage;
    }
    [self noticeDelegateDidChangeViewWithIndex:currentPage];
}

/**
 *  通知代理对象
 */
- (void)noticeDelegateDidChangeViewWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(banner:didChangeViewWithIndex:)]) {
        [self.delegate banner:self didChangeViewWithIndex:index];
    }
}

/**
 *  数组的首尾添加图片
 *
 *  @param array 原始图片数组
 *  @return 在首位各添加一张图片的数组（尾添加到首，首添加到尾）
 */
- (NSArray *)addHeadAndTailImage:(NSArray *)array {
    NSMutableArray * mutableImageNames = [array mutableCopy];
    // 获取数组中的第一张图片
    NSString * firstImageName = [array firstObject];
    // 获取数组中的第二张图片
    NSString * lastImageName = [array lastObject];
    // 添加第一张图片到最后的位置
    [mutableImageNames insertObject:firstImageName atIndex:mutableImageNames.count];
    // 添加最后一张图片到第一的位置
    [mutableImageNames insertObject:lastImageName atIndex:0];
    return mutableImageNames;
}

#pragma mark - 更新PageController的当前页

/**
 *  更新PageController的当前页
 *
 *  @param contentOffset_x 当前滑动试图内容的偏移量
 */
- (void)updatePageCtrlWithContentOffset:(CGFloat)contentOffset_x{
    // 一定要用float类型，非常重要
    CGFloat index = contentOffset_x / (self.width) ;
    if (index >= self.images.count - 1) {
        // 滑到最后一个按钮（表面是第一个）
        //设置视图的偏移量到第二个按钮
        self.scrollView.contentOffset = CGPointMake(self.width, 0);
        [self setPageCtrlCurrentPage:0];
        self.titleLabel.text = [self.titles firstObject];
    }else if(index <= 0){
        // 滑到第一个按钮（表面是最后一个）
        self.scrollView.contentOffset = CGPointMake((self.images.count - 2) *self.width, 0);
        [self setPageCtrlCurrentPage:self.images.count - 3];
        NSInteger arrIndex = self.images.count - 3;
        self.titleLabel.text = self.titles[arrIndex];
    } else {
        //设置_pageCtrl显示的页数（减去第一个按钮）
        [self setPageCtrlCurrentPage:index - 1];
        NSInteger arrIndex = index - 1;
        self.titleLabel.text = self.titles[arrIndex];
    }
    
    // 通知代理当前展示的页发生变化
    if ([self.delegate respondsToSelector:@selector(banner:didChangeViewWithIndex:)]) {
//        [self.delegate banner:self didChangeViewWithIndex:]
    }
}

#pragma mark - UIScrollViewDelegate

/**
 *  在手指已经开始拖住的时候移除定时器
 *
 *  @param scrollView 滑动试图
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_timer) {
        [self removeTimer];
    }
}

/**
 *  在手指已经停止拖住的时候添加定时器
 *
 *  @param scrollView 滑动试图
 *  @param decelerate 是否有减速效果
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_timer == nil && _timingMove) {
        [self addTimer];
    }
}

/**
 *  当滑动试图停止减速（停止）调用（用于手动拖拽）
 *
 *  @param scrollView 滑动试图
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updatePageCtrlWithContentOffset:scrollView.contentOffset.x];
}


/**
 当滑动试图停止减速调用（用于定时器）
 
 @param scrollView 滑动试图
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updatePageCtrlWithContentOffset:scrollView.contentOffset.x];
}

@end
