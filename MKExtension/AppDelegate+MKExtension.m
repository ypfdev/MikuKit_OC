//
//  AppDelegate+MKExtension.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2018/11/28.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import "AppDelegate+MKExtension.h"
#import <objc/runtime.h>

@implementation AppDelegate (MKExtension)

- (instancetype)init  {
    self = [super init];
    if (self) {
//        CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
//        if (systemVersion > 12.0
//            && [[UIDevice currentDevice].systemVersion compare:@"12.1"] != NSOrderedDescending) {
//            if (@available(iOS 12.1, *)) {
//                Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
//                SEL sel = @selector(setFrame:);
//                Method tabBarSetFrame = class_getInstanceMethod(tabBarButtonClass, sel);
//                if (tabBarSetFrame) {
//                    method_setImplementation(tabBarSetFrame, imp_implementationWithBlock(^id(__unsafe_unretained Class tabBarButtonClass, SEL setFrame, IMP setFrameIMP) {
//                        return ^(UIButton *tabBarButton, CGRect frame) {
//                            if ([tabBarButton isKindOfClass:tabBarButtonClass]) {
//                                static CGFloat height = 0;
//                                if (!height) {
//                                    height = CGRectGetHeight([UIApplication sharedApplication].delegate.window.rootViewController.tabBarController.tabBar.safeAreaLayoutGuide.layoutFrame) * 0.9;
//                                }
//                                
//                                if (!CGRectIsEmpty(tabBarButton.frame) && (CGRectGetHeight(frame) <= height || CGRectIsEmpty(frame))) {
//                                    return;
//                                }
//                                
//                            }
//                            ((void (*)(id, SEL, CGRect))setFrameIMP)(tabBarButton, setFrame, frame);
//                        };
//                    }(tabBarButtonClass,sel,method_getImplementation(tabBarSetFrame))));
//                }
//            }
//        }
        
//        if (systemVersion >= 10.0 && systemVersion < 11.0) {
//            if (@available(iOS 10, *)) {
//                Class collectionViewClass = UICollectionView.class;
//                SEL sel = @selector(reloadData);
//                Method collectionViewReloadData = class_getInstanceMethod(collectionViewClass, sel);
//                if (collectionViewReloadData) {
//                    method_setImplementation(collectionViewReloadData, imp_implementationWithBlock(^id(__unsafe_unretained Class collectionViewClass, SEL reloadData, IMP reloadDataIMP) {
//                        return ^(UICollectionView *collectionView) {
//                            ((void (*)(id, SEL))reloadDataIMP)(collectionView, reloadData);
//                            if ([collectionView isKindOfClass:collectionViewClass]) {
//                                [collectionView.collectionViewLayout invalidateLayout];
//                            }
//                        };
//                    }(collectionViewClass,sel,method_getImplementation(collectionViewReloadData))));
//                }
//            }
//        }

//        if (@available(iOS 11,*)) {
//            Class textFieldClass = UITextField.class;
//            SEL sel = @selector(removeFromSuperview);
//            SEL ex_sel = NSSelectorFromString(@"ex_removeFromSuperview");
//
//            Method textFieldRemoveFormSuperview = class_getInstanceMethod(textFieldClass, sel);
//
//            IMP imp = imp_implementationWithBlock(^id(__unsafe_unretained Class textFieldClass, SEL removeFromSuperviewSel, IMP removeFromSuperviewIMP) {
//                return ^(UITextField *textField) {
//                    ((void (*)(id, SEL))removeFromSuperviewIMP)(textField,removeFromSuperviewSel);
//                    [textField endEditing:YES];
//                };
//            }(textFieldClass,ex_sel,method_getImplementation(textFieldRemoveFormSuperview)));
//            class_addMethod(textFieldClass, ex_sel, imp, "v@:");
//            method_exchangeImplementations(textFieldRemoveFormSuperview, class_getInstanceMethod(textFieldClass, ex_sel));
//        }
        
//        if (YES) {
//            Class controllerClass = UIViewController.class;
//            SEL sel = @selector(preferredStatusBarStyle);
//            SEL ex_sel = NSSelectorFromString(@"ex_preferredStatusBarStyle");
//
//            Method controllerPreferredStatusBarStyle = class_getInstanceMethod(controllerClass, sel);
//
//            IMP imp = imp_implementationWithBlock(^id(__unsafe_unretained Class controllerClass, SEL preferredStatusBarStyleSel, IMP preferredStatusBarStyleIMP) {
//                return ^(UIViewController *textField) {
//                    NSInteger prefer = ((NSInteger (*)(id, SEL))preferredStatusBarStyleIMP)(textField,preferredStatusBarStyleSel);
//                    return prefer;
//                };
//            }(controllerClass,ex_sel,method_getImplementation(controllerPreferredStatusBarStyle)));
//            class_addMethod(controllerClass, ex_sel, imp, "q@:");
//            method_exchangeImplementations(controllerPreferredStatusBarStyle, class_getInstanceMethod(controllerClass, ex_sel));
//        }
        
//        Class collectionViewClass = UICollectionView.class;
//        SEL sel = @selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:);
//        SEL ex_sel = NSSelectorFromString(@"ex_dequeueReusableCellWithReuseIdentifier:forIndexPath:");
//
//        Method collectionViewReloadData = class_getInstanceMethod(collectionViewClass, sel);
//
//        IMP imp = imp_implementationWithBlock(^id(__unsafe_unretained Class collectionViewClass, SEL reloadData, IMP reloadDataIMP) {
//            return ^(UICollectionView *collectionView,NSString* identifier,NSIndexPath* indexPath) {
//                if ([identifier isEqualToString:@"GPProductCell"]) {
//                    PFLog(@"%@",identifier);
//                }
//                return ((UICollectionViewCell* (*)(id, SEL,id,id))reloadDataIMP)(collectionView,reloadData,identifier,indexPath);
//            };
//        }(collectionViewClass,ex_sel,method_getImplementation(collectionViewReloadData)));
//        class_addMethod(collectionViewClass, ex_sel, imp, "@@:");
//        method_exchangeImplementations(collectionViewReloadData, class_getInstanceMethod(UICollectionView.class, ex_sel));
        
    }
    return self;
}

@end
