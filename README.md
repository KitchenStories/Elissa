# Elissa

[![CI Status](http://img.shields.io/travis/Kersten Broich/Elissa.svg?style=flat)](https://travis-ci.org/Kersten Broich/Elissa)
[![Version](https://img.shields.io/cocoapods/v/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)
[![License](https://img.shields.io/cocoapods/l/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)
[![Platform](https://img.shields.io/cocoapods/p/Elissa.svg?style=flat)](http://cocoapods.org/pods/Elissa)

![](https://github.com/KitchenStories/Elissa/blob/master/images/Elissa_logo.png.png)

Display a notification on top of a UITabBarItem to reveal additional user guidance.

## Usage

You can display Elissa according to your app’s theming by creating and passing a fully customisable configuration.

```
var elissaConfig = ElissaConfiguration()
elissaConfig.message = "Find your favorites here"
elissaConfig.image = UIImage(named: "heartIcon") ?? UIImage()
elissaConfig.font = UIFont.systemFontOfSize(17)
elissaConfig.textColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1.0)
elissaConfig.backgroundColor = UIColor(red: 241/255, green: 215/255, blue: 85/255, alpha: 1.0)
```

Presenting Elissa is as simple as that:

```
showElissaFromTabbar(itemIndex: 4, configuration: elissaConfig) { [weak self] in
            self?.dismissElissa()
        }
```

Additionally (and optionally) you can pass a closure that is executed once the user taps the notification.

## Example

![](https://github.com/KitchenStories/Elissa/blob/master/images/elissa_demo.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

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
