//
//  PFMotionVC.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2019/4/17.
//  Copyright © 2019 YuanPengFei. All rights reserved.
//

#import "PFMotionVC.h"
#import <CoreMotion/CoreMotion.h>

@interface PFMotionVC ()

@property (nonatomic, strong) NSArray *btnTitleArr;
@property (nonatomic, strong) UIStackView *btnBar;
@property (nonatomic, strong) UITextField *resultTF;

@property (nonatomic, strong) UIImageView *arrowIV;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation PFMotionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initSubviews];
//    [self startGyroUpdates];
    [self keepBalance];
}

- (void)viewWillDisappear:(BOOL)animated {
    // 该界面消失时一定要停止，不然会一直调用消耗内存
    [self.motionManager stopDeviceMotionUpdates];   // 停止所有的传感器
    [self.motionManager stopGyroUpdates];           // 停止陀螺仪
    [self.motionManager stopAccelerometerUpdates];  // 停止加速度计
    [self.motionManager stopMagnetometerUpdates];   // 停止磁力计
}

- (void)initData {
    _btnTitleArr = @[@"总传感器", @"陀螺仪", @"加速度计", @"磁力计"];
}

- (void)initSubviews {
//    NSMutableArray *btnArrM = [NSMutableArray array];
//    [self.btnTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIButton *btn = [[UIButton alloc] init];
//        [btn setTitle:obj forState:UIControlStateNormal];
//        [btnArrM addObject:btn];
//    }];
//    _btnBar = [[UIStackView alloc] initWithArrangedSubviews:btnArrM];
//    _btnBar.alignment = UIStackViewAlignmentFill;
//    _btnBar.spacing = 2;
//    _btnBar.backgroundColor = UIColor.redColor;
//    [self.view addSubview:_btnBar];
//    [_btnBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(50);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(44);
//    }];
    
    _arrowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_searchFilter_unfold"]];
    [self.view addSubview:_arrowIV];
    [_arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
}

- (void)startDeviceMotionUpdates {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    if (self.motionManager.isDeviceMotionAvailable) {
        self.motionManager.deviceMotionUpdateInterval = 0.5;
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            // Gravity 获取手机的重力值在各个方向上的分量，根据这个就可以获得手机的空间位置，倾斜角度等
            double gravityX = motion.gravity.x;
            double gravityY = motion.gravity.y;
            double gravityZ = motion.gravity.z;
            // 获取手机的倾斜角度(zTheta是手机与水平面的夹角， xyTheta是手机绕自身旋角度)：
            double zTheta = atan2(gravityZ,sqrtf(gravityX * gravityX + gravityY * gravityY)) / M_PI * 180.0;
            double xyTheta = atan2(gravityX, gravityY) / M_PI * 180.0;
            NSLog(@"手机与水平面的夹角 --- %.4f, 手机绕自身旋转的角度为 --- %.4f", zTheta, xyTheta);
        }];
    }
}

- (void)startGyroUpdates {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    if (self.motionManager.isGyroAvailable) {
        self.motionManager.gyroUpdateInterval = 0.5;
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSLog(@"\n🐶偏转角x = %lf\n🐶偏转角y = %lf\n🐶偏转角z = %lf\n", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z);
        }];
    } else {
        NSLog(@"当前设备不支持陀螺仪");
    }
}


- (void)keepBalance{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    if (self.motionManager.accelerometerAvailable) {
        //设置加速计采样频率
        self.motionManager.accelerometerUpdateInterval = 0.01f;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            //                计算图片的水平倾斜角度。这里没有实现Z轴的形变，所以咱们只能在XY轴上变换。有兴趣的童鞋自己实现Z轴好不好？
//            double rotationXY = atan2(accelerometerData.acceleration.x, accelerometerData.acceleration.y) - M_PI;
//            self.arrowIV.transform = CGAffineTransformMakeRotation(rotationXY);
//            NSLog(@"%.2f", rotationXY);
            
            double rotationXZ = atan2(accelerometerData.acceleration.x, accelerometerData.acceleration.z) - M_PI;
            self.arrowIV.transform = CGAffineTransformMakeRotation(rotationXZ);
            [self.arrowIV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view).offset(-100 * rotationXZ);
            }];
            NSLog(@"%.2f", rotationXZ);
        }];
    } else {
        NSLog(@"设备不支持加速计");
    }
}


@end
