//
//  AllFunctionsViewController.m
//  CarMonitoringOpenDemo
//
//  Created by 王恒 on 2022/10/13.
//

#import "AllFunctionsViewController.h"
#import "CollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <AWHBoneRuntime/AWHBoneRuntime.h>
#import <AWHBBasicBusiness/AWHBBasicBusiness.h>
#import <AWHBNetworkRequest/AWHBNetworkRequest.h>
#import <MJExtension/MJExtension.h>
#import "AllHeaderCollectionReusableView.h"
#import <AWHBoneResources/AWHBoneResources.h>
#import <AWHBPublicBusiness/AWHBPBLoginRouter.h>


@interface AllFunctionsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *areaNumberArr;
@property (nonatomic, strong)NSMutableArray *firstAreaArr;
@property (nonatomic, strong)NSMutableArray *secondAreaArr;
@property (nonatomic, strong)NSMutableArray *thirdAreaArr;
@property (nonatomic, strong)NSMutableArray *fourthAreaArr;
@property (nonatomic, strong)NSMutableArray *headerArray;

@end

@implementation AllFunctionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部功能";
    UIButton *takeBtn = [AWHBBControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) target:self SEL:@selector(subscription) title:AWHBRLocalizedString(@"退出") image:nil Color:@"ffffff" Font:scaleForText720(15)];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:takeBtn];
    self.navigationItem.rightBarButtonItem = buttonItem;
    if (self.firstAreaArr.count > 0) {
        [self.areaNumberArr addObject:self.firstAreaArr];
        [self.headerArray addObject:@"监控"];
    }
    if (self.secondAreaArr.count > 0) {
        [self.areaNumberArr addObject:self.secondAreaArr];
        [self.headerArray addObject:@"报表"];
    }
    if (self.thirdAreaArr.count > 0) {
        [self.areaNumberArr addObject:self.thirdAreaArr];
        [self.headerArray addObject:@"传感器报表"];
    }
    if (self.fourthAreaArr.count > 0) {
        [self.areaNumberArr addObject:self.fourthAreaArr];
        [self.headerArray addObject:@"其他"];
    }
    [self UI];
    self.leftBackButton.hidden = YES;
    self.isCanPop = NO;
    // Do any additional setup after loading the view.
}

- (void)subscription
{
    [AWHBPBLoginRouter logout:^(NSDictionary * _Nonnull requestDic) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSMutableArray *)firstAreaArr
{
    if (!_firstAreaArr) {
        _firstAreaArr = [NSMutableArray arrayWithObjects:@"单车监控",@"多车监控",@"列表监控",@"极简监控",@"历史轨迹",@"实时报警",@"实时视频",@"录像回放",@"单车跟踪", nil];
    }
    return _firstAreaArr;
}

- (NSMutableArray *)secondAreaArr
{
    if (!_secondAreaArr) {
        _secondAreaArr = [NSMutableArray arrayWithObjects:@"里程查询",@"安全查询",@"照片查询",@"停车统计", nil];
    }
    return _secondAreaArr;
}

- (NSMutableArray *)thirdAreaArr
{
    if (!_thirdAreaArr) {
        _thirdAreaArr = [NSMutableArray arrayWithObjects:@"油量统计",@"水位统计",@"温度统计",@"湿度统计",@"载重统计", nil];
    }
    return _thirdAreaArr;
}

- (NSMutableArray *)fourthAreaArr
{
    if (!_fourthAreaArr) {
        _fourthAreaArr = [NSMutableArray arrayWithObjects:@"新增车辆", nil];
    }
    return _fourthAreaArr;
}

- (NSMutableArray *)areaNumberArr
{
    if (!_areaNumberArr) {
        _areaNumberArr = [NSMutableArray array];
    }
    return _areaNumberArr;
}

- (NSMutableArray *)headerArray
{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}

-(void)UI{
    //1.初始化layout
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout2 setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    layout2.headerReferenceSize = CGSizeMake(kScreenW, scaleFrom750(80));
//    layout2.footerReferenceSize = CGSizeMake(kScreenW, scaleFrom750(20));
    
    //该方法也可以设置itemSize
    layout2.itemSize =CGSizeMake(kScreenW / 4 - scaleFrom720(1),scaleFrom750(150));
    
    //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout2];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [self.collectionView registerClass:[AllHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableViewHeader"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"reusableViewFooter"];
    //4.设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.areaNumberArr.count;
}

//指定有多少个子视图
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.areaNumberArr objectAtIndex:section] count];
}
//指定子视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.locationImage.image = [AWHBRSUtilities imageNamed:[[self.areaNumberArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.title.text = [[self.areaNumberArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.title.text = AWHBRLocalizedString(cell.title.text);
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //cell自定义 取cell
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self goToVC:cell.title.text];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader ]){
        reuseIdentifier = @"reusableViewHeader";
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        AllHeaderCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"reusableViewHeader"   forIndexPath:indexPath];
        view.label.text = [self.headerArray objectAtIndex:indexPath.section];
        return view;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"reusableViewFooter"   forIndexPath:indexPath];
        view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        return view;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, scaleFrom750(20));;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)goToVC:(NSString *)title
{
    AWHBPBLoginRouterType loginRouterType = [self getLoginRouterType:title];
    [AWHBPBLoginRouter goToViewController:loginRouterType];
}

-(AWHBPBLoginRouterType)getLoginRouterType:(NSString*)title{
    AWHBPBLoginRouterType loginRouterType = AWHBPBLoginRouterTypeMonitoringSingle;
    if ([title isEqualToString:AWHBRLocalizedString(@"单车监控")]) {
        loginRouterType = AWHBPBLoginRouterTypeMonitoringSingle;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"多车监控")]) {
        loginRouterType = AWHBPBLoginRouterTypeMonitoringMap;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"列表监控")]) {
        loginRouterType = AWHBPBLoginRouterTypeListMonitoring;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"极简监控")]) {
        loginRouterType = AWHBPBLoginRouterTypeMinimalistMonitoring;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"历史轨迹")]) {
        loginRouterType = AWHBPBLoginRouterTypeHistoryPath;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"实时报警")]) {
        loginRouterType = AWHBPBLoginRouterTypeRealtimeAlarm;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"实时视频")]) {
        loginRouterType = AWHBPBLoginRouterTypeRealTimeVideo;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"录像回放")]) {
        loginRouterType = AWHBPBLoginRouterTypeHistoryVideo;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"里程查询")]) {
        loginRouterType = AWHBPBLoginRouterTypeQueryMileage;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"安全查询")]) {
        loginRouterType = AWHBPBLoginRouterTypeAlarmQuery;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"照片查询")]) {
        loginRouterType = AWHBPBLoginRouterTypeQueryPhotos;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"停车统计")]) {
        loginRouterType = AWHBPBLoginRouterTypeParkingStatistics;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"油量统计")]) {
        loginRouterType = AWHBPBLoginRouterTypeOilQuantityStatistics;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"水位统计")]) {
        loginRouterType = AWHBPBLoginRouterTypeWaterLevelStatistics;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"温度统计")]) {
        loginRouterType = AWHBPBLoginRouterTypeTemperatureStatistics;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"湿度统计")]) {
        loginRouterType = AWHBPBLoginRouterTypeHumidityStatistics;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"载重统计")]) {
        loginRouterType = AWHBPBLoginRouterTypeLoadStatistics;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"新增车辆")]) {
        loginRouterType = AWHBPBLoginRouterTypeNewVehicles;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"单车跟踪")]) {
        loginRouterType = AWHBPBLoginRouterTypeBikeTracking;
    }else if ([title isEqualToString:AWHBRLocalizedString(@"近期油耗")]) {
        loginRouterType = AWHBPBLoginRouterTypeRecentOilConsumption;
    }
    
//    单车跟踪  近期油耗
    return loginRouterType;
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
