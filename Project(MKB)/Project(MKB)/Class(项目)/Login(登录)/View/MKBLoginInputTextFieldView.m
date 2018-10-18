//
//  MKBLoginInputTextFieldView.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/18.
//  Copyright © 2018 周连. All rights reserved.
//

#import "MKBLoginInputTextFieldView.h"
@interface MKBLoginInputTextFieldView ()

@property (nonatomic, strong) UIView *lineView;

@end
@implementation MKBLoginInputTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self defaultSettingContent];
        
        [self createSubView];
    }
    return self;
}
//默认属性设置
- (void)defaultSettingContent {
    
    //是否显示右边视图
    _zl_RightViewMode = UITextFieldViewModeNever;
    
    //是否显示左边视图
    _zl_LeftViewMode = UITextFieldViewModeNever;
    
    //设置TextField的边框样式
    _zl_BorderStyle = UITextBorderStyleNone;
    
    //是否在开始编辑时清空输入框
    _zl_ClearsOnBeginEditing = NO;
    
    //内容显示的位置
    _zl_TextAlignment = NSTextAlignmentLeft;
    
    //字体大小
    _zl_Font = [UIFont systemFontOfSize:12.0f];
    
    //字体颜色
    _zl_TextColor = [UIColor blackColor];
    
    //设置默认内容
    
    //设置线的颜色
    _lineColor = [UIColor blackColor];
    
    //光线颜色 默认是蓝色
    _zl_TintColor = [UIColor blueColor];
    
    //清空内容按钮的出现时间 默认是不出现的
    _zl_ClearButtonMode = UITextFieldViewModeNever;
    
    //设置键盘的样式 默认UIKeyboardTypeDefault
    _zl_KeyboardType = UIKeyboardTypeDefault;
    
}
//是否显示右边视图
- (void)setZl_RightViewMode:(UITextFieldViewMode)zl_RightViewMode {
    
    _zl_RightViewMode = zl_RightViewMode;
    _zl_TextField.rightViewMode = _zl_RightViewMode;
}

//右边视图
- (void)setZl_RightView:(UIView *)zl_RightView {
    
    _zl_RightView = zl_RightView;
    _zl_TextField.rightView = _zl_RightView;
}
//是否显示左边视图
- (void)setZl_LeftViewMode:(UITextFieldViewMode)zl_LeftViewMode {
    
    _zl_LeftViewMode = zl_LeftViewMode;
    _zl_TextField.leftViewMode = _zl_LeftViewMode;
}
//左边视图
- (void)setZl_LeftView:(UIView *)zl_LeftView {
    
    _zl_LeftView = zl_LeftView;
    _zl_TextField.leftView = _zl_LeftView;
}
//设置TextField的边框样式
- (void)setZl_BorderStyle:(UITextBorderStyle)zl_BorderStyle {
    
    _zl_BorderStyle = zl_BorderStyle;
    _zl_TextField.borderStyle = _zl_BorderStyle;
}
//是否在开始编辑时清空输入框
- (void)setZl_ClearsOnBeginEditing:(BOOL)zl_ClearsOnBeginEditing {
    
    _zl_ClearsOnBeginEditing = zl_ClearsOnBeginEditing;
    _zl_TextField.clearsOnBeginEditing = _zl_ClearsOnBeginEditing;
}
//内容显示的位置
- (void)setZl_TextAlignment:(NSTextAlignment)zl_TextAlignment {
    
    _zl_TextAlignment = zl_TextAlignment;
    _zl_TextField.textAlignment = _zl_TextAlignment;
}
//字体大小
- (void)setZl_Font:(UIFont *)zl_Font {
    
    _zl_Font = zl_Font;
    _zl_TextField.font = zl_Font;
}
//字体颜色
- (void)setZl_TextColor:(UIColor *)zl_TextColor {
    
    _zl_TextColor = zl_TextColor;
    _zl_TextField.textColor = _zl_TextColor;
}
//设置默认内容
- (void)setZl_placeHolderStr:(NSString *)zl_placeHolderStr {
    
    _zl_placeHolderStr = zl_placeHolderStr;
    _zl_TextField.placeholder = _zl_placeHolderStr;
}
//设置线的颜色
- (void)setLineColor:(UIColor *)lineColor {
    
    _lineColor = lineColor;
    _lineView.backgroundColor = _lineColor;
}
//光线颜色 默认是蓝色
- (void)setZl_TintColor:(UIColor *)zl_TintColor {
    
    _zl_TintColor = zl_TintColor;
    _zl_TextField.tintColor = _zl_TintColor;
}
//清空内容按钮的出现时间 默认是不出现的
- (void)setZl_ClearButtonMode:(UITextFieldViewMode)zl_ClearButtonMode {
    
    _zl_ClearButtonMode = zl_ClearButtonMode;
    _zl_TextField.clearButtonMode = _zl_ClearButtonMode;
}
//设置键盘的样式 默认UIKeyboardTypeDefault
- (void)setZl_KeyboardType:(UIKeyboardType)zl_KeyboardType {
    
    _zl_KeyboardType = zl_KeyboardType;
    _zl_TextField.keyboardType = _zl_KeyboardType;
}
//密码是否明文显示 默认是明文显示   NO
- (void)setZl_SecureTextEntry:(BOOL)zl_SecureTextEntry {
    
    _zl_SecureTextEntry = zl_SecureTextEntry;
    _zl_TextField.secureTextEntry = _zl_SecureTextEntry;
}
//右边视图
- (void)setZl_ButtonView:(UIView *)zl_ButtonView {
    
    _zl_ButtonView = zl_ButtonView;
    if (_zl_ButtonView) {
        [self addSubview:_zl_ButtonView];
        
    }
}
//右边视图的宽度
- (void)setRightWidth:(CGFloat)rightWidth {
    
    _rightWidth = rightWidth;
    
    [_zl_TextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(- _rightWidth - 20);
    }];
}
- (void)setLineLeftWidth:(CGFloat)lineLeftWidth {
    
    _lineLeftWidth = lineLeftWidth;
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(_lineLeftWidth);
    }];
}
//创建子视图
- (void)createSubView {
    
    _zl_TextField = [[ZLTextField alloc] init];
    _zl_TextField.placeholder = _zl_placeHolderStr;
    _zl_TextField.textColor = _zl_TextColor;
    _zl_TextField.font = _zl_Font;
    _zl_TextField.borderStyle = _zl_BorderStyle;
    _zl_TextField.tintColor = _zl_TintColor;
    _zl_TextField.clearsOnBeginEditing = _zl_ClearsOnBeginEditing;
    [self addSubview:_zl_TextField];
    
    //    _lineView = [[UIView alloc] init];
    //    _lineView.backgroundColor = _lineColor;
    //    [self addSubview:_lineView];
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    [_zl_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(0);
        make.top.mas_equalTo(self.mas_top).mas_offset(5);
        make.right.mas_equalTo(self.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
    }];
    
    //    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.mas_left).mas_offset(0);
    //        make.top.mas_equalTo(_zl_TextField.mas_bottom).mas_offset(4.5);
    //        make.right.mas_equalTo(self.mas_right).mas_offset(0);
    //        make.height.mas_equalTo(0.5);
    //    }];
}
#pragma mark -UITextFieldDelegate
//成为第一响应者
- (void)zl_BecomeFirstResponder {
    
    [_zl_TextField becomeFirstResponder];
}
//取消成为第一响应者
- (void)zl_ResignFirstResponder
{
    [_zl_TextField resignFirstResponder];
}
- (void)setZl_TextFieldStr:(NSString *)zl_TextFieldStr
{
    _zl_TextFieldStr = zl_TextFieldStr;
    _zl_TextField.text = _zl_TextFieldStr;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
