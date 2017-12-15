//
//  MineViewController.m
//  Bygones
//
//  Created by lizhao on 2017/12/15.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "MineViewController.h"
#import "DemoVC9.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setTitle:@"朋友圈" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 10, 300, 50);
    button.center = self.view.center;
    [button addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushVC {
    DemoVC9 *demo9 = [[DemoVC9 alloc] init];
    [self.navigationController pushViewController:demo9 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
