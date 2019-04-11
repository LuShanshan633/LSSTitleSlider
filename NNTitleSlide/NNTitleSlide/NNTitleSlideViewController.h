//
//  NNTitleSlideViewController.h
//  NNTitleSlide
//
//  Created by nunu on 2019/4/11.
//  Copyright © 2019 nunu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NNTitleSlideStyle) {
    NNTitleSlideStyleCenter,
    NNTitleSlideStyleLeft,
    NNTitleSlideStyleRight
};


@class NNTitleSlideViewController;
// 声明数据源协议
@protocol NNTitleSlideViewControllerDataSource <NSObject>

//@required //使用该关键字修饰的方法,必须实现
//@optional //使用该关键字修饰的方法,可选择性实现
//子视图数组
- (NSArray *)childViewControllersWithNavVC:(NNTitleSlideViewController*)slideVC;
//标题数组
- (NSArray *)titlesWithNavVC:(NNTitleSlideViewController*)slideVC;
@end

@protocol NNTitleSlideViewControllerDelegate <NSObject>

//@required //使用该关键字修饰的方法,必须实现
//@optional //使用该关键字修饰的方法,可选择性实现
//这个方法可不实现
-(void)clickWithIndex:(NSInteger)index;
@optional

@end

@interface NNTitleSlideViewController : UIViewController
// 设置代理及数据源属性
@property (strong, nonatomic)id <NNTitleSlideViewControllerDelegate>  delegate;
@property (strong, nonatomic)id <NNTitleSlideViewControllerDataSource> dataSource;
/**
 设置标签位置
 */
@property (assign, nonatomic)NNTitleSlideStyle style;
/**
 未选中状态文字颜色
 */
@property (strong, nonatomic)UIColor * normalTitleColor;
/**
 选中状态文字颜色
 */
@property (strong, nonatomic)UIColor * selectTitleColor;
/**
 未选中状态文字字体
 */
@property (strong, nonatomic)UIFont * normalTitleFont;
/**
 选中状态文字字体
 */
@property (strong, nonatomic)UIFont * selectTitleFont;

/**
 滑块颜色
 */
@property (strong, nonatomic)UIColor * slideColor;
/**
 滑块高度
 */
@property (assign, nonatomic)CGFloat slideHeight;
/**
 按钮宽度
 */
@property (assign, nonatomic)CGFloat btnWidth;

/**
 当前默认索引
 */
@property (assign, nonatomic)NSInteger currentIndex;

@property (strong, nonatomic)UIScrollView* scrollView;



@end

NS_ASSUME_NONNULL_END
