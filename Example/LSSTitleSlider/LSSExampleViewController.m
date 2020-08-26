//
//  LSSExampleViewController.m
//  LSSTitleSlider_Example
//
//  Created by 陆闪闪 on 2020/8/26.
//  Copyright © 2020 Lushanshan. All rights reserved.
//

#import "LSSExampleViewController.h"
#import "ChildViewController.h"
@interface LSSExampleViewController ()<LSSTitleSlideViewControllerDataSource,LSSTitleSlideViewControllerDelegate>

@end

@implementation LSSExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.config.normalTitleSize = 12;
    self.config.selectTitleSize = 20;
    self.config.btnWidth = 60;
    self.config.slideHeight = 2;
    self.config.slideWidth = 20;
    self.config.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.config.selectTitleColor = [UIColor colorWithRed:0/255.0 green:192/255.0 blue:255/255.0 alpha:1];
    self.config.slideColor = self.config.selectTitleColor;
    self.config.currentIndex = 1;
    self.config.style = LSSTitleSlideStyleLeft;
    //UI布局
    [self loadNavSliderView];
    // Do any additional setup after loading the view.
}
-(void)clickWithIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}
-(NSArray*)childViewControllersWithNavVC:(LSSTitleSlideViewController *)slideVC{
    return @[[[LSSTitleSlideView alloc] init] ,[[LSSTitleSlideView alloc] init] ,[[LSSTitleSlideView alloc] init] ,[[LSSTitleSlideView alloc] init] ,[[LSSTitleSlideView alloc] init]];
}
-(NSArray*)titlesWithNavVC:(LSSTitleSlideViewController *)slideVC{
    return @[@"首页",@"推荐",@"关注",@"关注",@"关注"];
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
