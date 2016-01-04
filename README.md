# NZHSwipeNavigationPageController
NZHSwipeNavigationPageController can create a navigation bar favourably and simply with high customizability.

# Installation
### CocoaPods
1. Add `pod "NZHSwipeNavigationPageController"` to your Podfile.
2. Run `pod install` or pod update.
3. Include wherever you need it with `#import "NZHSwipeNavigationPageController"`.

### Manually
1. Download all the files in the `NZHSwipeNavigationPageController`.
2. Add the source files folder to your Xcode project.
3. Include wherever you need it with `#import "NZHSwipeNavigationPageController"`.

# Features
* As a container to manage several controllers.
* Generate a navigation bar automatically which you can choose in many styles.
* Carry several foundational animation types of page selector.
* With a high customizability for everything in navigation bar.

# Usage

NZHSwipeNavigationPageController is a container for controllers, so we need arrays with controllers, button titles and some parameters  for example.
```objectivec
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
    
    NSArray *viewControllerArray = @[demo1, demo2, demo3, demo4, demo5];
    NSArray *buttonTextArray = @[@"Home", @"Fund", @"Topic", @"Industry", @"Market"];
```
---
![onNavigation](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/onNavigationBar.gif?raw=true)

```objectivec
    NZHSwipeNavigationPageController *barOnNavigationBarController = 
    [[NZHSwipeNavigationPageController alloc]initForSwipeByNavigationBarWithSubTitles:buttonTextArray 
                                                                       andControllers:viewControllerArray 
                                                                       andButtonWidth:70];
```

![deafultPattern](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/deafultPattern.gif?raw=true)

```objectivec
    NZHSwipeNavigationPageController *deafultPatternController = 
    [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" 
                                                                andButtonTitles:buttonTextArray 
                                                                      barHeight:40 
                                                                    buttonWidth:70 
                                                                    controllers:viewControllerArray];
```

![bottomSelector](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/customBottomSelector.gif?raw=true)

```objectivec
    //an arbitrary view for custom selector.
    UIView *selectorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 8)];
    selectorView.backgroundColor = [UIColor redColor];
    selectorView.layer.cornerRadius = 6.0;
    selectorView.layer.opacity = 0.3;

    NZHSwipeNavigationPageController *customBottomSelectorController = 
    [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" 
                                                                andButtonTitles:buttonTextArray 
                                                                      barHeight:40 
                                                                    buttonWidth:70 
                                                                    controllers:viewControllerArray];
    [customBottomSelectorController setFlatAnimationalSelector:selectorView];
```

![middleSelector](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/customMiddleSelector.gif?raw=true)

```objectivec
    //an arbitrary view for custom selector.
    UIView *selectorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    selectorView.backgroundColor = [UIColor redColor];
    selectorView.layer.cornerRadius = 6.0;
    selectorView.layer.opacity = 0.3;
    
    NZHSwipeNavigationPageController *customMiddleSelectorController = 
    [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" 
                                                                andButtonTitles:buttonTextArray 
                                                                      barHeight:40 
                                                                    buttonWidth:70 
                                                                    controllers:viewControllerArray];
    [customMiddleSelectorController setMiddleAnimationalSelector:selectorView];
```

![customAnimation](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/customAnimationSelector.gif?raw=true)
```objectivec
    //an arbitrary view for custom selector.
    UIView *selectorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    selectorView.backgroundColor = [UIColor redColor];
    selectorView.layer.cornerRadius = 6.0;
    selectorView.layer.opacity = 0.3;
    
    NZHSwipeNavigationPageController *customAnimationSelectorController = 
    [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"Decision" 
                                                                andButtonTitles:buttonTextArray 
                                                                      barHeight:40 
                                                                    buttonWidth:70 
                                                                    controllers:viewControllerArray];
    [customAnimationSelectorController setMiddleAnimationalSelector:selectorView];
    
    /*
     * positionRatio is a float from 0 to 1 which is the progress between swiping from one button to another button next to.
     * you can change the shape of selector bwteen its changing period in this block.
     */
    __block NZHSwipeNavigationPageController *blockDemo = customAnimationSelectorController;
    customAnimationSelectorController.customAnimationBlock = ^(UIScrollView *pageScrollView) {
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

```
