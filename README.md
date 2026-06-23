# 私人记账理财 (SwiftUI 起步模板)

这是一个使用 SwiftUI 的 iOS 应用骨架，作为私人记账与理财工具的起点。它包含：

- 简单的数据模型：Transaction, Account, Category
- 基于 JSON 的本地持久化（便于测试与替换）
- MVVM 风格的 ViewModel
- 基本界面：交易列表、添加交易表单、余额计算

注意：在 Windows 上不能构建 iOS 应用。请在 macOS 上用 Xcode 打开本项目文件夹并创建一个新的 Xcode 项目，然后将 Sources 中的 Swift 文件添加到项目中。下面说明如何继续。

快速开始（在 macOS 上的 Xcode）：

1. 在 Xcode 中创建一个新的 iOS App（SwiftUI）。
2. 将 `Models`, `Services`, `ViewModels`, `Views` 目录下的 Swift 文件添加到 Xcode 项目中。
3. 在 `@main` App 文件中引入 `ContentView()` 作为启动内容。

改进与下一步建议：

- 用 Core Data 或 SQLite 替换 JSON 持久化
- 添加类别管理、报表与图表（Charts 框架）
- 添加 iCloud 或 CloudKit 同步
- 添加安全入口（Face ID / Touch ID）

文件列表：

- `AppEntry.swift` - 应用入口（@main）
- `Models/Transaction.swift` - 交易模型
- `Models/Account.swift` - 账户模型
- `Models/Category.swift` - 类别模型
- `Services/Storage.swift` - JSON 存储服务
- `ViewModels/TransactionListViewModel.swift` - 交易列表视图模型
- `Views/ContentView.swift` - 交易列表视图
- `Views/AddTransactionView.swift` - 添加交易表单

图标与 PWA
----------------
为了让“添加到主屏幕”显示好看的图标，请生成 PNG 格式的图标并放在项目根目录。下面示例使用 ImageMagick（`magick` 命令），也可以使用在线工具或设计软件。

建议尺寸：16x16, 32x32, 120x120, 152x152, 167x167, 180x180, 192x192, 512x512

PowerShell+ImageMagick 示例（在项目目录运行）：

```powershell
# 将 SVG 渲染为不同尺寸 PNG
magick icon.svg -resize 512x512 icon-512.png
magick icon.svg -resize 192x192 icon-192.png
magick icon.svg -resize 180x180 icon-180.png
magick icon.svg -resize 167x167 icon-167.png
magick icon.svg -resize 152x152 icon-152.png
magick icon.svg -resize 120x120 icon-120.png
magick icon.svg -resize 32x32 icon-32.png
magick icon.svg -resize 16x16 icon-16.png
```

将生成的文件 `icon-*.png` 和 `favicon-16.png`/`favicon-32.png` 放到仓库根目录并 commit & push。

如果你不想安装 ImageMagick，可以使用在线 SVG 转 PNG 工具（搜索 "svg to png converter"），下载对应尺寸并重命名为上面文件名。
