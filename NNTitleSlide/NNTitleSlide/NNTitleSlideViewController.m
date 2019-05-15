//
//  NNTitleSlideViewController.m
//  NNTitleSlide
//
//  Created by nunu on 2019/4/11.
//  Copyright © 2019 nunu. All rights reserved.
//

#import "NNTitleSlideViewController.h"
#define NN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define NN_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define NN_STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

@interface NNTitleSlideViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    CGFloat offX;

}

@end

@implementation NNTitleSlideViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.selectTitleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.normalTitleFont = [UIFont systemFontOfSize:14];
    self.selectTitleFont = [UIFont systemFontOfSize:19];
    self.slideHeight = 2;
    self.slideColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.btnWidth = 80;

    // Do any additional setup after loading the view.
}
-(void)addTopView{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesWithNavVC:)]) {
        NSArray * titles = [self.dataSource titlesWithNavVC:self];
//        for (UIView *view in self.navigationController.navigationBar.subviews) {
//            if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
//                for (UIView *views in view.subviews) {
//                    if ([views isKindOfClass:[NNTitleSlideView class]]) {
//                        NSLog(@"%@",views);
//                        for (UIView * btnx  in views.subviews) {
//                            [btnx removeFromSuperview];
//                        }
//                        [views removeFromSuperview];
//                    }
//                }
//            }
//        }
        self.navView.frame = CGRectMake(0, 0, NN_SCREEN_WIDTH-80, 44);

        if (self.style == NNTitleSlideStyleCenter) {
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
        
        offX = self.style == NNTitleSlideStyleCenter ? (NN_SCREEN_WIDTH - 120 - titles.count * self.btnWidth)/2.0 : 0;
        
        self.sliderLabel.backgroundColor = self.slideColor;
        self.sliderLabel.layer.masksToBounds = YES;
        self.sliderLabel.layer.cornerRadius = self.slideHeight/2.0;
        
        [self.navView addSubview: self.sliderLabel];
        for (int i = 0; i < titles.count; i++) {
            UIButton * btn = [[UIButton alloc]init];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.frame = CGRectMake(self.btnWidth * i+offX, 0, self.btnWidth, 44);
            btn.tag = i+10;
            [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
            [btn setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
            btn.titleLabel.font = self.normalTitleFont;
            if (i == self.currentIndex) {
                btn.selected = YES;
                btn.titleLabel.font = self.selectTitleFont;
                self.sliderLabel.frame = CGRectMake((self.btnWidth - 16 )/2.0 + offX + self.btnWidth * i, 44-self.slideHeight-3, 16, self.slideHeight);
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
            UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(NN_SCREEN_WIDTH * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
            UIViewController * vc = vcs[i];
            [self addChildViewController:vc];
            [pageView addSubview:vc.view];
            [self.scrollView addSubview:pageView];
        }
        self.scrollView.contentSize = CGSizeMake(NN_SCREEN_WIDTH * (vcs.count), 0);
        self.scrollView.contentOffset = CGPointMake(NN_SCREEN_WIDTH * self.currentIndex, 0);

        }


}

#pragma mark - sliderLabel滑动动画
- (void)sliderAnimationWithTag:(NSInteger)tag{
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderLabel.frame = CGRectMake(self.btnWidth*(tag-10) +  (self.btnWidth - 16 )/2.0 + self->offX, self.sliderLabel.frame.origin.y, self.sliderLabel.frame.size.width, self.sliderLabel.frame.size.height);

        for (int i = 0; i<self.navView.subviews.count; i++) {
            UIView * obj = self.navView.subviews[i];
            
            if ([obj isKindOfClass:UIButton.class]) {
                UIButton * btn = (UIButton *)obj;
                
                if (btn.tag-10 == tag-10) {
                    btn.selected = YES;
                    btn.titleLabel.font = self.selectTitleFont;
                }
                else{
                    btn.selected = NO;
                    btn.titleLabel.font = self.normalTitleFont;
                }
            }
        }
        
        
    } completion:^(BOOL finished) {
        
    }];
    

}

-(void)sliderAction:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(NN_SCREEN_WIDTH * (sender.tag-10), 0);
    } completion:^(BOOL finished) {
        [self sliderAnimationWithTag:sender.tag];
        if (self.delegate) {
            [self.delegate clickWithIndex:sender.tag -10 ];
        }

    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index_ = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    [self sliderAnimationWithTag:index_+10];

}
//判断是否切换导航条按钮的状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index_ = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    if (self.delegate) {
        [self.delegate clickWithIndex:index_];
    }
}

-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, NN_SCREEN_WIDTH, NN_SCREEN_HEIGHT)];
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
-(NNTitleSlideView*)navView{
    if (!_navView) {
        _navView = [[NNTitleSlideView alloc]init];
    }
    return _navView;
}
-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
}
-(void)setSelectTitleColor:(UIColor *)selectTitleColor{
    _selectTitleColor = selectTitleColor;
}
-(void)setNormalTitleFont:(UIFont *)normalTitleFont{
    _normalTitleFont = normalTitleFont;
}
-(void)setSelectTitleFont:(UIFont *)selectTitleFont{
    _selectTitleFont = selectTitleFont;
}
-(void)setStyle:(NNTitleSlideStyle)style{
    _style = style;

    [self addTopView];
    [self addScrollView];

}
-(void)setSlideColor:(UIColor *)slideColor{
    _slideColor = slideColor;
}
-(void)setSlideHeight:(CGFloat)slideHeight{
    _slideHeight = slideHeight;
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
