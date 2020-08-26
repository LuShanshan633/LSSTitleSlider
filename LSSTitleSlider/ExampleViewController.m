//
//  ExampleViewController.m
//  LSSTitleSlide
//
//  Created by Lushanshan on 2019/4/11.
//  Copyright © 2019 Lushanshan. All rights reserved.
//

#import "ExampleViewController.h"
#import "ChildViewController.h"


@interface ExampleViewController ()<LSSTitleSlideViewControllerDataSource,LSSTitleSlideViewControllerDelegate>

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
//    self.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
//    self.selectTitleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//    self.normalTitleFont = [UIFont systemFontOfSize:14];
//    self.selectTitleFont = [UIFont systemFontOfSize:19];
//    self.slideHeight = 2;
//    self.slideColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.normalTitleSize = 12;
    self.selectTitleSize = 20;
    self.btnWidth = 120;
    self.slideHeight = 2;
    self.slideWidth = 60;
    self.normalTitleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.selectTitleColor = [UIColor colorWithRed:0/255.0 green:192/255.0 blue:255/255.0 alpha:1];
    self.slideColor = self.selectTitleColor;
    self.currentIndex = 1;
    self.style = LSSTitleSlideStyleLeft;
    
    
    
    // Do any additional setup after loading the view.
}
-(void)clickWithIndex:(NSInteger)index{
    NSLog(@"%d",index);
}
-(NSArray*)childViewControllersWithNavVC:(LSSTitleSlideViewController *)slideVC{
    return @[[[ChildViewController alloc] init] ,[[ChildViewController alloc] init] ,[[ChildViewController alloc] init]  ];
}
-(NSArray*)titlesWithNavVC:(LSSTitleSlideViewController *)slideVC{
    return @[@"切尔奇二无",@"企鹅窝若群",@"热情无若群二"];
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
