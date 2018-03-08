//
//  DiyCodeLoginViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/6.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeLoginViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <ChameleonFramework/Chameleon.h>
#import "DiyCodeOauthApiManager.h"

@interface DiyCodeLoginViewController () <CTAPIManagerCallBackDelegate, CTAPIManagerParamSource>
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) DiyCodeOauthApiManager *oauthApiManager;
@end

@implementation DiyCodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.usernameField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginButton];
    
    [self setupLayout];
}

- (void)setupLayout {
    self.usernameField.ct_x = 20;
    self.usernameField.ct_y = 30;
    self.usernameField.ct_width = SCREEN_WIDTH - 40;
    self.usernameField.ct_height = 50;
    
    [self.passwordField fromTheBottom:10 ofView:self.usernameField];
    [self.passwordField widthEqualToView:self.usernameField];
    [self.passwordField heightEqualToView:self.usernameField];
    [self.passwordField leftEqualToView:self.usernameField];
    
    [self.loginButton fromTheBottom:20 ofView:self.passwordField];
    [self.loginButton widthEqualToView:self.passwordField];
    [self.loginButton heightEqualToView:self.passwordField];
    [self.loginButton leftEqualToView:self.passwordField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - method
- (void)loginClicked:(UIButton *)sender {
    [self.oauthApiManager loadData];
}

- (void)saveToken:(NSDictionary *)obj {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:@"User"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager * _Nonnull)manager {
    if (manager == self.oauthApiManager) {
        [self saveToken:manager.response.content];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager * _Nonnull)manager {
    
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *_Nullable)paramsForApi:(CTAPIBaseManager *_Nonnull)manager {
    return @{
             @"client_id":@"3a908f0f",
             @"client_secret":@"5f52a3cb22d1b0e8e7e0d5df5b833d0ab74acdc7103b2aefe30a46a1722eeb87",
             @"grant_type":@"password",
             @"password":@"woshilizhao123",
             @"username":@"827210217"
             };
}

#pragma mark - getters & setters
- (UITextField *)usernameField {
    if (!_usernameField) {
        _usernameField = [[UITextField alloc] init];
        _usernameField.backgroundColor = [UIColor randomFlatColor];
    }
    return _usernameField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.backgroundColor = [UIColor randomFlatColor];
    }
    return _passwordField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor randomFlatColor];
        [_loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (DiyCodeOauthApiManager *)oauthApiManager {
    if (!_oauthApiManager) {
        _oauthApiManager = [[DiyCodeOauthApiManager alloc] init];
        _oauthApiManager.delegate = self;
        _oauthApiManager.paramSource = self;
    }
    return _oauthApiManager;
}

@end
