//
//  LSSTitleSlideViewController.h
//  LSSTitleSlide
//
//  Created by Lushanshan on 2019/4/11.
//  Copyright © 2019 Lushanshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSSTitleSlideView.h"
#import "LSSTitleSliderConfig.h"
NS_ASSUME_NONNULL_BEGIN

@class LSSTitleSlideViewController;
// 声明数据源协议
@protocol LSSTitleSlideViewControllerDataSource <NSObject>

//@required //使用该关键字修饰的方法,必须实现
//@optional //使用该关键字修饰的方法,可选择性实现
//子视图数组
- (NSArray *)childViewControllersWithNavVC:(LSSTitleSlideViewController*)slideVC;
//标题数组
- (NSArray *)titlesWithNavVC:(LSSTitleSlideViewController*)slideVC;
@end

@protocol LSSTitleSlideViewControllerDelegate <NSObject>

//@required //使用该关键字修饰的方法,必须实现
//@optional //使用该关键字修饰的方法,可选择性实现
//这个方法可不实现
-(void)clickWithIndex:(NSInteger)index;
@optional

@end

@interface LSSTitleSlideViewController : UIViewController
// 设置代理及数据源属性
@property (strong, nonatomic)id <LSSTitleSlideViewControllerDelegate>  delegate;
@property (strong, nonatomic)id <LSSTitleSlideViewControllerDataSource> dataSource;
@property (strong, nonatomic)LSSTitleSliderConfig * config;

///**
// 设置标签位置
// */
//@property (assign, nonatomic)LSSTitleSlideStyle style;
///**
// 未选中状态文字颜色
// */
//@property (strong, nonatomic)UIColor * normalTitleColor;
///**
// 选中状态文字颜色
// */
//@property (strong, nonatomic)UIColor * selectTitleColor;
///**
//未选中状态文字字体
//*/
//@property (strong, nonatomic)NSString * normalTitleFontStr;
///**
//选中状态文字字体
//*/
//@property (strong, nonatomic)NSString * selectTitleFontStr;
//
///**
//选中状态文字大小
//*/
//@property (assign, nonatomic)CGFloat selectTitleSize;
///**
//未选中状态文字大小
//*/
//@property (assign, nonatomic)CGFloat normalTitleSize;
///**
// 滑块颜色
// */
//@property (strong, nonatomic)UIColor * slideColor;
///**
// 滑块高度
// */
//@property (assign, nonatomic)CGFloat slideHeight;
///**
//滑块宽度
//*/
//@property (assign, nonatomic)CGFloat slideWidth;
///**
// 按钮宽度
// */
//@property (assign, nonatomic)CGFloat btnWidth;

-(void)loadNavSliderView;
@property (strong, nonatomic)UIScrollView* scrollView;

@property(nonatomic,strong)LSSTitleSlideView * navView;
@property(nonatomic,strong)UILabel * sliderLabel;
@property(nonatomic,strong)NSArray * normalColorArrays;
@property(nonatomic,strong)NSArray * selectedColorArrays;
@property(nonatomic,strong)NSArray * deltaColorArrays;
@property (nonatomic, assign) CGFloat deltaScale;

@property (nonatomic, assign) CGFloat deltaNorR;

@property (nonatomic, assign) CGFloat deltaNorG;

@property (nonatomic, assign) CGFloat deltaNorB;

@property (nonatomic, assign) CGFloat deltaSelR;

@property (nonatomic, assign) CGFloat deltaSelG;

@property (nonatomic, assign) CGFloat deltaSelB;
@property (assign, nonatomic)NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
