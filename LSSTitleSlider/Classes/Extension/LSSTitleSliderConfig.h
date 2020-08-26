//
//  LSSTitleSliderConfig.h
//  FBSnapshotTestCase
//
//  Created by 陆闪闪 on 2020/8/26.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LSSTitleSlideStyle) {
    LSSTitleSlideStyleCenter,
    LSSTitleSlideStyleLeft,
    LSSTitleSlideStyleRight
};

NS_ASSUME_NONNULL_BEGIN


@interface LSSTitleSliderConfig : NSObject
/**
 设置标签位置
 */
@property (assign, nonatomic)LSSTitleSlideStyle style;
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
@property (strong, nonatomic)NSString * normalTitleFontStr;
/**
选中状态文字字体
*/
@property (strong, nonatomic)NSString * selectTitleFontStr;

/**
选中状态文字大小
*/
@property (assign, nonatomic)CGFloat selectTitleSize;
/**
未选中状态文字大小
*/
@property (assign, nonatomic)CGFloat normalTitleSize;
/**
 滑块颜色
 */
@property (strong, nonatomic)UIColor * slideColor;
/**
 滑块高度
 */
@property (assign, nonatomic)CGFloat slideHeight;
/**
滑块宽度
*/
@property (assign, nonatomic)CGFloat slideWidth;
/**
 按钮宽度
 */
@property (assign, nonatomic)CGFloat btnWidth;
/**
 当前默认索引
 */
@property (assign, nonatomic)NSInteger currentIndex;
/**
 视图高度
 */
@property (assign, nonatomic)CGFloat scrollHeight;
/**
视图宽度
*/
@property (assign, nonatomic)CGFloat scrollWidth;

@end

NS_ASSUME_NONNULL_END
