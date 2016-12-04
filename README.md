# Elissa

[![CI Status](http://img.shields.io/travis/KitchenStories/Elissa.svg?style=flat)](https://travis-ci.org/KitchenStories/Elissa)
[![Version](https://img.shields.io/cocoapods/v/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)
[![License](https://img.shields.io/cocoapods/l/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)
[![Platform](https://img.shields.io/cocoapods/p/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)

![](https://github.com/KitchenStories/Elissa/blob/master/images/Elissa_logo.png)

Display a notification on top of a UITabBarItem to reveal additional user guidance.

## Usage

You can display Elissa according to your app’s theming by creating and passing a fully customisable configuration.

```swift
var elissaConfig = ElissaConfiguration()
elissaConfig.message = "Find your favorites here"
elissaConfig.image = UIImage(named: "heartIcon") ?? UIImage()
elissaConfig.font = UIFont.systemFontOfSize(17)
elissaConfig.textColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1.0)
elissaConfig.backgroundColor = UIColor(red: 241/255, green: 215/255, blue: 85/255, alpha: 1.0)
```

```objective-c
ElissaConfiguration *elissaConfig = [ElissaConfiguration new];
elissaConfig.message = @"Find your favorites here";
elissaConfig.image = [UIImage imageNamed:@"heartIcon"];
elissaConfig.font = [UIFont systemFontOfSize:17];
elissaConfig.textColor = [UIColor redColor];
elissaConfig.backgroundColor = [UIColor greenColor];
```

Presenting Elissa is as simple as that:

```swift
showElissaFromTabbar(at: 4, configuration: elissaConfig) {            
    Elissa.dismiss()
}
```

```objective-c
[self showElissaFromTabbarAt:0 configuration:elissaConfig onTouchHandler:^{
    [Elissa dismiss];
}];
```

Additionally (and optionally) you can pass a closure that is executed once the user taps the notification.

## Example

![](https://github.com/KitchenStories/Elissa/blob/master/images/elissa_demo.gif)

Per default, Elissa will try to align to the center of the UITabBarItem. However she will never move out of sight to her parent’s view screen bounds. Therefor she applies an offset calculation that will also move the little arrow pointer accordingly.

![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_0.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_1.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_2.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_3.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_4.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Elissa is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Elissa"
```

## Author

Kersten Broich, kersten.broich@kitchenstories.de

## License

Elissa is available under the MIT license. See the LICENSE file for more info.
