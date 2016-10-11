// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBBanner




#import "ViewController.h"

#import "LBBanner.h"

@interface ViewController () <LBBannerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadNetImageSystemPageControl];
    
    [self initImageNamesSystemPageControlAndTitle];
    
    [self loadNetImageCustomPageControlAndTitle];
}

/**
 *  加载网络图片、系统PageControl、不设置标题
 */
- (void)loadNetImageSystemPageControl {
    NSArray * imageURLArray = @[@"http://i4.piimg.com/567571/5bb2bd5f3d9ed1c9.jpg", @"http://i4.piimg.com/567571/0747e4dc1a1e5cc2.jpg", @"http://i4.piimg.com/567571/2245e6c27d0435dd.jpg", @"http://i4.piimg.com/567571/740fdc787945b551.jpg"];
    LBBanner * banner = [[LBBanner alloc] initWithImageURLArray:imageURLArray andFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    banner.delegate = self;
    [self.view addSubview:banner];
}

/**
 *  使用本地图片、系统PageControl、设置标题
 */
- (void)initImageNamesSystemPageControlAndTitle {
    NSArray * imageNames = @[@"index_banner1.jpg", @"index_banner2.jpg", @"index_banner3.jpg", @"index_banner4.jpg"];
    LBBanner * banner = [[LBBanner alloc] initWithImageNames:imageNames andFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 180)];
    banner.delegate = self;
    [banner showTitleWithTitles:@[@"~~~~~标题1~~~~~", @"~~~~~标题2~~~~~", @"~~~~~标题3~~~~~", @"~~~~~标题4~~~~~"]];
    [self.view addSubview:banner];
}

/**
 *  加载网络图片、自定义PageControl、设置标题
 */
- (void)loadNetImageCustomPageControlAndTitle {
    NSArray * imageURLArray = @[@"http://i4.piimg.com/567571/5bb2bd5f3d9ed1c9.jpg", @"http://i4.piimg.com/567571/0747e4dc1a1e5cc2.jpg", @"http://i4.piimg.com/567571/2245e6c27d0435dd.jpg", @"http://i4.piimg.com/567571/740fdc787945b551.jpg"];
    
    LBBanner * banner = [[LBBanner alloc] initWithImageURLArray:imageURLArray andFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 180)];
    banner.delegate = self;
    banner.pageTurnTime = 3.0;
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9, 3)];
    whiteView.backgroundColor = [UIColor whiteColor];
    UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9, 3)];
    blackView.backgroundColor = [UIColor blackColor];
    [banner customPageControlWithNormalPageView:whiteView andCurrentPageView:blackView andPageViewPadding:3];
    
    [self.view addSubview:banner];
}

- (void)banner:(LBBanner *)banner didClickViewWithIndex:(NSInteger)index {
    NSLog(@"didClickViewWithIndex:%ld", index);
}

- (void)banner:(LBBanner *)banner didChangeViewWithIndex:(NSInteger)index {
    NSLog(@"didChangeViewWithIndex:%ld", index);
}

@end
