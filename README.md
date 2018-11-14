![SwiftToolBox](https://github.com/hackjie/SwiftToolBox/blob/master/Resources/SwiftToolBox.png)


日常工作中，很多问题的解决方法是可复用的，就像是一个工具箱，齐全稳定的工具可以帮助开发者快速的开发迭代版本，这里记录常用的方法进工具箱，因为现在主要是用 Swift 开发，所以工具箱里面的实现也会以 Swift 为主，希望这个库可以帮助更多的开发者：）

因为需求不同，这里不会做成 Cocoapods 或者 Carthage, 根据需求挑选合适的类即可：）

## 版本

暂时使用 Swift 4.0 

## 系统类扩展

| 系统类 | 问题描述 | 解决类 | 备注 |
| --- | --- | --- | --- |
| String | 本地化 | String+Localized.swift |  |
|  | 格式化字符串 | String+Format.swift |  |
|  | 检查字符串格式 | String+Check.swift |  |
| UIView | 为视图添加弱网效果 | UIView+Windless.swift |  |
|  | Frame 操作 | UIView+Frame.swift |  |
|  | 便捷操作 | UIView+Helper.swift |  |
|  | 绘图操作 | UIView+Draw.swift |  |
| UITableView | 注册、加载视图方法 | UITableView+Nib.swift |  |
| UILabel | 计算高度/附加字符串 | UILabel+Extensions.swift |  |
| UIImage | 图片操作 | UIImage+Extensions.swift |  |
| UIColor | 颜色操作 | UIColor+Colors.swift |  |
| UINavigationController | 隐藏导航栏 | UINavigationController+Navbar.h | OC |
|  | 导航控制器操作 | UINavigationController+Extension.swift |  |
| UITapGestureRecognizer | 点击 UILabel 中属性字符串 | UITapGestureRecognizer+Extension.swift |  |


## 参与人

[hackjie](https://github.com/hackjie) [Bruce Li](https://github.com/SilongLi) [FMYang](https://github.com/FMYang) [tao.ding](https://github.com/pamierdt)

