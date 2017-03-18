# Elissa

[![CI Status](http://img.shields.io/travis/KitchenStories/Elissa.svg?style=flat)](https://travis-ci.org/KitchenStories/Elissa)
[![Version](https://img.shields.io/cocoapods/v/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)
[![Platform](https://img.shields.io/cocoapods/p/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)

![](https://github.com/KitchenStories/Elissa/blob/master/images/Elissa_logo.png)

Attach a local notification to any UIView to reveal additional user guidance.

# Usage

## Example

![](https://github.com/KitchenStories/Elissa/blob/master/images/elissa_demo2.gif =320x)

Per default, Elissa will try to align to the center of the UITabBarItem. However she will never move out of sight to her parent’s view screen bounds. Therefor she applies an offset calculation that will also move the little arrow pointer accordingly.

![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_0.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_1.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_2.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_3.png)
![](https://github.com/KitchenStories/Elissa/blob/master/images/tabbar_item_4.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Configuration

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

## Presentation

As of now there are **two different API** calls for rendering Elissa depending on the specific use case that is preferred. When presenting Elissa on top of a UITabBarItem you present from an instance of UIViewController:

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
In this case Elissa is created and internally managed as a Singleton instance.

When attaching Elissa to any UIView you call the API from a containing view which owns an anchor view for Elissa (typically a parent => child relation):

```swift
myViewController.view.showELissa(fromSourceView: sourceView, configuration: elissaConfig) {
  // optionally do something
}
```

```objective-c
[myViewController.view showELissaFromSourceView:sourceView configuration: elissaConfig onTouchHandler:^{
  // optionally do something
}];
```

Please not that the latter API call creates and returns ***an instance*** of Elissa.


## Installation

### CocoaPods

Elissa is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Elissa"
```

### Carthage

To use Carthage, first make sure you have installed it and updated it to the latest version by following their instructions on [their repo](https://github.com/Carthage/Carthage).

First, you add `Elissa` to your `Cartfile`:

```
github "KitchenStories/Elissa"
```
Then, run Carthage:

```
carthage update
```

## Author

Kersten Broich, kersten.broich@gmail.com

## License

Elissa is available under the MIT license. See the LICENSE file for more info.
