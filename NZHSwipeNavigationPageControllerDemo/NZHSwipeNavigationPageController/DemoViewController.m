//
//  DemoViewController.m
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/30.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//

#import "DemoViewController.h"
#import "NZHSwipeNavigationPageController.h"

#define kColorWithRGB(r, g, b, a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

#define FLAT_ORANGE kColorWithRGB(219, 140, 49, 1)
#define FLAT_ORANGERED kColorWithRGB(216, 81, 55, 1) 
#define FLAT_ROSERED kColorWithRGB(192, 51, 85, 1)
#define FLAT_PURPLE kColorWithRGB(127, 52, 100, 1)
#define FLAT_DARKPURPLE kColorWithRGB(66, 52, 63, 1)

@interface DemoViewController ()

@property (nonatomic, strong) NZHSwipeNavigationPageController *swipeSingleController;

@property (nonatomic, strong) NZHSwipeNavigationPageController *barOnNavigationBarController;

@property (nonatomic, strong) NZHSwipeNavigationPageController *customBottomSelectorController;

@property (nonatomic, strong) NZHSwipeNavigationPageController *customMiddleSelectorController;

@property (nonatomic, strong) NZHSwipeNavigationPageController *customAnimationSelectorController;

@property (nonatomic, strong) UIView *animationView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    [self.navigationController setNavigationBarHidden:YES];
    
    UIViewController *demo1 = [[UIViewController alloc]init];
    UIViewController *demo2 = [[UIViewController alloc]init];
    UIViewController *demo3 = [[UIViewController alloc]init];
    UIViewController *demo4 = [[UIViewController alloc]init];
    UIViewController *demo5 = [[UIViewController alloc]init];
    demo1.view.backgroundColor = FLAT_ORANGE;
    demo2.view.backgroundColor = FLAT_ORANGERED;
    demo3.view.backgroundColor = FLAT_ROSERED;
    demo4.view.backgroundColor = FLAT_PURPLE;
    demo5.view.backgroundColor = FLAT_DARKPURPLE;
    
    self.animationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 8)];
    self.animationView.backgroundColor = [UIColor redColor];
    self.animationView.layer.cornerRadius = 6.0;
    self.animationView.layer.opacity = 0.3;
    
    UIView *animationView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    animationView1.backgroundColor = [UIColor redColor];
    animationView1.layer.cornerRadius = 6.0;
    animationView1.layer.opacity = 0.3;
    
    UIView *animationView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    animationView2.backgroundColor = [UIColor redColor];
    animationView2.layer.cornerRadius = 6.0;
    animationView2.layer.opacity = 0.3;

    
    NSArray *viewControllerArray = @[demo1, demo2, demo3, demo4, demo5];
    NSArray *buttonTextArray = @[@"Home", @"Fund", @"Topic", @"Industry", @"Market"];
    
    
    
    
    
    
    
    self.swipeSingleController = [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" andButtonTitles:buttonTextArray barHeight:40 buttonWidth:70 controllers:viewControllerArray];
    
    self.barOnNavigationBarController =
    [[NZHSwipeNavigationPageController alloc]initForSwipeByNavigationBarWithSubTitles:buttonTextArray andControllers:viewControllerArray andButtonWidth:70];
    
    self.customBottomSelectorController = [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" andButtonTitles:buttonTextArray barHeight:40 buttonWidth:70 controllers:viewControllerArray];
    [self.customBottomSelectorController setFlatAnimationalSelector:self.animationView];
    
    self.customMiddleSelectorController = [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" andButtonTitles:buttonTextArray barHeight:40 buttonWidth:70 controllers:viewControllerArray];
    [self.customMiddleSelectorController setMiddleAnimationalSelector:animationView1];
    
    
    self.customAnimationSelectorController = [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" andButtonTitles:buttonTextArray barHeight:40 buttonWidth:70 controllers:viewControllerArray];
    [self.customAnimationSelectorController setMiddleAnimationalSelector:animationView2];
    __block NZHSwipeNavigationPageController *blockDemo = self.customAnimationSelectorController;
    self.customAnimationSelectorController.customAnimationBlock = ^(UIScrollView *pageScrollView) {
        CGFloat originSelectorHeight = 25;
        CGFloat changedSelectorHeight;
        if (blockDemo.positionRatio <= 0.5) {
            changedSelectorHeight = originSelectorHeight*(1-blockDemo.positionRatio);
        }else if (blockDemo.positionRatio > 0.5) {
            changedSelectorHeight = originSelectorHeight*blockDemo.positionRatio;
        }
        CGRect rect = CGRectMake(blockDemo.selectorX, blockDemo.selectorY, blockDemo.animationView.frame.size.width, changedSelectorHeight);
        blockDemo.animationView.frame = rect;
    };
    
    
    
    

    
//        self.swipeSingleController = [[NZHSwipeNavigationPageController alloc]initForSwipeByNavigationBarWithSubTitles:buttonTextArray andControllers:viewControllerArray andButtonWidth:50];
//        self.swipeSingleController.animationView.backgroundColor = [UIColor redColor];
    
    
    
    
//        [self.swipeSingleController setFlatAnimationalSelector:animationView];
    //    [self.swipeSingleController setMiddleAnimationalSelector:animationView];
    
    
    
//        __block NZHSwipeNavigationPageController *blockDemo = self.swipeSingleController;
//        swipeSingleController.customAnimationBlock = ^(UIScrollView *pageScrollView) {
//            CGFloat originSelectorHeight = 25;
//            CGFloat changedSelectorHeight;
//            if (blockDemo.positionRatio <= 0.5) {
//                changedSelectorHeight = originSelectorHeight*(1-blockDemo.positionRatio);
//            }else if (blockDemo.positionRatio > 0.5) {
//                changedSelectorHeight = originSelectorHeight*blockDemo.positionRatio;
//            }
//            CGRect rect = CGRectMake(blockDemo.selectorX, blockDemo.selectorY, blockDemo.animationView.frame.size.width, changedSelectorHeight);
//            blockDemo.animationView.frame = rect;
//        };
    // Do any additional setup after loading the view.
}

- (IBAction)deafultPattern:(UIButton *)sender {
    self.swipeSingleController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                   action:@selector(backToDemoViewController:)];
    [self presentViewController:self.swipeSingleController.navigationController animated:YES completion:nil];
}

- (IBAction)barOnNavigationBar:(UIButton *)sender {
    self.barOnNavigationBarController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                                                                                         style:UIBarButtonItemStylePlain
                                                                                                        target:self
                                                                                                        action:@selector(backToDemoViewController:)];
    [self presentViewController:self.barOnNavigationBarController.navigationController animated:YES completion:nil];

}

- (IBAction)toCustomBottomSelectorController:(UIButton *)sender {
    self.customBottomSelectorController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(backToDemoViewController:)];
    [self presentViewController:self.customBottomSelectorController.navigationController animated:YES completion:nil];
}

- (IBAction)toCustomMiddleSelectorController:(UIButton *)sender {
    self.customMiddleSelectorController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(backToDemoViewController:)];
    [self presentViewController:self.customMiddleSelectorController.navigationController animated:YES completion:nil];
}


- (IBAction)toCustomAnimationSelectorController:(UIButton *)sender {
    self.customAnimationSelectorController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(backToDemoViewController:)];
    [self presentViewController:self.customAnimationSelectorController.navigationController animated:YES completion:nil];
}


- (void)backToDemoViewController:(UIButton *)sender {
//    [(UINavigationController *)[self viewController:sender] dismissViewControllerAnimated:YES completion:nil];
    
    [self.swipeSingleController.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.barOnNavigationBarController.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.customBottomSelectorController.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.customMiddleSelectorController.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.customAnimationSelectorController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewController:(UIButton *)sender {
    for (UIView* next = [sender superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
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
