//
//  ButtonScrollBarUnderNavigation.h
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/25.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonScrollBarUnderNavigation : UIScrollView

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) CGFloat barHeight;

@property (nonatomic, assign) NSInteger numberOfButtons;
@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, strong) NSArray *buttonTitleArray;

- (instancetype)initWithBarHeight:(CGFloat)buttonHeight buttonWidth:(CGFloat)buttonWidth andButtonTitles:(NSArray *)titleArray;

@end
