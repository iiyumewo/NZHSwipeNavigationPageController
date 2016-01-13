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
@property (nonatomic, strong) __block UIView *animationView;
@property (nonatomic, strong) ButtonScrollBarUnderNavigation *buttonBar;


@property (nonatomic, strong) NSArray *viewControllerArray;
@property (nonatomic, strong) NSArray *subTitleArray;
@property (nonatomic, assign) NSUInteger buttonWidth;

@property (nonatomic, assign) NSInteger numberOfButtons;

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger nextPageIndex;
@property (nonatomic, assign) CGFloat lastPosition;

@property (nonatomic, strong) UIPageViewController *pageViewController;

//@property (nonatomic, assign) CGFloat selectorWidth;
//@property (nonatomic, assign) CGFloat selectorHeight;
@property (nonatomic, assign) BOOL isMiddleAnimationView;

@property (nonatomic, assign) BOOL hasButtonBarUnderNavigation;
@property (nonatomic, strong) NSString *viewTitle;

@property (nonatomic, assign) BOOL shouldBounce;

@property (nonatomic, strong) void(^customAnimationBlock)(UIScrollView *pageScrollView);

@property (nonatomic, assign) CGFloat selectorY;
@property (nonatomic, assign) CGFloat selectorX;
@property (nonatomic, assign) CGFloat positionRatio;

@property (nonatomic, assign) CGFloat marginOfButton;

@property (nonatomic, strong) UIColor *selectedButtonColor;
@property (nonatomic, strong) UIColor *normalButtonColor;

@property (nonatomic, assign) BOOL isTappingToScroll;


- (instancetype)initForSwipeByNavigationBarWithSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers andButtonWidth:(NSUInteger)width;
- (instancetype)initForBarUnderNavigationWithTitle:(NSString *)title andButtonTitles:(NSArray *)buttonTitleArray barHeight:(CGFloat)barHeight buttonWidth:(CGFloat)buttonWidth controllers:(NSArray *)controllers;

- (instancetype)initForSwipeByNavigationBarWithSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers andButtonWidth:(NSUInteger)width WithButtonMargin:(CGFloat)buttonMargin;
- (instancetype)initForBarUnderNavigationWithTitle:(NSString *)title andButtonTitles:(NSArray *)buttonTitleArray barHeight:(CGFloat)barHeight buttonWidth:(CGFloat)buttonWidth controllers:(NSArray *)controllers withButtonMargin:(CGFloat)buttonMargin;


- (void)setFlatAnimationalSelector:(UIView *)animationView;
- (void)setMiddleAnimationalSelector:(UIView *)animationView;




@end
