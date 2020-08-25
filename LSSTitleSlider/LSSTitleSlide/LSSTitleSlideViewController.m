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
    self.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.selectTitleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.normalTitleFontStr = @"PingFangSC-Regular";
    self.selectTitleFontStr = @"PingFangSC-Regular";
    self.normalTitleSize = 14;
    self.selectTitleSize = 19;
    self.slideHeight = 2;
    self.slideColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.btnWidth = 80;

    // Do any additional setup after loading the view.
}
-(void)addTopView{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesWithNavVC:)]) {
        NSArray * titles = [self.dataSource titlesWithNavVC:self];
        self.navView.frame = CGRectMake(0, 0, NN_SCREEN_WIDTH-80, 44);

        if (self.style == LSSTitleSlideStyleCenter) {
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
        
        offX = self.style == LSSTitleSlideStyleCenter ? (NN_SCREEN_WIDTH - 120 - titles.count * self.btnWidth)/2.0 : 0;
        
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
            btn.titleLabel.font = [UIFont fontWithName:self.normalTitleFontStr size:self.normalTitleSize];
            if (i == self.currentIndex) {
                btn.selected = YES;
                btn.titleLabel.font = [UIFont fontWithName:self.selectTitleFontStr size:self.selectTitleSize];
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
- (void)sliderAnimationWithTag:(NSInteger)tag fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex offset:(CGFloat)offset  lineOffset:(CGFloat)lineOffset{
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderLabel.frame = CGRectMake(self.btnWidth*lineOffset +  (self.btnWidth - 16 )/2.0 + self->offX, self.sliderLabel.frame.origin.y, self.sliderLabel.frame.size.width, self.sliderLabel.frame.size.height);

        for (int i = 0; i<self.navView.subviews.count; i++) {
            UIView * obj = self.navView.subviews[i];
            
            if ([obj isKindOfClass:UIButton.class]) {
                UIButton * btn = (UIButton *)obj;
                if (toIndex > fromIndex) {
                    if (btn.tag-10 == toIndex) {
                        if (offset == 1) {
                            btn.selected = YES;
                        }
                        btn.titleLabel.font = [UIFont fontWithName:self.selectTitleFontStr size:self.normalTitleSize +  (self.selectTitleSize-self.normalTitleSize)*offset];

                    }
                    else if (btn.tag-10 == fromIndex){
                        if (offset == 1) {
                            btn.selected = NO;
                        }

                        btn.titleLabel.font = [UIFont fontWithName:self.normalTitleFontStr size:self.selectTitleSize - (self.selectTitleSize-self.normalTitleSize)*offset];

                    }

                }else{
                    if (btn.tag-10 == toIndex) {
                        if (offset == 1) {
                            btn.selected = YES;
                        }
                        
                        btn.titleLabel.font = [UIFont fontWithName:self.normalTitleFontStr size:self.normalTitleSize +  (self.selectTitleSize-self.normalTitleSize)* (offset !=1?(1-offset):1)];
                    }
                    else if (btn.tag-10 == fromIndex){
                        if (offset == 1) {
                            btn.selected = NO;
                        }

                        btn.titleLabel.font = [UIFont fontWithName:self.selectTitleFontStr size:self.selectTitleSize -  (self.selectTitleSize-self.normalTitleSize)* (offset !=1?(1-offset):1)];

                    }

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
        [self sliderAnimationWithTag:0 fromIndex:self.currentIndex toIndex:sender.tag-10 offset:1 lineOffset:sender.tag-10];
        self.currentIndex = sender.tag-10;
        //        [self sliderAnimationWithTag:sender.tag];
        if (self.delegate) {
            [self.delegate clickWithIndex:sender.tag -10 ];
        }

    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index_ = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    CGFloat scale = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    int index_s = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    CGFloat scales = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    if (self.currentIndex == index_s && scales>index_s) {
        index_s = index_s+1;
    }
    if (scale-index_ == 0) {
        scale = 1;
    }else{
        scale = scale - index_;
    }
    [self sliderAnimationWithTag:index_+10 fromIndex:self.currentIndex toIndex:index_s offset:scale lineOffset:scrollView.contentOffset.x / NN_SCREEN_WIDTH];

}
//判断是否切换导航条按钮的状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index_ = scrollView.contentOffset.x / NN_SCREEN_WIDTH;
    self.currentIndex = index_;
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
-(LSSTitleSlideView*)navView{
    if (!_navView) {
        _navView = [[LSSTitleSlideView alloc]init];
    }
    return _navView;
}
-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
}
-(void)setSelectTitleColor:(UIColor *)selectTitleColor{
    _selectTitleColor = selectTitleColor;
}
- (void)setNormalTitleSize:(CGFloat)normalTitleSize{
    _normalTitleSize = normalTitleSize;
}
- (void)setSelectTitleSize:(CGFloat)selectTitleSize{
    _selectTitleSize = selectTitleSize;
}
- (void)setNormalTitleFontStr:(NSString *)normalTitleFontStr{
    _normalTitleFontStr = normalTitleFontStr;
}
- (void)setSelectTitleFontStr:(NSString *)selectTitleFontStr {
    _selectTitleFontStr = selectTitleFontStr;
}
-(void)setStyle:(LSSTitleSlideStyle)style{
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
