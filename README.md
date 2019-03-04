## CheckVersion_Swift

[CheckVersion_Swift](https://github.com/821385843/CheckVersion_Swift) 是一款轻量级的 `Swift` 版本的框架，框架功能：根据 `Apple` 提供的 `API` 去请求 `JSON` ，根据 `JSON` 中的版本号决定是否去更新原生 `App`。更新提示的内容可以自定义，也可以是 `JSON` 中给的内容。

## 写作 `CheckVersion_Swift` 框架初衷

通常在做 `App` 版本检查更新功能的时候，都是后台服务器为我们提供一个获取 `App` 最新版本信息的接口，并且在每次新版本更新后，都需要人工在后台更改版本信息，费事且不及时。
其实苹果提供了一个很友好的 `iTunes` 接口，供我们获取 `App Store` 中 `App` 当前的最新信息。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CheckVersion_Swift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CheckVersion_Swift'
```

## License

CheckVersion_Swift is available under the MIT license. See the LICENSE file for more info.

## Author

如果你有什么建议，可以关注我的公众号：`iOS开发者进阶`，直接留言，留言必回。

![输入图片说明](https://github.com/821385843/RSA_Swift/blob/master/Example/RSA_Swift/test_file_md5.png "在这里输入图片标题")
