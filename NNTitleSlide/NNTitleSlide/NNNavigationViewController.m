//
//  NNNavigationViewController.m
//  NNTitleSlide
//
//  Created by nunu on 2019/4/22.
//  Copyright © 2019 nunu. All rights reserved.
//



/*
 自定义导航栏拦截push事件
 */
#import "NNNavigationViewController.h"
#import "NNTitleSlideViewController.h"

@interface NNNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation NNNavigationViewController

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
//    for (int i = 0; i<self.viewControllers.count; i++) {
//        if (i == self.viewControllers.count-1) {
//            UIViewController * vcs = self.viewControllers[self.viewControllers.count - 1];
//            if ([vcs isKindOfClass:[NNTitleSlideViewController class]]) {
//                for (UIView *view in vcs.navigationController.navigationBar.subviews) {
//                    if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
//                        for (UIView *views in view.subviews) {
//                            if ([views isKindOfClass:[NNTitleSlideView class]]) {
//                                [views removeFromSuperview];
//                            }
//                        }
//                        
//                    }
//                }
//                
//            }else{
//                for (UIView *view in vcs.navigationController.navigationBar.subviews) {
//                    if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
//                        for (UIView *views in view.subviews) {
//                            if ([views isKindOfClass:[NNTitleSlideView class]]) {
//                                [views removeFromSuperview];
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
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
