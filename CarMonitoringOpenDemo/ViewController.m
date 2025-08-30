//
//  ViewController.m
//  CarMonitoringOpenDemo
//
//  Created by 王恒 on 2022/10/12.
//

#import "ViewController.h"
#import <AWHBPublicBusiness/AWHBPBLoginRouter.h>
#import <AWHBoneRuntime/AWHBoneRuntime.h>
#import <Masonry/Masonry.h>
#import <AWHReportModule/AWHRMAddCarColorView.h>
#import <AWHReportModule/AWHRMAddCarColorModel.h>
#import <YYModel/YYModel.h>
#import "AllFunctionsViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL isCar;

@property (nonatomic, strong) UIButton *userBut;

@property (nonatomic, strong) UIButton *carBut;

@property (nonatomic, strong) UITextField *userTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UITextField *ipTextField;

@property (nonatomic, strong) UITextField *portTextField;

@property (nonatomic, strong) NSString *plateColorId;

@property (nonatomic, strong) NSString *plateColorName;

@property (nonatomic, strong) UIView *plateColorView;

@property (nonatomic, strong) UIButton *plateColorBut;

@property (nonatomic, strong) UIButton *httpBut;

@property (nonatomic, strong) UIButton *httpsBut;

@property (nonatomic, assign) BOOL isHttps;

@property(nonatomic,strong)UIView *bgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    UIButton *userBut = [[UIButton alloc] init];
    [userBut setTitle:@"用户登录" forState:UIControlStateNormal];
    [userBut setTitleColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateNormal];
    [userBut addTarget:self action:@selector(userButAction:) forControlEvents:UIControlEventTouchUpInside];
    self.userBut = userBut;
    [self.view addSubview:userBut];
    [userBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.width.mas_equalTo(kScreenW/2 - 24);
    }];
    
    UIButton *carBut = [[UIButton alloc] init];
    carBut.hidden = YES;
    [carBut setTitle:@"车辆登录" forState:UIControlStateNormal];
    [carBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [carBut addTarget:self action:@selector(carButAction:) forControlEvents:UIControlEventTouchUpInside];
    self.carBut = carBut;
    [self.view addSubview:carBut];
    [carBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.width.mas_equalTo(kScreenW/2 - 24);
    }];
    
    UILabel *userLabel = [[UILabel alloc] init];
    userLabel.text = @"用户";
    userLabel.font = [UIFont systemFontOfSize:18];
    userLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userBut.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.width.mas_lessThanOrEqualTo(60);
        make.height.mas_equalTo(40);
    }];
    
    self.userTextField = [[UITextField alloc] init];
    self.userTextField.placeholder = @"请输入账号";
    self.userTextField.text = @"ys_admin";
    self.userTextField.textAlignment = NSTextAlignmentLeft;
    self.userTextField.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.userTextField];
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userLabel);
        make.left.equalTo(userLabel.mas_right).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTextField.mas_bottom);
        make.left.right.equalTo(self.userTextField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont systemFontOfSize:18];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.width.mas_lessThanOrEqualTo(60);
        make.height.mas_equalTo(40);
    }];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.text = @"123456";
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    self.passwordTextField.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordLabel);
        make.left.equalTo(passwordLabel.mas_right).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom);
        make.left.right.equalTo(self.passwordTextField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *ipLabel = [[UILabel alloc] init];
    ipLabel.text = @"IP地址";
    ipLabel.font = [UIFont systemFontOfSize:18];
    ipLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:ipLabel];
    [ipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.width.mas_lessThanOrEqualTo(60);
        make.height.mas_equalTo(40);
    }];
    
    self.ipTextField = [[UITextField alloc] init];
    self.ipTextField.text = @"106.14.186.44";
    self.ipTextField.placeholder = @"请输入IP地址";
    self.ipTextField.textAlignment = NSTextAlignmentLeft;
    self.ipTextField.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.ipTextField];
    [self.ipTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ipLabel);
        make.left.equalTo(ipLabel.mas_right).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ipTextField.mas_bottom);
        make.left.right.equalTo(self.ipTextField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *portLabel = [[UILabel alloc] init];
    portLabel.text = @"端口";
    portLabel.font = [UIFont systemFontOfSize:18];
    portLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:portLabel];
    [portLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.width.mas_lessThanOrEqualTo(60);
        make.height.mas_equalTo(40);
    }];
    
    self.portTextField = [[UITextField alloc] init];
    self.portTextField.placeholder = @"请输入端口号";
    self.portTextField.text = @"9999";
    self.portTextField.textAlignment = NSTextAlignmentLeft;
    self.portTextField.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.portTextField];
    [self.portTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(portLabel);
        make.left.equalTo(portLabel.mas_right).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:lineView4];
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.portTextField.mas_bottom);
        make.left.right.equalTo(self.portTextField);
        make.height.mas_equalTo(1);
    }];
    
    UIView *plateColorView = [[UIView alloc] init];
    plateColorView.hidden = YES;
    [self.view addSubview:plateColorView];
    self.plateColorView = plateColorView;
    [plateColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView4.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.height.mas_equalTo(41);
    }];
    
    UILabel *plateColorLabel = [[UILabel alloc] init];
    plateColorLabel.text = @"车牌颜色";
    plateColorLabel.font = [UIFont systemFontOfSize:18];
    plateColorLabel.textAlignment = NSTextAlignmentRight;
    [self.plateColorView addSubview:plateColorLabel];
    [plateColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.plateColorView);
        make.height.mas_equalTo(40);
    }];
    
    self.plateColorBut = [[UIButton alloc] init];
    [self.plateColorBut setTitle:@"蓝色" forState:UIControlStateNormal];
    [self.plateColorBut setTitleColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateNormal];
    [self.plateColorBut addTarget:self action:@selector(plateColorButAction) forControlEvents:UIControlEventTouchUpInside];
    [plateColorView addSubview:self.plateColorBut];
    [self.plateColorBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(plateColorLabel);
        make.left.equalTo(plateColorLabel.mas_right).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView5 = [[UIView alloc] init];
    lineView5.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [plateColorView addSubview:lineView5];
    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.plateColorBut.mas_bottom);
        make.left.right.equalTo(self.plateColorBut);
        make.height.mas_equalTo(1);
    }];
    
    
    self.httpBut = [[UIButton alloc] init];
    self.httpBut.clipsToBounds = YES;
    self.httpBut.layer.cornerRadius = 8;
    [self.httpBut setTitle:@"HTTP" forState:UIControlStateNormal];
    [self.httpBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.httpBut setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateSelected];
    [self.httpBut setBackgroundColor:[UIColor colorWithHexString:@"cfcfcf"] forState:UIControlStateNormal];
    [self.httpBut setBackgroundColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateSelected];
    [self.httpBut addTarget:self action:@selector(httpButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.httpBut];
    [self.httpBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView5.mas_bottom).offset(32);
        make.left.equalTo(self.view.mas_left).offset(24);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    self.httpBut.selected = YES;
    
    self.httpsBut = [[UIButton alloc] init];
    self.httpsBut.clipsToBounds = YES;
    self.httpsBut.layer.cornerRadius = 8;
    [self.httpsBut setTitle:@"HTTPS" forState:UIControlStateNormal];
    [self.httpsBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.httpsBut setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateSelected];
    [self.httpsBut setBackgroundColor:[UIColor colorWithHexString:@"cfcfcf"] forState:UIControlStateNormal];
    [self.httpsBut setBackgroundColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateSelected];
    [self.httpsBut addTarget:self action:@selector(httpsButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.httpsBut];
    [self.httpsBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.httpBut.mas_top);
        make.left.equalTo(self.httpBut.mas_right).offset(24);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    
    //登录按钮
    UIButton *landBtn = [[UIButton alloc] init];
    [landBtn setTitle:@"登录" forState:UIControlStateNormal];
    [landBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [landBtn addTarget:self action:@selector(landBtn) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor = [UIColor colorWithHexString:@"3492e9"];
    [self.view addSubview:landBtn];
    [landBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(45);
    }];
    landBtn.layer.masksToBounds = YES;
    landBtn.layer.cornerRadius = 4;
    self.plateColorId = @"1";
    // Do any additional setup after loading the view.
}

- (void)httpButAction
{
    self.isHttps = NO;
    self.httpBut.selected = YES;
    self.httpsBut.selected = NO;
    if (self.isCar) {
        [self carButAction:nil];
    } else {
        [self userButAction:nil];
    }
}

- (void)httpsButAction
{
    self.isHttps = YES;
    self.httpBut.selected = NO;
    self.httpsBut.selected = YES;
    if (self.isCar) {
        self.userTextField.text = @"";
        self.passwordTextField.text = @"";
        self.ipTextField.text = @"";
        self.portTextField.text = @"";
        self.plateColorView.hidden = NO;
        [self.userBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [self.carBut setTitleColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateNormal];
        self.userTextField.placeholder = @"请输入车牌号";
    } else {
        self.userTextField.text = @"";
        self.passwordTextField.text = @"";
        self.plateColorView.hidden = YES;
        self.ipTextField.text = @"";
        self.portTextField.text = @"";
        [self.userBut setTitleColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateNormal];
        [self.carBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        self.userTextField.placeholder = @"请输入账号";
    }
}

- (void)landBtn
{
    if (!self.userTextField.text.length ||
        !self.passwordTextField.text.length ||
        !self.ipTextField.text.length ||
        !self.portTextField.text.length) {
        [self.view makeToast:@"请输入必填参数"];
        return;
    }
    if (self.isCar) {
//        [AWHBPBLoginRouter setupLoginIp:self.ipTextField.text port:self.portTextField.text userId:self.userTextField.text password:self.passwordTextField.text plateColorId:self.plateColorId];
//        [AWHBPBLoginRouter carLoginHudView:self.view callback:^(NSDictionary * _Nonnull requestDic) {
//            
//        }];
    } else {
        [AWHBPBLoginRouter setupLoginIp:self.ipTextField.text port:self.portTextField.text isHttps:self.isHttps userId:self.userTextField.text password:self.passwordTextField.text plateColorId:@""];
        [AWHBPBLoginRouter userLoginHudView:self.view callback:^(NSDictionary * _Nonnull requestDic) {
            
            AllFunctionsViewController *vc = [[AllFunctionsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)userButAction:(UIButton *)sender
{
    self.isCar = NO;
    self.plateColorView.hidden = YES;
    [self.userBut setTitleColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateNormal];
    [self.carBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.userTextField.placeholder = @"请输入账号";
    if (self.isHttps) {
        return;
    }
    self.userTextField.text = @"ys_admin";
    self.passwordTextField.text = @"123456";
    self.ipTextField.text = @"106.14.186.44";
    self.portTextField.text = @"9999";
}

- (void)carButAction:(UIButton *)sender
{
    self.isCar = YES;
    self.plateColorView.hidden = NO;
    [self.userBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.carBut setTitleColor:[UIColor colorWithHexString:@"3791E9"] forState:UIControlStateNormal];
    self.userTextField.placeholder = @"请输入车牌号";
    if (self.isHttps) {
        return;
    }
    self.userTextField.text = @"演示18";
    self.passwordTextField.text = @"123456";
    self.ipTextField.text = @"106.14.186.44";
    self.portTextField.text = @"9999";
}

- (void)plateColorButAction
{
    [AWHBPBLoginRouter plateColorRequest:^(NSArray * _Nonnull plateColorArr) {
        NSMutableArray *plateArr = [NSMutableArray array];
        for (NSDictionary *dic in plateColorArr) {
            AWHRMAddCarColorModel *model = [AWHRMAddCarColorModel yy_modelWithJSON:dic];
            [plateArr addObject:model];
        }
        if (plateArr.count > 0) {
            [self color:plateArr];
        }
    }];
}

//选择颜色
-(void)color:(NSMutableArray *)plateColorArr{
    __weak typeof(self) weakSelf = self;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.bgView.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    AWHRMAddCarColorView *colorView = [[AWHRMAddCarColorView alloc] init];
    [self.bgView addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(scaleFrom750(125));
        make.right.equalTo(self.bgView.mas_right).offset(-scaleFrom750(125));
        make.top.equalTo(self.bgView.mas_top).offset(scaleFrom750(45 + [AWHBRTools getAppTopSpace] * 2));
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-scaleFrom750(34 + [AWHBRTools getAppTopBottomSpace] * 2));
    }];
    [colorView setColorWithArray:plateColorArr selectPlateColorId:@"1"];
    colorView.ReturnSureBtnBlock = ^(NSString *str, NSString *str2) {
        weakSelf.plateColorName = str;
        weakSelf.plateColorId = str2;
        [weakSelf.plateColorBut setTitle:str forState:UIControlStateNormal];
        [weakSelf.bgView removeFromSuperview];
    };
    colorView.closeBlock = ^{
        [weakSelf.bgView removeFromSuperview];
    };
}


@end
