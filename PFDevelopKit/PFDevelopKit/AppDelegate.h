//
//  AppDelegate.h
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/8.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

