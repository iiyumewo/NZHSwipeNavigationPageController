//
//  NZHSwipeNavigationPageController.h
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/25.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtonScrollBarUnderNavigation;

@interface NZHSwipeNavigationPageController : UIViewController



@property (nonatomic, strong) UINavigationController *swipeNavigationController;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) ButtonScrollBarUnderNavigation *buttonBar;

- (instancetype)initForSwipeByNavigationBarWithSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers andButtonWidth:(NSUInteger)width;
- (instancetype)initForBarUnderNavigationWithTitle:(NSString *)title andButtonTitles:(NSArray *)buttonTitleArray barHeight:(CGFloat)barHeight buttonWidth:(CGFloat)buttonWidth controllers:(NSArray *)controllers;

- (void)setFlatAnimationalSelector:(UIView *)animationView;
- (void)setMiddleAnimationalSelector:(UIView *)animationView;


@end
