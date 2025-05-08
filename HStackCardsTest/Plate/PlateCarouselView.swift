import SwiftUI
import UIKit

/// SwiftUI 封装：挂载 UIKit 控制器
public struct PlateCarouselView: UIViewControllerRepresentable {
    let plateItems: [PlateItem]

    public init(plateItems: [PlateItem]) {
        self.plateItems = plateItems
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        let plateVC = PlateCarouselViewController(plateItems: plateItems)
        let nav = UINavigationController(rootViewController: plateVC)
        // ← 在这里隐藏它自带的导航栏
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
