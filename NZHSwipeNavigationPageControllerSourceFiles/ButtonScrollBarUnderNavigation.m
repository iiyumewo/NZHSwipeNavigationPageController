//
//  ButtonScrollBarUnderNavigation.m
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/25.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//

#import "ButtonScrollBarUnderNavigation.h"


@implementation ButtonScrollBarUnderNavigation


- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithBarHeight:(CGFloat)buttonHeight buttonWidth:(CGFloat)buttonWidth andButtonTitles:(NSArray *)titleArray {
    self.barHeight = buttonHeight;
    self.numberOfButtons = titleArray.count;
    self.buttonWidth = buttonWidth;
    self.buttonTitleArray = titleArray;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect rect = CGRectMake(0, 0, width, buttonHeight);
    self = [super initWithFrame:rect];
    if (self) {
        [self createButtons];
//        CGFloat buttonWidth = rect.size.width/titleArray.count;
//        [titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(buttonWidth*idx, 0, buttonWidth, buttonHeight);
//            [button setTitle:titleArray[idx] forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//            [self.buttonArray addObject:button];
//            [self addSubview:button];
//        }];
    }
    return self;
}

- (void)createButtons {
    for (int i = 0; i < self.numberOfButtons; i++) {
        CGFloat originPointOfButtonFromeLeft = (self.bounds.size.width-self.numberOfButtons*self.buttonWidth)/(self.numberOfButtons+1)*(i+1) + self.buttonWidth*i;
        CGRect rect = CGRectMake (originPointOfButtonFromeLeft, 0, self.buttonWidth, self.barHeight);
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [button setTitle:[self.buttonTitleArray objectAtIndex:i]
                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [self.buttonArray addObject:button];
        [self addSubview:button];
    }
}



/**
 *  get the first super controller
 *
 */
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    NSLog(@"find no super controller");
    return nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
