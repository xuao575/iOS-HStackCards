import SwiftUI

@main
struct PlateCarouselApp: App {
    // 示例占位数据
    private let plates: [PlateItem] = (1...10).map { idx in
        PlateItem(papers: [
            Paper(title: "论文标题 \(idx).1", author: "作者 A\(idx)"),
            Paper(title: "论文标题 \(idx).2", author: "作者 B\(idx)"),
            Paper(title: "论文标题 \(idx).3", author: "作者 C\(idx)")
        ])
    }

    var body: some Scene {
        WindowGroup {
            PlateCarouselView(plateItems: plates)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
