// 开发者: NGeLB
// QQ交流群: 572296164
// GitHub 代码地址:https://github.com/NGeLB/LBBanner




#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "UIViewExt.h"
#import "UIView+ViewController.h"

// 当前设备的物理尺寸
#define LBkScreen_width [UIScreen mainScreen].bounds.size.width

#define LBkScreen_height [UIScreen mainScreen].bounds.size.height

// 颜色定义
#define LBkColor(r,g,b,a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#pragma mark - LBBanner

// 设置标题背景颜色(LBBanner)
#define bannerColor_title_bgColor [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:0.7]

// 设置标题文本颜色(LBBanner)
#define bannerColor_title_textColor [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1.0]


// 常量
// 轮番图标题的高度
UIKIT_EXTERN const CGFloat LBBannerTitleHeight;




