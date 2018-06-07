//
//  BaseNavigationController.m
//  HoinDemo
//
//  Created by 帝青的Mac on 2018/5/28.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KWhiteColor,NSFontAttributeName:kFontSystem(19)}];
    [[UINavigationBar appearance] setBarTintColor:KNavColor];
    [[UINavigationBar appearance] setTintColor:KWhiteColor];
    [UINavigationBar appearance].translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController.navigationItem)
    {
        UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        [barButtonItem setTintColor:KWhiteColor];
        viewController.navigationItem.leftBarButtonItem = barButtonItem;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
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
