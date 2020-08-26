//
//  LSSTitleSlideViewController.m
//  LSSTitleSlide
//
//  Created by Lushanshan on 2019/4/11.
//  Copyright © 2019 Lushanshan. All rights reserved.
//

#import "LSSTitleSlideViewController.h"
#define NN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define NN_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define NN_STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

@interface LSSTitleSlideViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    CGFloat offX;

}

@end

@implementation LSSTitleSlideViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.config.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.config.selectTitleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.config.normalTitleFontStr = @"PingFangSC-Regular";
    self.config.selectTitleFontStr = @"PingFangSC-Regular";
    self.config.normalTitleSize = 14;
    self.config.selectTitleSize = 19;
    self.config.slideHeight = 2;
    self.config.slideWidth = 20;
    self.config.scrollWidth = NN_SCREEN_WIDTH;
    self.config.scrollHeight = NN_SCREEN_HEIGHT;
    self.config.slideColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.config.btnWidth = 80;

    // Do any additional setup after loading the view.
}
-(void)addTopView{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesWithNavVC:)]) {
        NSArray * titles = [self.dataSource titlesWithNavVC:self];
        self.navView.frame = CGRectMake(0, 0, NN_SCREEN_WIDTH-80, 44);

        if (self.config.style == LSSTitleSlideStyleCenter) {
            UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
            [backBtn setTitle:@"返回" forState:UIControlStateNormal];
            [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
            self.navigationItem.leftBarButtonItem = item;
            self.navigationItem.titleView = self.navView;
            //占位，使titleview居中
            UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
            [rightBtn setTitle:@"返回" forState:UIControlStateNormal];
            [rightBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            UIBarButtonItem * items = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            self.navigationItem.rightBarButtonItem = items;

        }else{
            UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:self.navView];
            self.navigationItem.leftBarButtonItem = item;

        }
        
        offX = self.config.style == LSSTitleSlideStyleCenter ? (NN_SCREEN_WIDTH - 120 - titles.count * self.config.btnWidth)/2.0 : 0;
        
        self.sliderLabel.backgroundColor = self.config.slideColor;
        self.sliderLabel.layer.masksToBounds = YES;
        self.sliderLabel.layer.cornerRadius = self.config.slideHeight/2.0;
        
        [self.navView addSubview: self.sliderLabel];
        for (int i = 0; i < titles.count; i++) {
            UIButton * btn = [[UIButton alloc]init];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.frame = CGRectMake(self.config.btnWidth * i+offX, 0, self.config.btnWidth, 44);
            btn.tag = i+10;
            [btn setTitleColor:self.config.normalTitleColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:self.config.normalTitleFontStr size:self.config.normalTitleSize];
            if (i == self.config.currentIndex) {
                [btn setTitleColor:self.config.selectTitleColor forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:self.config.selectTitleFontStr size:self.config.selectTitleSize];
                self.sliderLabel.frame = CGRectMake((self.config.btnWidth - self.config.slideWidth )/2.0 + offX + self.config.btnWidth * i, 44-self.config.slideHeight-3, self.config.slideWidth, self.config.slideHeight);
            }
            [self.navView addSubview:btn];
            [btn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        //防止重复创建

    }

}
-(void)addScrollView{
    [self.view addSubview:self.scrollView];
    //调用dataSource
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(childViewControllersWithNavVC:)]) {
        NSArray * vcs = [self.dataSource childViewControllersWithNavVC:self];
        for (int i = 0; i < vcs.count; i++){
            //添加背景，把三个VC的view贴到mainScrollView上面
            LSSTitleSlideView *pageView = [vcs objectAtIndex:i];
            pageView.frame = CGRectMake(self.config.scrollWidth * i, 0, self.config.scrollWidth, self.config.scrollHeight);
            [self.scrollView addSubview:[vcs objectAtIndex:i]];
        }
        self.scrollView.contentSize = CGSizeMake(self.config.scrollWidth * (vcs.count), self.config.scrollHeight);
        self.scrollView.contentOffset = CGPointMake(self.config.scrollWidth * self.config.currentIndex, self.config.scrollHeight);

        }


}

#pragma mark - sliderLabel滑动动画
- (void)sliderAnimationWithTag:(NSInteger)tag fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex offset:(CGFloat)offset  lineOffset:(CGFloat)lineOffset{
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderLabel.frame = CGRectMake(self.config.btnWidth*lineOffset +  (self.config.btnWidth - self.config.slideWidth )/2.0 + self->offX, self.sliderLabel.frame.origin.y, self.sliderLabel.frame.size.width, self.sliderLabel.frame.size.height);

        for (int i = 0; i<self.navView.subviews.count; i++) {
            UIView * obj = self.navView.subviews[i];
            
            if ([obj isKindOfClass:UIButton.class]) {
                UIButton * btn = (UIButton *)obj;
                [self setRGBWithProgress:offset];

                if (toIndex > fromIndex) {

                    if (btn.tag-10 == toIndex) {
                        [btn setTitleColor:[UIColor colorWithRed:self.deltaSelR green:self.deltaSelG blue:self.deltaSelB alpha:1] forState:UIControlStateNormal];
                        btn.titleLabel.font = [UIFont fontWithName:self.config.selectTitleFontStr size:self.config.normalTitleSize +  (self.config.selectTitleSize-self.config.normalTitleSize)*offset];

                    }
                    else if (btn.tag-10 == fromIndex){
                        [btn setTitleColor:[UIColor colorWithRed:self.deltaNorR green:self.deltaNorG blue:self.deltaNorB alpha:1] forState:UIControlStateNormal];

                        btn.titleLabel.font = [UIFont fontWithName:self.config.normalTitleFontStr size:self.config.selectTitleSize - (self.config.selectTitleSize-self.config.normalTitleSize)*offset];

                    }

                }else{
                    if (btn.tag-10 == toIndex) {

                        if (offset == 1) {
                            [btn setTitleColor:self.config.selectTitleColor forState:UIControlStateNormal];
                        }else{
                            [btn setTitleColor:[UIColor colorWithRed:self.deltaNorR green:self.deltaNorG blue:self.deltaNorB alpha:1] forState:UIControlStateNormal];
                        }

                        btn.titleLabel.font = [UIFont fontWithName:self.config.normalTitleFontStr size:self.config.normalTitleSize +  (self.config.selectTitleSize-self.config.normalTitleSize)* (offset !=1?(1-offset):1)];
                    }
                    else if (btn.tag-10 == fromIndex){
                        if (offset == 1) {
                            [btn setTitleColor:self.config.normalTitleColor forState:UIControlStateNormal];
                        }else{
                            [btn setTitleColor:[UIColor colorWithRed:self.deltaSelR green:self.deltaSelG blue:self.deltaSelB alpha:1] forState:UIControlStateNormal];

                        }

                        btn.titleLabel.font = [UIFont fontWithName:self.config.selectTitleFontStr size:self.config.selectTitleSize -  (self.config.selectTitleSize-self.config.normalTitleSize)* (offset !=1?(1-offset):1)];

                    }

                }
            }
        }
        
        
    } completion:^(BOOL finished) {
        
    }];
    

}

-(void)sliderAction:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.config.scrollWidth * (sender.tag-10), 0);
    } completion:^(BOOL finished) {
        [self sliderAnimationWithTag:0 fromIndex:self.config.currentIndex toIndex:sender.tag-10 offset:1 lineOffset:sender.tag-10];
        self.config.currentIndex = sender.tag-10;
        //        [self sliderAnimationWithTag:sender.tag];
        if (self.delegate) {
            [self.delegate clickWithIndex:sender.tag -10 ];
        }

    }];
    
}
- (NSArray *)getRGBArrayWithColor:(UIColor *)color {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return @[@(r),@(g),@(b)];
}

- (void)setRGBWithProgress:(CGFloat)progress {
    _deltaSelR = [self.normalColorArrays[0] floatValue] + [self.deltaColorArrays[0] floatValue] * progress;
    _deltaSelG = [self.normalColorArrays[1] floatValue] + [self.deltaColorArrays[1] floatValue] * progress;
    _deltaSelB = [self.normalColorArrays[2] floatValue] + [self.deltaColorArrays[2] floatValue] * progress;
    _deltaNorR = [self.selectedColorArrays[0] floatValue] - [self.deltaColorArrays[0] floatValue] * progress;
    _deltaNorG = [self.selectedColorArrays[1] floatValue] - [self.deltaColorArrays[1] floatValue] * progress;
    _deltaNorB = [self.selectedColorArrays[2] floatValue] - [self.deltaColorArrays[2] floatValue] * progress;
}
- (NSArray *)deltaColorArrays {
    if (!_deltaColorArrays) {
        NSMutableArray *arrayM = [[NSMutableArray alloc]initWithCapacity:self.normalColorArrays.count];
        [self.normalColorArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayM addObject: @([self.selectedColorArrays[idx] floatValue] - [obj floatValue])];
        }];
        _deltaColorArrays = [arrayM copy];
    }
    return _deltaColorArrays;
}

- (NSArray *)normalColorArrays {
    if (!_normalColorArrays) {
        _normalColorArrays = [self getRGBArrayWithColor:self.config.normalTitleColor];
    }
    return _normalColorArrays;
}
- (NSArray *)selectedColorArrays {
    if (!_selectedColorArrays) {
        _selectedColorArrays = [self getRGBArrayWithColor:self.config.selectTitleColor];
    }
    return _selectedColorArrays;
}

- (NSArray *)transColorBeginColor:(UIColor *)beginColor andEndColor:(UIColor *)endColor {
    
    
    
    NSArray<NSNumber *> *beginColorArr = [self getRGBDictionaryByColor:beginColor];
    NSArray<NSNumber *> *endColorArr = @[@(1.0),@(1.0),@(1.0)];
    
    return @[@([endColorArr[0] doubleValue] - [beginColorArr[0] doubleValue]),@([endColorArr[1] doubleValue] - [beginColorArr[1] doubleValue]),@([endColorArr[2] doubleValue] - [beginColorArr[2] doubleValue])];
    
}
- (NSArray *)getRGBDictionaryByColor:(UIColor *)originColor
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @[@(r),@(g),@(b)];
}

- (UIColor *)getColorWithColor:(UIColor *)beginColor andCoe:(double)coe andEndColor:(UIColor *)endColor {
    NSArray *beginColorArr = [self getRGBDictionaryByColor:beginColor];
    NSArray *marginArray = [self transColorBeginColor:beginColor andEndColor:endColor];

    double red = [beginColorArr[0] doubleValue] + coe * [marginArray[0] doubleValue];
    double green = [beginColorArr[1] doubleValue]+ coe * [marginArray[1] doubleValue];
    double blue = [beginColorArr[2] doubleValue] + coe * [marginArray[2] doubleValue];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index_ = scrollView.contentOffset.x / self.config.scrollWidth;
    CGFloat scale = scrollView.contentOffset.x / self.config.scrollWidth;
    int index_s = scrollView.contentOffset.x / self.config.scrollWidth;
    CGFloat scales = scrollView.contentOffset.x / self.config.scrollWidth;
    if (self.config.currentIndex == index_s && scales>index_s) {
        index_s = index_s+1;
    }
    if (scale-index_ == 0) {
        scale = 1;
    }else{
        scale = scale - index_;
    }
    [self sliderAnimationWithTag:index_+10 fromIndex:self.config.currentIndex toIndex:index_s offset:scale lineOffset:scrollView.contentOffset.x / self.config.scrollWidth];

}
-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(self.config.scrollWidth * self.currentIndex, 0);
    self.config.currentIndex = currentIndex;
}
-(LSSTitleSliderConfig*)config{
    if (!_config) {
        _config = [LSSTitleSliderConfig new];
        
    }
    return _config;
}
//判断是否切换导航条按钮的状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index_ = scrollView.contentOffset.x / self.config.scrollWidth;
    self.config.currentIndex = index_;
    if (self.delegate) {
        [self.delegate clickWithIndex:index_];
    }
    for (int i = 0; i<self.navView.subviews.count; i++) {
        UIView * obj = self.navView.subviews[i];
        
        if ([obj isKindOfClass:UIButton.class]) {
            UIButton * btn = (UIButton *)obj;
            if (btn.tag == index_+10) {
                [btn setTitleColor:self.config.selectTitleColor forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:self.config.selectTitleFontStr size:self.config.selectTitleSize];
            }else{
                [btn setTitleColor:self.config.normalTitleColor forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:self.config.normalTitleFontStr size:self.config.normalTitleSize];

            }
        }
    }
}

-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.config.scrollWidth, self.config.scrollHeight)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UILabel *)sliderLabel{
    if (!_sliderLabel) {
        _sliderLabel = [[UILabel alloc]init];
    }
    return _sliderLabel;
}
-(LSSTitleSlideView*)navView{
    if (!_navView) {
        _navView = [[LSSTitleSlideView alloc]init];
    }
    return _navView;
}
-(void)loadNavSliderView{
    [self addScrollView];
    [self addTopView];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
