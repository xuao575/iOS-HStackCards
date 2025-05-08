import SwiftUI
import UIKit

/// SwiftUI 封装：挂载 UIKit 控制器
public struct PlateCarouselView: UIViewControllerRepresentable {
    let plateItems: [PlateItem]

    public init(plateItems: [PlateItem]) {
        self.plateItems = plateItems
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(
            rootViewController: PlateCarouselViewController(plateItems: plateItems)
        )
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
