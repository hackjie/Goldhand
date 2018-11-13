//
//  UINavigationController+Navbar.m
//  OCThink
//
//  Created by 李杰 on 2018/11/12.
//  Copyright © 2018年 leoli. All rights reserved.
//

#import "UINavigationController+Navbar.h"
#import <objc/runtime.h>

typedef void(^_LJViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (LJNavbarPrivate)
@property (nonatomic, copy) _LJViewControllerWillAppearInjectBlock lj_willAppearInjectBlock;
@end

@implementation UIViewController (LJNavbarPrivate)
+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(lj_viewWillAppear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)lj_viewWillAppear:(BOOL)animated
{
    [self lj_viewWillAppear:animated];
    
    if (self.lj_willAppearInjectBlock) {
        self.lj_willAppearInjectBlock(self, animated);
    }
}

- (_LJViewControllerWillAppearInjectBlock)lj_willAppearInjectBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLj_willAppearInjectBlock:(_LJViewControllerWillAppearInjectBlock)block
{
    objc_setAssociatedObject(self, @selector(lj_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

@implementation UIViewController (LJNavbarPublic)
- (BOOL)lj_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLj_prefersNavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(lj_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UINavigationController (Navbar)
+ (void)load
{
    // Inject "-pushViewController:animated:"
    Method originalMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(lj_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)lj_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Handle perferred navigation bar appearance.
    [self lj_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    // Forward to primary implementation.
    [self lj_pushViewController:viewController animated:animated];
}

- (void)lj_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    if (!self.lj_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _LJViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.lj_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // Setup will appear inject block to appearing view controller.
    // Setup disappearing view controller as well, because not every view controller is added into
    // stack by pushing, maybe by "-setViewControllers:".
    appearingViewController.lj_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.lj_willAppearInjectBlock) {
        disappearingViewController.lj_willAppearInjectBlock = block;
    }
}

- (BOOL)lj_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.lj_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setLj_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(lj_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


