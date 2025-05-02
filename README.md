# LinkCardsCompositionalView

## 简介

`LinkCardsCompositionalView` 是一个基于 **UICollectionViewCompositionalLayout** 与 **SwiftUI** 混合实现的横向分页吸附（snap-scrolling）卡片列表组件。它采用 UIKit 的 Compositional Layout 来管理卡片布局，并使用 `UIHostingConfiguration` 将 SwiftUI 的卡片视图嵌入到 UICollectionViewCell 中，实现了类似 App Store 推荐栏的流畅滑动体验。

## 功能

* **横向分页吸附滚动**：卡片宽度设为屏幕宽度的 80%，开启 `orthogonalScrollingBehavior = .groupPaging`，实现分页吸附。
* **SwiftUI 卡片**：通过 `HighlightSquareView` 自定义卡片外观，支持圆角、背景色和文本。
* **Diffable Data Source**：使用 `UICollectionViewDiffableDataSource` 动态管理数据，方便增删改。
* **无缝集成 SwiftUI**：借助 `UIHostingConfiguration`，在 UIKit 里直接展示 SwiftUI 视图。

## 要求

* iOS 14.0+
* Xcode 14.0+
* Swift 5.5+

## 安装与集成

1. 将 `AppsCompositionalView.swift` 拖入你的 Xcode 项目。
2. 在 `Info.plist` 中确保支持 SwiftUI 与 UIKit 混编。
3. 在合适的位置导入并使用：

   ```swift
   import SwiftUI

   struct ContentView: View {
       let items = (1...10).map { LinkCardItem(title: "Card \($0)") }
       
       var body: some View {
           AppsCompositionalView(items: items)
               .edgesIgnoringSafeArea(.all)
       }
   }
   ```

## 使用示例

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            let sample = (1...10).map { LinkCardItem(title: "Card \($0)") }
            AppsCompositionalView(items: sample)
        }
    }
}
```

## 自定义

* **调整卡片尺寸**：在 `createLayout()` 中修改 `groupSize` 的宽高比例或绝对值。
* **修改间距**：修改 `group.interItemSpacing` 或 `section.contentInsets`。
* **更换卡片样式**：编辑 `HighlightSquareView`，替换背景、文字、交互等。

## 许可证

MIT © 2025 Ao XU
