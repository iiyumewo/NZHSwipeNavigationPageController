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

![image](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/onNavigationBar.gif?raw=true)

![image](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/deafultPattern.gif?raw=true)

![image](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/customBottomSelector.gif?raw=true)

![image](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/customMiddleSelector.gif?raw=true)

![image](https://github.com/iiyumewo/NZHSwipeNavigationPageController/blob/master/NZHSwipeNavigationPageControllerDemo/ImageForDemo&README/customAnimationSelector.gif?raw=true)
