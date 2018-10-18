//
//  MKBLoginInputTextFieldView.h
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/18.
//  Copyright © 2018 周连. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKBLoginInputTextFieldView : UIView
//是否显示右边视图
@property (nonatomic,assign) UITextFieldViewMode  zl_RightViewMode;

//右边视图
@property (nonatomic,strong) UIView               *zl_RightView;

//是否显示左边视图
@property (nonatomic,assign) UITextFieldViewMode  zl_LeftViewMode;

//左边视图
@property (nonatomic,strong) UIView               *zl_LeftView;

//设置TextField的边框样式
@property (nonatomic,assign)  UITextBorderStyle   zl_BorderStyle;

//清空内容按钮的出现时间 默认是不出现的
@property (nonatomic,assign) UITextFieldViewMode  zl_ClearButtonMode;

//是否在开始编辑时清空输入框
@property (nonatomic,assign) BOOL                 zl_ClearsOnBeginEditing;

//内容显示的位置
@property (nonatomic,assign) NSTextAlignment      zl_TextAlignment;

//字体大小 默认大小是12.0f
@property (nonatomic,strong) UIFont               *zl_Font;

//字体颜色 默认字体颜色是黑色
@property (nonatomic,strong) UIColor              *zl_TextColor;

//设置默认内容 默认内容为空
@property (nonatomic,copy) NSString               *zl_placeHolderStr;

//设置线的颜色 默认颜色是黑色
@property (nonatomic,strong) UIColor              *lineColor;

//光线颜色 默认是蓝色
@property (nonatomic,strong) UIColor              *zl_TintColor;

//设置键盘的样式 默认UIKeyboardTypeDefault
@property (nonatomic,assign) UIKeyboardType       zl_KeyboardType;

//密码是否明文显示 默认是明文显示   NO
@property (nonatomic,assign) BOOL                 zl_SecureTextEntry;

//输入框
@property (nonatomic,strong) ZLTextField          *zl_TextField;

@property (nonatomic,copy) NSString               *zl_TextFieldStr;

//线距左边的距离
@property (nonatomic, assign) CGFloat             lineLeftWidth;

//右边视图的大小
@property (nonatomic, assign) CGFloat             rightWidth;

//右边视图
@property (nonatomic, strong) UIView              *zl_ButtonView;



//成为第一响应者
- (void)zl_BecomeFirstResponder;

//取消成为第一响应者
- (void)zl_ResignFirstResponder;
@end
