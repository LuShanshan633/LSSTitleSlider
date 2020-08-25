//
//  LSSNavigationViewController.m
//  LSSTitleSlide
//
//  Created by Lushanshan on 2019/4/22.
//  Copyright © 2019 Lushanshan. All rights reserved.
//



/*
 自定义导航栏拦截push事件
 */
#import "LSSNavigationViewController.h"
#import "LSSTitleSlideViewController.h"

@interface LSSNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation LSSNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.interactivePopGestureRecognizer.delegate = (id)self;
    self.interactivePopGestureRecognizer.enabled = YES;

    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.view endEditing:YES];//强制收键盘
    [super pushViewController:viewController animated:animated];
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
