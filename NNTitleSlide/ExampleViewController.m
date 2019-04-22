//
//  ExampleViewController.m
//  NNTitleSlide
//
//  Created by nunu on 2019/4/11.
//  Copyright © 2019 nunu. All rights reserved.
//

#import "ExampleViewController.h"
#import "ChildViewController.h"

@interface ExampleViewController ()<NNTitleSlideViewControllerDataSource,NNTitleSlideViewControllerDelegate>

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
    self.currentIndex = 1;
    self.style = NNTitleSlideStyleLeft;
    
    // Do any additional setup after loading the view.
}
-(void)clickWithIndex:(NSInteger)index{
    NSLog(@"%d",index);
}
-(NSArray*)childViewControllersWithNavVC:(NNTitleSlideViewController *)slideVC{
    return @[[[ChildViewController alloc] init] ,[[ChildViewController alloc] init] ,[[ChildViewController alloc] init]  ];
}
-(NSArray*)titlesWithNavVC:(NNTitleSlideViewController *)slideVC{
    return @[@"哈哈哈",@"呵呵呵",@"dd"];
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
