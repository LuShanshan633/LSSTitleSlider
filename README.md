# NNTitleSlide

# 使用  
### navigationbar不可以隐藏！！！！！
//继承 NNTitleSlideViewController(不需要import)
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;//必要(记得引用delegate和DataSource)
    self.delegate = self;//可选

//其他属性设置参考.h文件
    self.currentIndex = 1;
    self.btnWidth = 50;
    self.slideHeight = 4;
    self.slideColor = TextThemeColor;

    self.style = NNTitleSlideStyleLeft;//必设置
    //使带有scrollview的页面拥有侧滑手势，否则会引起手势冲突
    [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];

}

-(NSArray*)childViewControllersWithNavVC:(NNTitleSlideViewController *)slideVC{
    return @[];//viewController数组,不想写，自己看demo吧
}
-(NSArray*)titlesWithNavVC:(NNTitleSlideViewController *)slideVC{
    return @[@"我是",@"小",@"仙女"];
}
