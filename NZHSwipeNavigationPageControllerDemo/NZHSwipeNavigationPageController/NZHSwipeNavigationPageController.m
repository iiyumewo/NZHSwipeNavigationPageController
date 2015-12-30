//
//  NZHSwipeNavigationPageController.m
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/25.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//

#define SELECTORWIDTH self.animationView.frame.size.width
#define SELECTORHEIGHT self.animationView.frame.size.height

#import "NZHSwipeNavigationPageController.h"
#import "ButtonScrollBarUnderNavigation.h"

@interface NZHSwipeNavigationPageController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

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
        CGRect deafultRect = CGRectMake(0, 0, self.buttonWidth*0.8, 4.0);
        _animationView.frame = deafultRect;
//        _selectorWidth = self.buttonWidth*0.8;
//        _selectorHeight = 4.0;
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
        self.title = title;
        
        self.buttonBar = [[ButtonScrollBarUnderNavigation alloc]initWithBarHeight:barHeight buttonWidth:buttonWidth andButtonTitles:buttonTitleArray];
        self.buttonBar.backgroundColor = [UIColor yellowColor];
        self.hasButtonBarUnderNavigation = YES;
        self.viewControllerArray = controllers;
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
    self.animationView = animationView;
    self.isMiddleAnimationView = NO;
    [self createSelector];
}

- (void)setMiddleAnimationalSelector:(UIView *)animationView {
    self.animationView = animationView;
    self.isMiddleAnimationView = YES;
    [self createSelector];
}

//- (CGRect)calculateForSelector {
//    CGRect selectorRect = CGRectZero;
//    if (self.animationView) {
//        if (self.hasButtonBarUnderNavigation == NO) {
//            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:self.selectorWidth];
//            if (self.isMiddleAnimationView == NO) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, 44-self.selectorHeight, self.selectorWidth, self.selectorHeight);
//            }else if (self.isMiddleAnimationView == YES) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (44-self.selectorHeight)/2, self.selectorWidth, self.selectorHeight);
//            }
//            self.selectorY = selectorRect.origin.y;
//            return selectorRect;
//        }else if (self.hasButtonBarUnderNavigation == YES) {
//            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:self.selectorWidth];
//            CGRect selectorRect;
//            if (self.isMiddleAnimationView == NO) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, self.buttonBar.barHeight-self.selectorHeight, self.selectorWidth, self.selectorHeight);
//            }else if (self.isMiddleAnimationView == YES) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (self.buttonBar.barHeight-self.selectorHeight)/2, self.selectorWidth, self.selectorHeight);
//                NSLog(@"%f, %f, %f, %f", selectorRect.origin.x, selectorRect.origin.y, selectorRect.size.width, selectorRect.size.height);
//            }
//                        NSLog(@"%f, %f, %f, %f", selectorRect.origin.x, selectorRect.origin.y, selectorRect.size.width, selectorRect.size.height);
//            self.selectorY = selectorRect.origin.y;
//            return selectorRect;
//        }
//    }
//    NSLog(@"%f, %f, %f, %f", selectorRect.origin.x, selectorRect.origin.y, selectorRect.size.width, selectorRect.size.height);
//    return selectorRect;
//}

- (CGRect)calculateForSelector {
    CGRect selectorRect = CGRectZero;
    if (self.animationView) {
        if (self.hasButtonBarUnderNavigation == NO) {
            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:SELECTORWIDTH];
            if (self.isMiddleAnimationView == NO) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, 44-SELECTORHEIGHT, SELECTORWIDTH, SELECTORHEIGHT);
            }else if (self.isMiddleAnimationView == YES) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (44-SELECTORHEIGHT)/2, SELECTORWIDTH, SELECTORHEIGHT);
            }
        }else if (self.hasButtonBarUnderNavigation == YES) {
            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:SELECTORWIDTH];
            if (self.isMiddleAnimationView == NO) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, self.buttonBar.barHeight-SELECTORHEIGHT, SELECTORWIDTH, SELECTORHEIGHT);
            }else if (self.isMiddleAnimationView == YES) {
                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (self.buttonBar.barHeight-SELECTORHEIGHT)/2, SELECTORWIDTH, SELECTORHEIGHT);
            }
        }
    }
    self.selectorY = selectorRect.origin.y;
    return selectorRect;
}

- (void)createSelector {
    if (self.animationView) {
        if (self.hasButtonBarUnderNavigation == NO) {
            self.animationView.frame = [self calculateForSelector];
            [self.navigationController.navigationBar addSubview:self.animationView];
        }else if (self.hasButtonBarUnderNavigation == YES) {
            self.animationView.frame = [self calculateForSelector];
            [self.buttonBar addSubview:self.animationView];
        }
    }
}

//- (void)createSelector {
//    if (self.animationView) {
//        if (self.hasButtonBarUnderNavigation == NO) {
//            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:self.selectorWidth];
//            CGRect selectorRect;
//            if (self.isMiddleAnimationView == NO) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, 44-self.selectorHeight, self.selectorWidth, self.selectorHeight);
//            }else if (self.isMiddleAnimationView == YES) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (44-self.selectorHeight)/2, self.selectorWidth, self.selectorHeight);
//            }
//            self.animationView.frame = selectorRect;
//            [self.navigationController.navigationBar addSubview:self.animationView];
//        }else if (self.hasButtonBarUnderNavigation == YES) {
//            CGFloat originPointOfSelectorFromLeft = [self calculateForOriginPointOfSelectorFromLeftOfNumber:0 withSelectorWidth:self.selectorWidth];
//            CGRect selectorRect;
//            if (self.isMiddleAnimationView == NO) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, self.buttonBar.barHeight-self.selectorHeight, self.selectorWidth, self.selectorHeight);
//            }else if (self.isMiddleAnimationView == YES) {
//                selectorRect = CGRectMake(originPointOfSelectorFromLeft, (self.buttonBar.barHeight-self.selectorHeight)/2, self.selectorWidth, self.selectorHeight);
//            }
//            //            NSLog(@"%f, %f, %f, %f", selectorRect.origin.x, selectorRect.origin.y, selectorRect.size.width, selectorRect.size.height);
//            self.animationView.frame = selectorRect;
//            [self.buttonBar addSubview:self.animationView];
//            self.selectorY = self.animationView.frame.origin.y;
//        }
//    }
//}

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
     *  deafult choice
     */
    self.shouldBounce = NO;
    
    
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
    self.nextPageIndex = self.currentPageIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    
    id controller = [pendingViewControllers firstObject];
    self.nextPageIndex = [self.viewControllerArray indexOfObject:controller];
}


/**
 *  scrollViewDelegate method
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self calculateForSelector];
    if (scrollView.contentOffset.x >= self.view.bounds.size.width) {
        self.positionRatio = (scrollView.contentOffset.x - self.view.bounds.size.width)/self.view.bounds.size.width;
    }else if (scrollView.contentOffset.x <= self.view.bounds.size.width) {
        self.positionRatio = (self.view.bounds.size.width-scrollView.contentOffset.x)/self.view.bounds.size.width;
    }
    /**
     *  Fundational calculation.
     *
     */
    CGFloat currentOriginPoint = [self calculateForOriginPointOfSelectorFromLeftOfNumber:self.currentPageIndex withSelectorWidth:SELECTORWIDTH];
    CGFloat distance = self.view.bounds.size.width/(self.numberOfButtons+1)+8;
    CGFloat viewX = scrollView.contentOffset.x-self.view.bounds.size.width;
    CGFloat proportion = viewX/self.view.bounds.size.width;
    CGFloat movingX = proportion*distance;
    self.selectorX = currentOriginPoint+movingX;
    
    /* The iOS page view controller API is broken.  It lies to us and tells us
     that the currently presented view hasn't changed, but under the hood, it
     starts giving the contentOffset relative to the next view.  The only
     way to detect this brain damage is to notice that the content offset is
     discontinuous, and pretend that the page changed.
     */
    if (self.nextPageIndex > self.currentPageIndex) {
        /* Scrolling forwards */
        
        if (scrollView.contentOffset.x < (self.lastPosition - (.9 * scrollView.bounds.size.width))) {
            self.currentPageIndex = self.nextPageIndex;
            //            [self.pageControl setCurrentPage:self.currentIndex];
        }
    } else {
        /* Scrolling backwards */
        
        if (scrollView.contentOffset.x > (self.lastPosition + (.9 * scrollView.bounds.size.width))) {
            self.currentPageIndex = self.nextPageIndex;
            //            [self.pageControl setCurrentPage:self.currentIndex];
        }
    }
    
    /* Need to calculate max/min offset for *every* page, not just the first and last. */
    CGFloat minXOffset = scrollView.bounds.size.width - (self.currentPageIndex * scrollView.bounds.size.width);
    CGFloat maxXOffset = (([self.viewControllerArray count] - self.currentPageIndex) * scrollView.bounds.size.width);
    
//    NSLog(@"Page: %ld NextPage: %ld X: %lf MinOffset: %lf MaxOffset: %lf\n", (long)self.currentPageIndex, (long)self.nextPageIndex,
//          (double)scrollView.contentOffset.x,
//          (double)minXOffset, (double)maxXOffset);
    
    if (!self.shouldBounce) {
        CGRect scrollBounds = scrollView.bounds;
        if (scrollView.contentOffset.x <= minXOffset) {
            scrollView.contentOffset = CGPointMake(minXOffset, 0);
            // scrollBounds.origin = CGPointMake(minXOffset, 0);
        } else if (scrollView.contentOffset.x >= maxXOffset) {
            scrollView.contentOffset = CGPointMake(maxXOffset, 0);
            // scrollBounds.origin = CGPointMake(maxXOffset, 0);
        }
        [scrollView setBounds:scrollBounds];
    }
    self.lastPosition = scrollView.contentOffset.x;
    
    if (self.customAnimationBlock == nil) {
        CGRect viewRect = CGRectMake(self.selectorX, self.selectorY, self.animationView.frame.size.width, self.animationView.frame.size.height);
        self.animationView.frame = viewRect;
    }else if (self.customAnimationBlock != nil) {
        self.customAnimationBlock(self.pageScrollView);
    }
    
//    NSLog(@"%f, %f, %f, %f", self.animationView.frame.origin.x, self.animationView.frame.origin.y, self.animationView.frame.size.width, self.animationView.frame.size.height);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    /* Need to calculate max/min offset for *every* page, not just the first and last. */
    CGFloat minXOffset = scrollView.bounds.size.width - (self.currentPageIndex * scrollView.bounds.size.width);
    CGFloat maxXOffset = (([self.viewControllerArray count] - self.currentPageIndex) * scrollView.bounds.size.width);
    
    if (!self.shouldBounce) {
        if (scrollView.contentOffset.x <= minXOffset) {
            *targetContentOffset = CGPointMake(minXOffset, 0);
        } else if (scrollView.contentOffset.x >= maxXOffset) {
            *targetContentOffset = CGPointMake(maxXOffset, 0);
        }
    }
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
