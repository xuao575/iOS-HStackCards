//
//  AppsCompositionalView.swift
//  App Store Style Snap-Scrolling Cards with NavigationStack Preview
//
//  整个逻辑和入口都放在一个文件里，包含 @main
//

import SwiftUI
import UIKit

// MARK: - 数据模型
struct LinkCardItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

// MARK: - 卡片视图
struct HighlightSquareView: View {
    let title: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.7))
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

// MARK: - 预览详情页
struct CardPreviewView: View {
    let title: String
    @Namespace private var dummyNamespace  // 只为兼容 iOS < 18

    var body: some View {
        VStack(spacing: 20) {
            HighlightSquareView(title: title)
                .frame(width: 300, height: 300)
            Text("这是 “\(title)” 的预览页面")
                .font(.title2)
            Spacer()
        }
        .padding()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - UIKit + Compositional Layout 控制器
final class CompositionalController: UICollectionViewController {
    private let cellID = "linkCardCell"
    private var items: [LinkCardItem]
    private let namespace: Namespace.ID
    /// 点击回调
    var onSelect: ((LinkCardItem) -> Void)?

    init(items: [LinkCardItem], namespace: Namespace.ID) {
        self.items = items
        self.namespace = namespace
        let layout = CompositionalController.createLayout()
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        applySnapshot()
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, LinkCardItem> = {
        UICollectionViewDiffableDataSource<Int, LinkCardItem>(collectionView: collectionView) { [weak self] cv, ip, item in
            guard let self = self else { return UICollectionViewCell() }
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: ip)
            // 使用 UIHostingConfiguration 嵌入 SwiftUI，并打上 matchedTransitionSource
            cell.contentConfiguration = UIHostingConfiguration {
                HighlightSquareView(title: item.title)
                    .matchedTransitionSource(id: item.id, in: self.namespace)
            }
            return cell
        }
    }()

    private func applySnapshot() {
        var snap = NSDiffableDataSourceSnapshot<Int, LinkCardItem>()
        snap.appendSections([0])
        snap.appendItems(items)
        dataSource.apply(snap, animatingDifferences: false)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        onSelect?(item)
    }

    /// Compositional Layout：250×250 正方形、水平分页吸附
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        .init { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let side: CGFloat = 250
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(side),
                heightDimension: .absolute(side)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(16)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 16, bottom: 0, trailing: 16
            )
            return section
        }
    }
}

// MARK: - Representable 包装
struct CompositionalUIView: UIViewControllerRepresentable {
    let items: [LinkCardItem]
    let namespace: Namespace.ID
    let onSelect: (LinkCardItem) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> CompositionalController {
        let vc = CompositionalController(items: items, namespace: namespace)
        vc.onSelect = { item in context.coordinator.parent.onSelect(item) }
        return vc
    }

    func updateUIViewController(_ uiViewController: CompositionalController, context: Context) {}

    class Coordinator {
        let parent: CompositionalUIView
        init(_ parent: CompositionalUIView) { self.parent = parent }
    }
}

// MARK: - SwiftUI 主视图 + NavigationStack
struct AppsCompositionalView: View {
    @Namespace private var transitionAnimation
    @State private var path: [LinkCardItem] = []

    private let sampleItems: [LinkCardItem] = (1...10).map {
        LinkCardItem(title: "Card \($0)")
    }

    var body: some View {
        NavigationStack(path: $path) {
            CompositionalUIView(
                items: sampleItems,
                namespace: transitionAnimation
            ) { selected in
                path.append(selected)
            }
            .navigationTitle("卡片列表")
            .navigationDestination(for: LinkCardItem.self) { item in
                if #available(iOS 18.0, *) {
                    CardPreviewView(title: item.title)
                        .navigationTransition(
                            .zoom(sourceID: item.id, in: transitionAnimation)
                        )
                } else {
                    CardPreviewView(title: item.title)
                }
            }
        }
    }
}

// MARK: - App 入口
@main
struct HStackCardsTestApp: App {
    var body: some Scene {
        WindowGroup {
            AppsCompositionalView()
        }
    }
}
