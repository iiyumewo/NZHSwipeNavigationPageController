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

- (UIColor *)selectedButtonColor {
    if (_selectedButtonColor == nil) {
        _selectedButtonColor = [[UIColor alloc]init];
    }
    return _selectedButtonColor;
}

- (UIColor *)normalButtonColor {
    if (_normalButtonColor == nil) {
        _normalButtonColor = [[UIColor alloc]init];
    }
    return _normalButtonColor;
}












/**
 *  make the buttons can scroll to the page it specified by one tap.
 */
- (void)addMethodToButtons {
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        [btn addTarget:self action:@selector(tapButtonScrollToTarget:) forControlEvents:UIControlEventTouchDown];
    }];
}

- (void)tapButtonScrollToTarget:(UIButton *)sender {
    self.isTappingToScroll = YES;
    NSInteger index = [self.buttonArray indexOfObject:sender];
    [self coloredButtonsSelectedOnNumber:index];
    
    __block NZHSwipeNavigationPageController *blockDemo = self;
    if (index < self.currentPageIndex) {
        for (NSInteger i = self.currentPageIndex-1; i >= index; i--) {
            //            NSLog(@"%ld", self.currentPageIndex);
            [self.pageViewController setViewControllers:@[[self.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL complete) {
                if (complete) {
                    blockDemo.currentPageIndex = i;
                    
                    //                    NSLog(@"reverseComplete-current:%ld", self.currentPageIndex);
                }
            }];
        }
    }else if(index > self.currentPageIndex) {
        //        NSLog(@"current:%ld", self.currentPageIndex);
        for (NSInteger i = self.currentPageIndex+1; i<=index; i++) {
            //            NSLog(@"i:%ld", i);
            [self.pageViewController setViewControllers:@[[self.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL complete) {
                if (complete) {
                    blockDemo.currentPageIndex = i;
                    //                    NSLog(@"forwardComplete-current:%ld", self.currentPageIndex);
                }
            }];
        }
    }
    //    NSLog(@"%ld", blockDemo.currentPageIndex);
}






/**
 *  core init methods.
 *
 */
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
        self.subTitleArray = buttonTitleArray;
        
        self.buttonBar = [[ButtonScrollBarUnderNavigation alloc]initWithBarHeight:barHeight buttonWidth:buttonWidth andButtonTitles:buttonTitleArray];
        //        self.buttonArray = self.buttonBar.buttonArray;
        [self addMethodToButtons];
        self.buttonBar.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
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
        self.buttonWidth = width;
        self.numberOfButtons = controllers.count;
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

- (instancetype)initForSwipeByNavigationBarWithSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers andButtonWidth:(NSUInteger)width WithButtonMargin:(CGFloat)buttonMargin {
    self = [self initForSwipeByNavigationBarWithSubTitles:subTitles andControllers:controllers andButtonWidth:width];
    self.marginOfButton = buttonMargin;
    return self;
}

- (instancetype)initForBarUnderNavigationWithTitle:(NSString *)title andButtonTitles:(NSArray *)buttonTitleArray barHeight:(CGFloat)barHeight buttonWidth:(CGFloat)buttonWidth controllers:(NSArray *)controllers withButtonMargin:(CGFloat)buttonMargin {
    self = [self initForBarUnderNavigationWithTitle:title andButtonTitles:buttonTitleArray barHeight:barHeight buttonWidth:buttonWidth controllers:controllers];
    self.marginOfButton = buttonMargin;
    return self;
}



//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        /**
//         navigationController getodaze!
//         */
//        self.swipeNavigationController = [[UINavigationController alloc]initWithRootViewController:self];
//        self.navigationController.navigationBar.translucent = NO;
//    }
//    return self;
//}






/**
 *  methods to replace the deafult selector with a custom view.
 *  calculating for selector's birth-place and to draw it on the bar.
 *
 */
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
        self.animationView.frame = [self calculateForSelector];
        if (self.hasButtonBarUnderNavigation == NO) {
            [self.navigationController.navigationBar addSubview:self.animationView];
        }else if (self.hasButtonBarUnderNavigation == YES) {
            [self.buttonBar addSubview:self.animationView];
        }
    }
}

- (CGFloat)calculateForOriginPointOfSelectorFromLeftOfNumber:(NSInteger)number withSelectorWidth:(CGFloat)selectorWidth {
    //    CGFloat middlePointOfButtonFromeLeft = 0;
    CGFloat middlePointOfButtonFromeLeft = (self.view.bounds.size.width-self.numberOfButtons*self.buttonWidth)/(self.numberOfButtons+1)*(number+1)+self.buttonWidth*number+self.buttonWidth/2;
    CGFloat originPointOfSelectorFromLeft = middlePointOfButtonFromeLeft-selectorWidth/2;
    return originPointOfSelectorFromLeft;
}









- (void)createButtons {
    if (self.marginOfButton == 0) {
        for (int i = 0; i < self.numberOfButtons; i++) {
            CGFloat originPointOfButtonFromeLeft = (self.view.bounds.size.width-self.numberOfButtons*self.buttonWidth)/(self.numberOfButtons+1)*(i+1) + self.buttonWidth*i;
            CGRect rect = CGRectMake (originPointOfButtonFromeLeft, 0, self.buttonWidth, self.navigationController.navigationBar.frame.size.height);
            UIButton *button = [[UIButton alloc]initWithFrame:rect];
            [button setTitle:[self.subTitleArray objectAtIndex:i]
                    forState:UIControlStateNormal];
            [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            [self.buttonArray addObject:button];
            if (self.buttonBar == nil) {
                [self.navigationController.navigationBar addSubview:button];
            }else if (self.buttonBar != nil) {
                [self.buttonBar addSubview:button];
            }
        }
        [self addMethodToButtons];
    }else if (self.marginOfButton != 0) {
        for (int i = 0; i < self.numberOfButtons; i++) {
            CGRect rect = [self calculateFrameOfButtonOfNumber:i withButtonWidth:self.buttonWidth];
            UIButton *button = [[UIButton alloc]initWithFrame:rect];
            [button setTitle:[self.subTitleArray objectAtIndex:i]
                    forState:UIControlStateNormal];
            [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            [self.buttonArray addObject:button];
            if (self.buttonBar == nil) {
                [self.navigationController.navigationBar addSubview:button];
            }else if (self.buttonBar != nil) {
                [self.buttonBar addSubview:button];
            }
        }
    }
}

- (CGRect)calculateFrameOfButtonOfNumber:(NSInteger)number withButtonWidth:(CGFloat)buttonWidth {
    if (self.marginOfButton != 0) {
        CGRect rect = CGRectZero;
        CGFloat buttonBarHeight = CGRectGetHeight(self.buttonBar.frame);
        CGFloat originPointOfButtonFromeLeft = 0;
        if (number == 0) {
            originPointOfButtonFromeLeft = self.marginOfButton;
            rect = CGRectMake(originPointOfButtonFromeLeft, 0, self.buttonWidth, buttonBarHeight);
            NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
            return rect;
        }else if (number != 0) {
            CGFloat equalDistance = (self.buttonBar.frame.size.width-self.marginOfButton*2-self.buttonWidth*self.numberOfButtons)/(self.numberOfButtons-1);
            originPointOfButtonFromeLeft = self.marginOfButton+self.buttonWidth+number*equalDistance+(number-1)*self.buttonWidth;
            rect = CGRectMake(originPointOfButtonFromeLeft, 0, self.buttonWidth, buttonBarHeight);
            return rect;
        }
    }
    NSLog(@"calculating button frame error");
    return CGRectZero;
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
    
    [self.pageViewController didMoveToParentViewController:self];
    
    [self catchScrollView];
    /**
     *  create all segments
     */
    
    
    
    if (self.hasButtonBarUnderNavigation == NO) {
        [self createButtons];
        
    }else if (self.hasButtonBarUnderNavigation == YES) {
        [self.view addSubview:self.buttonBar];
        [self createButtons];
    }
    [self createSelector];
    NSLog(@"%ld", _buttonArray.count);
    NSLog(@"%@", _selectedButtonColor);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self coloredButtonsSelectedOnNumber:0];
}

- (void)coloredButtonsSelectedOnNumber:(NSInteger)buttonNumber {
    NSLog(@"%ld", buttonNumber);
    if (_normalButtonColor != nil) {
        [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
            if (_selectedButtonColor != nil) {
                if (idx == buttonNumber) {
                    [btn setTitleColor:_selectedButtonColor forState:UIControlStateNormal];
                }
            }
        }];
    }
    if (_selectedButtonColor != nil) {
        [((UIButton *)self.buttonArray[buttonNumber]) setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
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
 *  viewController delegate methods
 *
 */


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
        if (_selectedButtonColor != nil && _normalButtonColor != nil) {
            [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if (idx == self.currentPageIndex) {
                    [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
                }else if (idx != self.currentPageIndex) {
                    [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
                }
            }];
        }
    }
    self.nextPageIndex = self.currentPageIndex;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    
    id controller = [pendingViewControllers firstObject];
    self.nextPageIndex = [self.viewControllerArray indexOfObject:controller];
}


/**
 *  scrollViewDelegate method
 *
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isTappingToScroll = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)buttonColorChangeDuringDragging:(UIScrollView *)scrollView {
    CGFloat i = scrollView.contentOffset.x/self.view.frame.size.width;
    NSInteger j = scrollView.contentOffset.x/self.view.frame.size.width;
    CGFloat k = i-j;
    NSLog(@"i:%f, j:%ld, k:%f", i, j, k);
    if (self.nextPageIndex > self.currentPageIndex) {
        if (k > 0.5) {
            [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if (idx == self.nextPageIndex) {
                    [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
                }else if (idx != self.nextPageIndex) {
                    [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
                }
            }];
        }else if (k < 0.5) {
            [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if (idx == self.nextPageIndex-1) {
                    [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
                }else if (idx != self.nextPageIndex-1) {
                    [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
                }
            }];
        }
    }else if (self.nextPageIndex < self.currentPageIndex) {
        if (k < 0.5 && k != 0) {
            [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if (idx == self.nextPageIndex) {
                    [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
                }else if (idx != self.nextPageIndex) {
                    [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
                }
            }];
        }else if (k > 0.5 && k != 0) {
            [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                if (idx == self.nextPageIndex+1) {
                    [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
                }else if (idx != self.nextPageIndex+1) {
                    [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
                }
            }];
        }
    }
}



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
            //            self.currentPageIndex = self.nextPageIndex;
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
    
    if (self.isTappingToScroll != YES) {
        [self buttonColorChangeDuringDragging:scrollView];
    }
    //    NSLog(@"didScroll-current:%ld", self.currentPageIndex);
    
    //    NSLog(@"%f, %f, %f, %f", self.animationView.frame.origin.x, self.animationView.frame.origin.y, self.animationView.frame.size.width, self.animationView.frame.size.height);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    if (_selectedButtonColor != nil && _normalButtonColor != nil) {
    //        NSInteger pageNumber = scrollView.contentOffset.x/self.view.frame.size.width;
    //        NSLog(@"%ld", pageNumber);
    //        [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
    //            if (idx == pageNumber) {
    //                [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
    //            }else if (idx != pageNumber) {
    //                [btn setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
    //            }
    ////            CGFloat buttonMid = btn.frame.origin.x+btn.frame.size.width/2;
    ////            CGFloat selectorMid = self.animationView.frame.origin.x+self.animationView.frame.size.width/2;
    ////            if ((buttonMid-selectorMid)<2) {
    ////                [btn setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
    ////            }
    //        }];
    //    }
}



- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
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
