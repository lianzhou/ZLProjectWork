//
//  MKBVersionUpdateView.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/19.
//  Copyright © 2018 周连. All rights reserved.
//

#import "MKBVersionUpdateView.h"

@implementation MKBVersionUpdateModel
@end
@interface MKBVersionUpdateView ()
{
    CGFloat descLabelHeight;
}

@property (nonatomic, strong) UIButton * updateBtn;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) ZLLabel * updateDescLabel;//更新描述,支持富文本
@property (nonatomic, strong) UIImageView * mainView;//头部的图片背景
@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) MKBVersionUpdateModel * model;
@end

@implementation MKBVersionUpdateView

- (instancetype)initWithVersionModel:(MKBVersionUpdateModel *)model{
    
    if (self = [super init]) {
        
        self.model = model;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        [self createView];
        
    }
    return self;
}

- (void)createView{
    
    CGFloat _mainViewWidth = SCREEN_WIDTH-60;
    CGFloat _mainViewHeight = _mainViewWidth * 758/630;
    CGFloat _marginY = (SCREEN_HEIGHT -_mainViewHeight)/2- 50;
    _marginY = MAX(_marginY, 60);
    [self addSubview:self.mainView];
    self.mainView.frame = CGRectMake(30, _marginY, _mainViewWidth, _mainViewHeight);
    
    UIView * safeView = [[UIView alloc] init];
    [_mainView addSubview:safeView];
    [safeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(_mainView);
        make.height.mas_equalTo(_mainViewWidth * 240/315);
    }];
    
    UILabel * title = [[UILabel alloc] init];
    title.text = _model.isForcedUpdate ? @"版本过旧" : [NSString stringWithFormat:@"发现新版本 V%@",self.model.versionNumber];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = UIColorHex(0x333333);
    [safeView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(safeView);
        make.height.mas_equalTo(@30);
    }];
    
    [safeView addSubview:self.updateBtn];
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(safeView.mas_bottom).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.centerX.equalTo(safeView);
    }];
    self.updateBtn.layer.cornerRadius = 20.f;
    self.updateBtn.clipsToBounds = YES;
    
    self.scrollView = [[UIScrollView alloc] init];
    
    [safeView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(safeView.mas_left).with.offset(45);
        make.centerX.equalTo(safeView);
        make.top.equalTo(title.mas_bottom);
        make.bottom.equalTo(self.updateBtn.mas_top).with.offset(-10);
    }];
    
    UILabel * scrollTitle = [[UILabel alloc] init];
    scrollTitle.text = _model.isForcedUpdate ? @"新版本涉及重要内容,需更新后使用" :@"";
    scrollTitle.textAlignment = NSTextAlignmentCenter;
    scrollTitle.font = [UIFont systemFontOfSize:14];
    scrollTitle.textColor = UIColorHex(0x333333);
    [self.scrollView addSubview:scrollTitle];
    [scrollTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.scrollView);
        make.height.mas_equalTo(_model.isForcedUpdate ? @25 : @0.01);
    }];
    
    self.updateDescLabel = [[ZLLabel alloc] init];
    self.updateDescLabel.numberOfLines = 0;
    self.updateDescLabel.font =  [UIFont systemFontOfSize:14];
    self.updateDescLabel.textColor = UIColorHex(0x999999);
    self.updateDescLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 150;
    [self.scrollView addSubview:self.updateDescLabel];
    
    descLabelHeight = [ZLLabel preferredSizeWith_MaxWidth:self.updateDescLabel.preferredMaxLayoutWidth with_font:self.updateDescLabel.font with_emojiText:self.model.updateDesc with_edgeInsets:UIEdgeInsetsZero with_maximumNumberOfRows:0].height +10;
    
    if (self.model.isForcedUpdate) {
        descLabelHeight += 40;
    }
    
    [self.updateDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_scrollView.mas_top).with.offset(self.model.isForcedUpdate ? 25 : 0);
        make.left.right.equalTo(_scrollView);
        make.height.mas_equalTo(descLabelHeight);
    }];
    self.updateDescLabel.textString =  self.model.updateDesc;
    
    if (_model.isForcedUpdate == NO) {
        [self addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_mainView.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.centerX.equalTo(_mainView);
        }];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = CGSizeMake(0, descLabelHeight);
    });
}

- (void)_btnAction:(UIButton *)sender{
    
    if (sender.tag ==0) {
        //跳转app store
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", _model.updateUrl]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[ UIApplication sharedApplication] openURL :url];
        }
        
    }else{
        
        [self removeFromSuperview];
    }
}
- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


# pragma mark - lazyload
- (UIButton *)updateBtn{
    
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc] init];
        [_updateBtn setTitle:@"立即升级" forState:0];
        _updateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_updateBtn setBackgroundColor:UIColorHex(0xf5734c)];
        _updateBtn.showsTouchWhenHighlighted = YES;
        _updateBtn.tag = 0;
        [_updateBtn addTarget:self action:@selector(_btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _updateBtn;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@"version_close"] forState:0];
        _cancelBtn.showsTouchWhenHighlighted = YES;
        _cancelBtn.tag = 1;
        [_cancelBtn addTarget:self action:@selector(_btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelBtn;
}

- (UIImageView *)mainView{
    
    if (!_mainView) {
        _mainView = [[UIImageView alloc] init];
        _mainView.image = [UIImage imageNamed:@"transfer_teacher"];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

@end


