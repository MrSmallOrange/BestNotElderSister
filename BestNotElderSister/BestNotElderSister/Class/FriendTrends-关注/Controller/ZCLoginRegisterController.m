//
//  ZCLoginRegisterController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/5.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCLoginRegisterController.h"

@interface ZCLoginRegisterController ()
/** 登录框距离父控件左边的间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation ZCLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = - self.view.width;
        [sender setTitle:@"已有账号?"forState:UIControlStateNormal];
    }else{
        self.loginViewLeftMargin.constant = 0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

//当前控制器状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;//白色
}

@end
