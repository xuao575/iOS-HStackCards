import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

@main
struct PlateCarouselApp: App {
    private let plates: [PlateItem] = samplePapers
        .chunked(into: 3)
        .map { PlateItem(papers: $0) }

    var body: some Scene {
        WindowGroup {
            PlateCarouselView(plateItems: plates)
                .frame(height: 400)      // ← 这里给一个合适的高度
        }
    }
}
