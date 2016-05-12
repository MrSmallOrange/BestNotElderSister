//
//  ZCTextField.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/7.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTextField.h"
//#import <objc/runtime.h>
#define ZCTextFieldPlaceholderColorKeyPath  @"_placeholderLabel.textColor"

@implementation ZCTextField

//+ (void)initialize
//{
//    unsigned int count = 0;
//    /****       runtime 运行时技术  *****/
//    //拷贝所有成员列表
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0 ; i < count; i ++) {
//        Ivar ivar = *ivars;
//        ivars++;
//        
//        ZCLog(@"%s", ivar_getName(ivar));
//        
//    }
//    
//    
//    //释放头指针
//    free(ivars);
//    
//    
//}

- (void)awakeFromNib
{
    [self setValue:[UIColor grayColor] forKeyPath:ZCTextFieldPlaceholderColorKeyPath];
    
    //设置光标颜色
    self.tintColor = self.textColor;
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:ZCTextFieldPlaceholderColorKeyPath];

    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:ZCTextFieldPlaceholderColorKeyPath];

    return [super resignFirstResponder];
    
}

@end
