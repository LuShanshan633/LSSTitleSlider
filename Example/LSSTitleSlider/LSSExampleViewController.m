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
    self.normalTitleSize = 12;
    self.selectTitleSize = 20;
    self.btnWidth = 60;
    self.slideHeight = 2;
    self.slideWidth = 20;
    self.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.selectTitleColor = [UIColor colorWithRed:0/255.0 green:192/255.0 blue:255/255.0 alpha:1];
    self.slideColor = self.selectTitleColor;
    self.currentIndex = 1;
    self.style = LSSTitleSlideStyleLeft;

    // Do any additional setup after loading the view.
}
-(void)clickWithIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}
-(NSArray*)childViewControllersWithNavVC:(LSSTitleSlideViewController *)slideVC{
    return @[[[ChildViewController alloc] init] ,[[ChildViewController alloc] init] ,[[ChildViewController alloc] init]  ];
}
-(NSArray*)titlesWithNavVC:(LSSTitleSlideViewController *)slideVC{
    return @[@"首页",@"推荐",@"关注"];
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
