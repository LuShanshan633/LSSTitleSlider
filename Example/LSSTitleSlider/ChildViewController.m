//
//  ChildViewController.m
//  LSSTitleSlide
//
//  Created by Lushanshan on 2019/4/22.
//  Copyright © 2019 Lushanshan. All rights reserved.
//

#import "ChildViewController.h"
#import "PushOneViewController.h"
@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(100, 100, 200, 40);
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)push{
    [self.navigationController pushViewController:[[PushOneViewController alloc]init] animated:YES];
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
