//
//  NZHSwipeNavigationPageController.m
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/25.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//


#import "NZHSwipeNavigationPageController.h"
#import "ButtonScrollBarUnderNavigation.h"

@interface NZHSwipeNavigationPageController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewControllerArray;
@property (nonatomic, strong) NSArray *subTitleArray;
@property (nonatomic, assign) NSUInteger buttonWidth;

@property (nonatomic, assign) NSInteger numberOfButtons;

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, assign) CGFloat selectorWidth;
@property (nonatomic, assign) CGFloat selectorHeight;
@property (nonatomic, assign) BOOL isMiddleAnimationView;

@property (nonatomic, assign) BOOL hasButtonBarUnderNavigation;
@property (nonatomic, strong) NSString *viewTitle;





@end

@implementation NZHSwipeNavigationPageController

/**
 *  lazy methods going on
 *
 */
- (NSArray *)viewControllerArray {
    if (_viewControllerArray == nil) {
        _viewControllerArray = [NSMutableArray array];
    }
    return _viewControllerArray;
}

- (NSArray *)subTitleArray {
    if (_subTitleArray == nil) {
        _subTitleArray = [NSMutableArray array];
    }
    return _subTitleArray;
}

- (UIView *)animationView {
    if (_animationView == nil) {
        _animationView = [[UIView alloc]init];
        _animationView.backgroundColor = [UIColor cyanColor];
        _selectorWidth = self.buttonWidth*0.8;
        _selectorHeight = 4.0;
    }
    return _animationView;
}

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}





- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}




- (instancetype)initForBarUnderNavigationWithTitle:(NSString *)title andButtonTitles:(NSArray *)buttonTitleArray barHeight:(CGFloat)barHeight buttonWidth:(CGFloat)buttonWidth controllers:(NSArray *)controllers {
    self = [super init];
    if (self) {
        /**
         navigationController getodaze!
         */
        self.buttonWidth = buttonWidth;
        self.numberOfButtons = controllers.count;
        self.swipeNavigationController = [[UINavigationController alloc]initWithRootViewController:self];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.title = title;
        NSLog(@"%@", title);
        
        self.buttonBar = [[ButtonScrollBarUnderNavigation alloc]initWithBarHeight:barHeight buttonWidth:buttonWidth andButtonTitles:buttonTitleArray];
        self.buttonBar.backgroundColor = [UIColor yellowColor];
        self.hasButtonBarUnderNavigation = YES;
        self.viewControllerArray = controllers;
        NSLog(@"self.viewControllerArray:%@", self.viewControllerArray);
    }
    return self;
}


- (instancetype)initForSwipeByNavigationBarWithSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers andButtonWidth:(NSUInteger)width {
    self = [super init];
    if (self) {
        /**
         navigationController getodaze!
         */
        self.swipeNavigationController = [[UINavigationController alloc]initWithRootViewController:self];
        self.navigationController.navigationBar.translucent = NO;
        
        self.subTitleArray = subTitles;
        self.viewControllerArray = controllers;
        self.numberOfButtons = self.subTitleArray.count;
        self.buttonWidth = width;
    }else {
        NSLog(@"NZHSwipeNavigationPageController init error.");
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        /**
         navigationController getodaze!
         */
        self.swipeNavigationController = [[UINavigationController alloc]initWithRootViewController:self];
        self.navigationController.navigationBar.translucent = NO;
    }
    return self;
}

- (void)setFlatAnimationalSelector:(UIView *)animationView {
    self.selectorWidth = animationView.frame.size.width;
    self.selectorHeight = animationView.frame.size.height;
    self.animationView = animationView;
    self.isMiddleAnimationView = NO;
    [self createSelector];
}

- (void)setMiddleAnimationalSelector:(UIView *)animationView {
    self.selectorWidth = animationView.frame.size.width;
    self.selectorHeight = animationView.frame.size.height;
    self.animationView = animationView;
    self.isMiddleAnimationView = YES;
    [self createSelector];
}

- (void)createSelector {
    if (self.animationView) {
        if (self.hasButtonBarUnderNavigation == NO) {
            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:self.selectorWidth];
            CGRect selectorRect;
            if (self.isMiddleAnimationView == NO) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, 44-self.selectorHeight, self.selectorWidth, self.selectorHeight);
            }else if (self.isMiddleAnimationView == YES) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (44-self.selectorHeight)/2, self.selectorWidth, self.selectorHeight);
            }
            self.animationView.frame = selectorRect;
            [self.navigationController.navigationBar addSubview:self.animationView];
        }else if (self.hasButtonBarUnderNavigation == YES) {
            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:self.selectorWidth];
            CGRect selectorRect;
            if (self.isMiddleAnimationView == NO) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, self.buttonBar.barHeight-self.selectorHeight, self.selectorWidth, self.selectorHeight);
            }else if (self.isMiddleAnimationView == YES) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (self.buttonBar.barHeight-self.selectorHeight)/2, self.selectorWidth, self.selectorHeight);
            }
            NSLog(@"%f, %f, %f, %f", selectorRect.origin.x, selectorRect.origin.y, selectorRect.size.width, selectorRect.size.height);
            self.animationView.frame = selectorRect;
            [self.buttonBar addSubview:self.animationView];
        }
    }
}

- (void)createButtons {
    for (int i = 0; i < self.numberOfButtons; i++) {
        CGFloat originPointOfButtonFromeLeft = (self.view.bounds.size.width-self.numberOfButtons*self.buttonWidth)/(self.numberOfButtons+1)*(i+1) + self.buttonWidth*i;
        CGRect rect = CGRectMake (originPointOfButtonFromeLeft, 0, self.buttonWidth, self.navigationController.navigationBar.frame.size.height);
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [button setTitle:[self.subTitleArray objectAtIndex:i]
                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [self.buttonArray addObject:button];
        [self.navigationController.navigationBar addSubview:button];
    }
}

- (CGFloat)calculateForOriginPointOfSelectorFromLeftOfNumber:(NSInteger)number withSelectorWidth:(CGFloat)selectorWidth {
    CGFloat middlePointOfButtonFromeLeft = (self.view.bounds.size.width-self.numberOfButtons*self.buttonWidth)/(self.numberOfButtons+1)*(number+1)+self.buttonWidth*number+self.buttonWidth/2;
    CGFloat originPointOfSelectorFromLeft = middlePointOfButtonFromeLeft-selectorWidth/2;
    return originPointOfSelectorFromLeft;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     test
     */
    self.view.backgroundColor = [UIColor grayColor];
    
    /**
     *  create a PageViewController
     */
    
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self.pageViewController setViewControllers:@[[self.viewControllerArray objectAtIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    if (self.hasButtonBarUnderNavigation == YES) {
        CGRect rect = CGRectMake(0, self.buttonBar.barHeight, self.pageViewController.view.frame.size.width, self.pageViewController.view.frame.size.height-self.buttonBar.barHeight);
        self.pageViewController.view.frame = rect;
    }
    
    [self addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    
    //    [self.pageViewController didMoveToParentViewController:self];
    
    [self catchScrollView];
    /**
     *  create all segments
     */
    
    [self createSelector];
    
    if (self.hasButtonBarUnderNavigation == NO) {
        [self createButtons];
    }else if (self.hasButtonBarUnderNavigation == YES) {
        [self.view addSubview:self.buttonBar];
    }
}

/**
 *  catch the scrollView in pageViewController
 */
- (void)catchScrollView {
    for (UIView* view in self.pageViewController.view.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            self.pageScrollView = (UIScrollView *)view;
            self.pageScrollView.delegate = self;
        }
    }
}

/**
 *  pageViewControllerDataSouce methods
 *
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllerArray indexOfObject:viewController];
    if (index >= self.viewControllerArray.count-1) {
        return nil;
    }
    index++;
    return self.viewControllerArray[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllerArray indexOfObject:viewController];
    if (index < 1) {
        return nil;
    }
    index--;
    return self.viewControllerArray[index];
}

/**
 *  pageViewControllerDelegate method
 *
 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.currentPageIndex = [self.viewControllerArray indexOfObject:[pageViewController.viewControllers lastObject]];
    }
}



/**
 *  scrollViewDelegate method
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOriginPoint = [self calculateForOriginPointOfSelectorFromLeftOfNumber:self.currentPageIndex withSelectorWidth:self.selectorWidth];
    CGFloat distance = self.view.bounds.size.width/(self.numberOfButtons+1)+8;
    CGFloat viewX = scrollView.contentOffset.x-self.view.bounds.size.width;
    CGFloat proportion = viewX/self.view.bounds.size.width;
    CGFloat movingX = proportion*distance;
    CGRect viewRect = CGRectMake(currentOriginPoint+movingX, self.animationView.frame.origin.y, self.animationView.frame.size.width, self.animationView.frame.size.height);
    self.animationView.frame = viewRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
