//
//  MKBLoginViewController.m
//  Project(MKB)
//
//  Created by lianzhou on 2018/10/17.
//  Copyright © 2018 lianzhou. All rights reserved.
//

#import "MKBLoginViewController.h"
#import "MKBUserLoginModel.h"
#import "MKBLoginInputTextFieldView.h"
#import "MKBFindPwdViewController.h"
#import "MKBLoginServiceManager.h"
#import "MKBUserManager.h"
@interface MKBLoginViewController()<UITextFieldDelegate,YYTextKeyboardObserver>

//头部标题
@property (nonatomic, strong) UILabel             *titleNameLabel;

//手机号/ID号
@property (nonatomic,strong) MKBLoginInputTextFieldView *numberTextFieldView;

//密码
@property (nonatomic,strong) MKBLoginInputTextFieldView *passwordTextFieldView;

//一键删除按钮
@property (nonatomic, strong) UIButton            *clearButton;

//是否显示明文密码
@property (nonatomic,strong) UIButton             *showButton;

//登录按钮
@property (nonatomic,strong) UIButton             *loginButton;

//忘记密码按钮
@property (nonatomic,strong) UIButton             *forgetButton;

//协议名称
@property (nonatomic, strong) UILabel             *protocolLabel;

//可点击的按钮
@property (nonatomic, strong) UIButton            *protocolButton;

//是否同意协议
@property (nonatomic, assign) BOOL                isAgree;

//是否展示
@property (nonatomic, assign) BOOL           isShow;

//当账号和密码不为空时是否自动登录
@property (nonatomic, assign) BOOL           isAutomaticLogin;

//接收输入的密码
@property (nonatomic, copy) NSString         *receiveStr;

//接收输入的账号
@property (nonatomic, copy) NSString         *accountReceiveStr;

//覆盖页面
@property (nonatomic, strong) UIImageView    *maskImageView;

//底部横线
@property (nonatomic, strong) UIView               *numberLine;

//底部横线
@property (nonatomic, strong) UIView               *pwdLine;

//当前数据'
@property (nonatomic, strong) MKBUserDataModel *contentModel;


@end

@implementation MKBLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    if (delegate.updateModel && delegate.updateModel.isForcedUpdate) {
    //        if (delegate.hasShowNormalUpdateView == NO) {
    //            delegate.hasShowNormalUpdateView = YES;
    //            ZLVersionUpdateView * updateView = [[ZLVersionUpdateView alloc] initWithVersionModel:delegate.updateModel];
    //            [updateView show];
    //        }
    //
    //        return;
    //    }
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self determinesWhetherTheLoginIsAutomatic];
    
    //收起输入框
    _isShow = YES;
    
    
    NSString *phoneNumStr = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ACCOUNT];
    NSString *passWordStr = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PASSWORD];
    if(!ZLStringIsNull(phoneNumStr)){
        _numberTextFieldView.zl_TextField.text = ZLIFISNULL(phoneNumStr);
    }
    if(!ZLStringIsNull(passWordStr)){
        _passwordTextFieldView.zl_TextField.text = ZLIFISNULL(passWordStr);
    }
    if (!ZLStringIsNull(phoneNumStr) && !ZLStringIsNull(passWordStr)) {
        _loginButton.userInteractionEnabled = YES;
        _loginButton.backgroundColor = UIColorHex(0x0093e8);
        if (_isAutomaticLogin) {
            BOOL isAuto = NO;
            if (!_isAuto_login) {
                [self createMaskImageView];
                isAuto = YES;
            }else{
                isAuto = NO;
            }
            [self loginOrAutoLogin:isAuto];
        }
    }
}

//覆盖图片
- (void)createMaskImageView {
    
    _maskImageView = [[UIImageView alloc] init];
    UIImage *placeImage = [ZLSystemUtils getTheLaunchImage];
    _maskImageView.image = placeImage;
    _maskImageView.userInteractionEnabled = YES;
    [self.view addSubview:_maskImageView];
    
    [_maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).mas_offset(UIEdgeInsetsZero);
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
//判断是否自动登录
- (void)determinesWhetherTheLoginIsAutomatic {
    
    //是否自动登录
    NSString *autoLogin = [ZLUserDefaults objectForKey:AUTOMATIC_LOGIN];
    if (ZLStringIsNull(autoLogin)) {
        _isAutomaticLogin = NO;
        // [ZLUserDataServiceManager createDataBaseTable];
        [ZLUserDefaults setObject:@"0" forKey:AUTOMATIC_LOGIN];
    }else{
        //0:不自动登录 1:自动登录
        if ([ZLIFISNULL(autoLogin) isEqualToString:@"0"]) {
            _isAutomaticLogin = NO;
        }else if([ZLIFISNULL(autoLogin) isEqualToString:@"1"]){
            _isAutomaticLogin = YES;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorHex(0xffffff);
    
    [self requestDataSource];
    
    _isAgree = YES;
    
    [self createLoginPageSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditTextField:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditTextField:) name:UITextFieldTextDidEndEditingNotification object:nil];
    //    //接受通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMaterials) name:zl_NoticeMethods[ZLNotificationTypeChangeCurrentSchoolInformation] object:nil];
    
}
#pragma mark -DataSource
//登录用户信息
- (void)requestDataSource {
    
    //    [ZLUserDataServiceManager queryDataBaseTableWithAccountParams:nil withSuccessBlock:^(NSArray *dataArray) {
    //
    //        NSArray *array = [dataArray sortedArrayUsingComparator:^NSComparisonResult(ZLUserDataModel *obj1, ZLUserDataModel *obj2) {
    //            return [ZLIFISNULL(obj2.loginTime) compare:obj1.loginTime];
    //        }];
    //
    //        _dataArrayM = [NSMutableArray arrayWithArray:array];
    //        NSLog(@"_dataArrayM ---------- %@",_dataArrayM);
    //
    //    } withFaileBlock:^(NSString *errorStr) {
    //        [_dataArrayM removeAllObjects];
    //        NSLog(@"errorStr ---------- %@",errorStr);
    //    }];
}
#pragma mark -Create UI
//创建登录界面UI
- (void)createLoginPageSubViews {
    
    //头部标题
    _titleNameLabel = [[UILabel alloc] init];
    _titleNameLabel.text = @"登录";
    _titleNameLabel.font = ZL_KDefaultBoldFont(30);
    _titleNameLabel.textColor = UIColorHex(0x333333);
    [self.view addSubview:_titleNameLabel];
    
    
    //账号
    _numberTextFieldView = [[MKBLoginInputTextFieldView alloc] init];
    _numberTextFieldView.zl_Font = [UIFont systemFontOfSize:19.0f];
    _numberTextFieldView.zl_TextColor = UIColorHex(0x333333);
    _numberTextFieldView.zl_placeHolderStr = @"请输入手机号或ID号";
    _numberTextFieldView.zl_Font = [UIFont systemFontOfSize:16.0f];
    _numberTextFieldView.zl_KeyboardType = UIKeyboardTypeNumberPad;
    _numberTextFieldView.zl_TextField.delegate = self;
    _numberTextFieldView.zl_ClearButtonMode = UITextFieldViewModeWhileEditing;
    _numberTextFieldView.zl_TintColor = UIColorHex(0x3977b3);
    //    _numberTextFieldView.rightWidth = 30;
    //    _numberTextFieldView.layer.cornerRadius = 22.0f;
    //    _numberTextFieldView.layer.borderWidth = 0.5;
    //    _numberTextFieldView.layer.borderColor = UIColorRGBA(204,204,204, 0.5).CGColor;
    [self.view addSubview:_numberTextFieldView];
    [_numberTextFieldView.zl_TextField addTarget:self action:@selector(determineWhetherTheLoginButtonClicked:) forControlEvents:UIControlEventEditingChanged];
    
    //密码底部横线
    _numberLine=[[UIView alloc] init];
    _numberLine.backgroundColor=UIColorHex(0xEBEBEB);
    [self.view addSubview:_numberLine];
    
    //    //账号头像
    //    UIButton *accountImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    //    accountImageView.frame = CGRectMake(0, 0, 26, 16);
    //    accountImageView.imageRect = CGRectMake(0, 0, 16, 16);
    //    accountImageView.userInteractionEnabled = NO;
    //    [accountImageView setImage:[UIImage imageNamed:@"wjf_login_account_number"] forState:UIControlStateNormal];
    //    _numberTextFieldView.zl_LeftViewMode = UITextFieldViewModeAlways;
    //    _numberTextFieldView.zl_LeftView = accountImageView;
    
    
    //密码
    _passwordTextFieldView = [[MKBLoginInputTextFieldView alloc] init];
    _passwordTextFieldView.zl_TextColor = UIColorHex(0x333333);
    _passwordTextFieldView.zl_placeHolderStr = @"请输入密码";
    _passwordTextFieldView.zl_KeyboardType = UIKeyboardTypeASCIICapable;
    _passwordTextFieldView.zl_ClearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextFieldView.zl_TextField.delegate = self;
    _passwordTextFieldView.zl_Font = [UIFont systemFontOfSize:16.0f];
    _passwordTextFieldView.zl_TintColor = UIColorHex(0x3977b3);
    _passwordTextFieldView.rightWidth = 30;
    _passwordTextFieldView.zl_SecureTextEntry = YES;
    //    _passwordTextFieldView.layer.cornerRadius = 22.0f;
    //    _passwordTextFieldView.layer.borderWidth = 0.5;
    //    _passwordTextFieldView.layer.borderColor = UIColorRGBA(204,204,204, 0.5).CGColor;
    [self.view addSubview:_passwordTextFieldView];
    [_passwordTextFieldView.zl_TextField addTarget:self action:@selector(determineWhetherTheLoginButtonClicked:) forControlEvents:UIControlEventEditingChanged];
    
    //    UIButton *pwImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    //    pwImageView.frame = CGRectMake(0, 0, 26, 16);
    //    pwImageView.imageRect = CGRectMake(0, 0, 16, 16);
    //    pwImageView.userInteractionEnabled = NO;
    //    [pwImageView setImage:[UIImage imageNamed:@"wjf_login_account_password"] forState:UIControlStateNormal];
    //    _passwordTextFieldView.zl_LeftViewMode = UITextFieldViewModeAlways;
    //    _passwordTextFieldView.zl_LeftView = pwImageView;
    
    
    //密码底部横线
    _pwdLine=[[UIView alloc] init];
    _pwdLine.backgroundColor=UIColorHex(0xEBEBEB);
    [self.view addSubview:_pwdLine];
    
    //是否清空数据
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton setImage:[UIImage imageNamed:@"wjf_login_close_01"] forState:UIControlStateNormal];
    _clearButton.frame = CGRectMake(0, 0, 30, 30);
    _clearButton.hidden = YES;
    [_clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _passwordTextFieldView.zl_RightViewMode = UITextFieldViewModeAlways;
    _passwordTextFieldView.zl_RightView = _clearButton;
    
    //是否显示明文密码
    _showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showButton setImage:[UIImage imageNamed:@"wjf_denglu_11"] forState:UIControlStateNormal];
    [_showButton addTarget:self action:@selector(displaysThePlaintextPassword:) forControlEvents:UIControlEventTouchUpInside];
    _passwordTextFieldView.zl_ButtonView = _showButton;
    
    
    //登录按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.userInteractionEnabled = NO;
    _loginButton.layer.cornerRadius = 22.0f;
    _loginButton.backgroundColor = UIColorRGBA(0,147,232,0.5);
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    //忘记密码按钮
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_forgetButton setTitleColor:UIColorHex(0x3977B3) forState:UIControlStateNormal];
    _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_forgetButton addTarget:self action:@selector(forgetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetButton];
    
    //协议名称
    _protocolLabel = [[UILabel alloc] init];
    _protocolLabel.font = [UIFont systemFontOfSize:13.0f];
    _protocolLabel.textColor = UIColorHex(0xCCCCCC);
    _protocolLabel.textAlignment = NSTextAlignmentRight;
    NSString *textStr = @"登录即代表您已同意我们的";
    _protocolLabel.text = ZLIFISNULL(textStr);
    [self.view addSubview:_protocolLabel];
    
    //协议可点击的部分
    _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _protocolButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _protocolButton.titleRect = CGRectMake(0, 0, 100, 15);
    _protocolButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    NSAttributedString *titleSttri = [[NSAttributedString alloc] initWithString:@"服务协议" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSForegroundColorAttributeName:UIColorHex(0x3977B3)}];
    [_protocolButton setAttributedTitle:titleSttri forState:UIControlStateNormal];
    [self.view addSubview:_protocolButton];
    [_protocolButton addTarget:self action:@selector(protocolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    //图标
    CGFloat barYH = [ZLSystemUtils obtainStatusHeight] + 44;
    
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(barYH + 30);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-25);
        make.height.mas_equalTo(37);
    }];
    
    //账号输入框
    [self.numberTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.titleNameLabel.mas_bottom).mas_offset(30);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(44);
    }];
    
    //phoneLine
    [_numberLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numberTextFieldView.mas_centerY).mas_offset(21.5);
        make.left.mas_equalTo(self.numberTextFieldView.mas_left);
        make.width.mas_equalTo(self.numberTextFieldView);
        make.height.mas_equalTo(@1);
    }];
    
    _numberTextFieldView.rightWidth = 0;
    
    
    //密码输入框
    [_passwordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.numberTextFieldView.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(44);
    }];
    
    //codeLine
    [_pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTextFieldView.mas_centerY).mas_offset(21.5);
        make.left.mas_equalTo(self.passwordTextFieldView.mas_left);
        make.width.mas_equalTo(self.passwordTextFieldView);
        make.height.mas_equalTo(@1);
    }];
    
    [_showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTextFieldView.mas_centerY).mas_offset(0);
        make.right.mas_equalTo(self.passwordTextFieldView.mas_right).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //忘记密码
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-25);
        make.top.mas_equalTo(self.passwordTextFieldView.mas_bottom).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(110, 20));
    }];
    
    //登录按钮
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.forgetButton.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(44);
    }];
    
    
    
    
    CGFloat tabBarH = 0;
    if (ZL_IPHONE_X) {
        tabBarH = 34;
    }else{
        tabBarH = 0;
    }
    
    //协议名称
    [_protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset((kScreenWidth - 190 - 100) / 2.0);
        make.size.mas_equalTo(CGSizeMake(190, 15));
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(15);
    }];
    
    //协议可点击的位置
    [_protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_protocolLabel.mas_right).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 15));
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(15);
    }];
}


#pragma mark -UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName withObject:(id)obj withUserInfo:(id)userInfo
{
    SEL action = NSSelectorFromString(eventName);
    NSMutableArray *array = [NSMutableArray array];
    if (obj) {
        [array addObject:obj];
    }
    if (userInfo) {
        [array addObject:userInfo];
    }
    [self performSelector:action withObjects:array];
}


//清空本地存储的账号密码
- (void)clearEmptyLocalStoreAccountPassword {
    
    [ZLUserDefaults setObject:@"" forKey:LOGIN_ACCOUNT];
    [ZLUserDefaults setObject:@"" forKey:LOGIN_PASSWORD];
    
    _numberTextFieldView.zl_TextField.text = nil;
    _passwordTextFieldView.zl_TextField.text = nil;
}
#pragma mark -Click Method
//是否清空输入框的内容
- (void)clearButtonClick:(UIButton *)button {
    
    _passwordTextFieldView.zl_TextField.text = nil;
    _clearButton.hidden = YES;
    [ZLUserDefaults setObject:@"" forKey:LOGIN_PASSWORD];
}

//判断登录按钮是否能点击
- (void)determineWhetherTheLoginButtonClicked:(ZLTextField *)textField {
    
    if ([_numberTextFieldView.zl_TextField.text length] >= 6) {
        if ([_passwordTextFieldView.zl_TextField.text length] > 5) {
            _loginButton.userInteractionEnabled = YES;
            _loginButton.backgroundColor = UIColorHex(0x0093e8);
        }else{
            _loginButton.userInteractionEnabled = NO;
            _loginButton.backgroundColor = UIColorRGBA(0,147,232,0.5);
        }
    }else{
        _loginButton.userInteractionEnabled = NO;
        _loginButton.backgroundColor = UIColorRGBA(0,147,232,0.5);
    }
    
}
//是否显示明文密码
- (void)displaysThePlaintextPassword:(UIButton *)button {
    
    UIImage *showImage = nil;
    if (!_passwordTextFieldView.zl_TextField.secureTextEntry) {
        showImage = [UIImage imageNamed:@"wjf_denglu_11"];
    }else{
        showImage = [UIImage imageNamed:@"wjf_denglu_12_11"];
    }
    [_showButton setImage:showImage forState:UIControlStateNormal];
    _passwordTextFieldView.zl_SecureTextEntry = ! _passwordTextFieldView.zl_SecureTextEntry;
}

//协议点击查看
- (void)protocolButtonClick:(UIButton *)button {
    
    //    ZLWebViewController *webViewController = [[ZLWebViewController alloc] init];
    //    ZLWebDataContentModel *webContentModel = [[ZLWebDataContentModel alloc] init];
    //    webContentModel.articleHtmlStr = LOGIN_REGISTERTEACH;
    //    webContentModel.articleNameStr = @"服务协议";
    //    webContentModel.pageTitleStr = @"服务协议";
    //    webContentModel.webPageDisplayType = ZLWebPageDisplayTypeNormal;
    //    webViewController.contentModel = webContentModel;
    //    [self.navigationController pushViewController:webViewController animated:YES];
}

//登录按钮
- (void)loginButtonClick:(UIButton *)button {
    
    [self.view endEditing:YES];
    
    [self loginOrAutoLogin:NO];
    
}

- (void)loginOrAutoLogin:(BOOL)isAutoLogin {
    
    //收起输入框
    _isShow = YES;
    
    
    NSString *phoneStr = _numberTextFieldView.zl_TextField.text;
    NSString *passwordStr = _passwordTextFieldView.zl_TextField.text;
    if ([phoneStr length] == 0 || phoneStr == nil) {
        [ZLAlertHUD showTipTitle:@"请输入的手机号或账号"];
        return;
    }
    //    if([phoneStr length] == 11){
    //        if (!ZLStringIsMobilePhone(phoneStr)) {
    //            [ZLAlertHUD showTipTitle:@"输入的手机号不正确"];
    //            return;
    //        }
    //    }
    
    if (!ZLStringCharNumOnly(passwordStr)) {
        [ZLAlertHUD showTipTitle:@"输入的密码不符合要求"];
        return;
    }
    
    [ZLUserDefaults setObject:ZLIFISNULL(phoneStr) forKey:LOGIN_ACCOUNT];
    
    [ZLUserDefaults setObject:ZLIFISNULL(passwordStr) forKey:LOGIN_PASSWORD];
      [self enterMainUI];
    return;
    if (!isAutoLogin) {
        _loginButton.userInteractionEnabled = NO;
        [ZLAlertHUD showHUDTitle:@"加载中..." toView:self.view];
    }
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:ZLIFISNULL(phoneStr) forKey:@"account"];
    [paramsDic setObject:ZLIFISNULL(passwordStr) forKey:@"password"];
    
    //    NSString *deviceType = [ZLSystemUtils getMyDeviceAllInfo];
    //     [paramsDic setObject:ZLIFISNULL(deviceType) forKey:@"deviceType"];
    
    @weakify(self)
    [MKBLoginServiceManager requestLogin:paramsDic withSucess:^(MKBUserLoginModel *loginModel) {
        @strongify(self)
        [ZLAlertHUD hideHUD:self.view];
        
        [ZLUserDefaults setObject:@"1" forKey:AUTOMATIC_LOGIN];
        
        
        [_maskImageView removeFromSuperview];
        
        [MKBUserManager shareInstance].userModel = loginModel.content;
        
        MKBUserDataModel *contentModel = loginModel.content;
        self.contentModel=contentModel;
        self.loginButton.userInteractionEnabled = YES;
        
        //判断是否手动登陆
        if (self.isAuto_login) {
            
            //这是手动登录
            [ZLDataConfig set:ADVERT_IS_MOTION_LONGIN boolValue:NO];
        }else {
            
            if (!isAutoLogin) {
                
                //这是手动登录
                [ZLDataConfig set:ADVERT_IS_MOTION_LONGIN boolValue:NO];
            }else {
                
                //这是自动登录
                [ZLDataConfig set:ADVERT_IS_MOTION_LONGIN boolValue:YES];
            }
        }
        [self enterMainUI];
        //        [self checkAllAddDefaultTextBoolWithBlock:^(BOOL isSuccess) {
        //            if (isSuccess) {
        //                [self enterMainUI];
        //
        //                //登陆成功之后
        //                if ([ZLIFISNULL(contentModel.isFirstLogin) isEqualToString:@"1"]) {
        //                    [self firstLoginAndResetPassword];
        //                }
        //            }
        //            else
        //            {
        //                ZLTeacherAddMaterialViewController *materialVC=[[ZLTeacherAddMaterialViewController alloc] init];
        //                [self.navigationController pushViewController:materialVC animated:YES];
        //
        //                //                ZLAppDelegate *appDelegate = ((ZLAppDelegate *)[[UIApplication sharedApplication] delegate]);
        //                //                ZLBaseTabBarController *tabBarController = [[ZLBaseTabBarController alloc] init];
        //                //                [appDelegate.window setRootViewController:tabBarController];
        //
        //
        //            }
        //        }];
        //
        
    } withFailure:^(NSString *errorStr) {
        @strongify(self)
        [_maskImageView removeFromSuperview];
        
        self.loginButton.userInteractionEnabled = YES;
        [ZLAlertHUD hideHUD:self.view];
        [ZLAlertHUD showTipTitle:ZLStringIsNull(errorStr) ? @"登录失败":ZLIFISNULL(errorStr)];
        //        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:LOGIN_PASSWORD];
        [ZLUserDefaults setObject:@"0" forKey:AUTOMATIC_LOGIN];
    }];
    
}


//如果是第一次登陆则跳转重置密码界面
- (void)firstLoginAndResetPassword {
    
    //    ZLAppDelegate *appDelegate = ((ZLAppDelegate *)[[UIApplication sharedApplication] delegate]);
    //    UIViewController *currentCtrl = appDelegate.window.rootViewController;
    //    ZLFindPassWordViewController *findPassWordViewController = [[ZLFindPassWordViewController alloc] init];
    //    findPassWordViewController.titleNameStr = @"为了您的账号安全，请重置密码";
    //    findPassWordViewController.servicePasswordType = ZLPageServicePasswordTypeResetPassword;
    //    [currentCtrl presentViewController:findPassWordViewController animated:YES completion:^{
    //
    //    }];
}
//登陆成功后的UI界面
- (void)enterMainUI {
    
    ZLAppDelegate *appDelegate = ((ZLAppDelegate *)[[UIApplication sharedApplication] delegate]);
    ZLBaseTabBarController *tabBarController = [[ZLBaseTabBarController alloc] init];
    [appDelegate.window setRootViewController:tabBarController];
}



//忘记密码
- (void)forgetButtonClick:(UIButton *)button {
    
    [self.view endEditing:YES];
    
    //收起输入框
    _isShow = YES;
    
    
    MKBFindPwdViewController *forgetViewCtrl = [[MKBFindPwdViewController alloc] init];
    forgetViewCtrl.serviceType = ZLPageSerivceTypeFindPassWord;
    [self.navigationController pushViewController:forgetViewCtrl animated:YES];
}
#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    NSString *contentStr = ZLIFISNULL(_numberTextFieldView.zl_TextField.text);
    
    if (textField == _passwordTextFieldView.zl_TextField) {
        
        if (!ZLStringIsNull(contentStr)) {
            _clearButton.hidden = NO;
        }else{
            _clearButton.hidden = YES;
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == _passwordTextFieldView.zl_TextField) {
        _clearButton.hidden = YES;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _passwordTextFieldView.zl_TextField) {
        if ((textField.text.length + string.length) > 16) {
            [textField resignFirstResponder];
            [ZLAlertHUD showTipTitle:@"输入的密码不能超过16位"];
            return NO;
        }
    }else if (textField == _numberTextFieldView.zl_TextField){
        if ((textField.text.length + string.length) > 11) {
            [textField resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

#pragma mark -Notification
- (void)textFieldChange:(NSNotification *)notifi {
    
    ZLTextField *textField = (ZLTextField *)notifi.object;
    if (textField == self.passwordTextFieldView.zl_TextField) {
        if ([textField.text length] > [_receiveStr length]) {
            if (!ZLStringCharNumOnly(textField.text)) {
                textField.text = _receiveStr;
            }else{
                _receiveStr = textField.text;
            }
        }else{
            _receiveStr = textField.text;
        }
        if (!ZLStringIsNull(_receiveStr)) {
            _clearButton.hidden = NO;
        }else{
            _clearButton.hidden = YES;
        }
        NSLog(@"textField ------------ %@",textField.text);
    }else if(textField == self.numberTextFieldView.zl_TextField){
        if ([textField.text length] > [_accountReceiveStr length]) {
            if (!ZLStringNumOnly(textField.text)) {
                textField.text = _accountReceiveStr;
            }else{
                _accountReceiveStr = textField.text;
            }
        }else{
            _accountReceiveStr = textField.text;
        }
    }
    //收起输入框
    _isShow = YES;
    
    [self determineWhetherTheLoginButtonClicked:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    //收起输入框
    _isShow = YES;
    
}

//开始编辑
- (void)beginEditTextField:(NSNotification *)noti {
    
    ZLTextField *textField = noti.object;
    //收起输入框
    _isShow = YES;
    
    if (textField == _numberTextFieldView.zl_TextField) {
        _numberTextFieldView.layer.borderColor = UIColorRGBA(51,51,51, 0.5).CGColor;
        _passwordTextFieldView.layer.borderColor = UIColorRGBA(204,204,204, 0.5).CGColor;
    }else if (textField == _passwordTextFieldView.zl_TextField){
        _numberTextFieldView.layer.borderColor = UIColorRGBA(204,204,204, 0.5).CGColor;
        _passwordTextFieldView.layer.borderColor = UIColorRGBA(51,51,51, 0.5).CGColor;
    }
}

//结束编辑
- (void)endEditTextField:(NSNotification *)noti {
    
    ZLTextField *textField = noti.object;
    if (textField == _numberTextFieldView.zl_TextField) {
        _numberTextFieldView.layer.borderColor = UIColorRGBA(204,204,204, 0.5).CGColor;
    }else if (textField == _passwordTextFieldView.zl_TextField){
        _passwordTextFieldView.layer.borderColor = UIColorRGBA(204,204,204, 0.5).CGColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
