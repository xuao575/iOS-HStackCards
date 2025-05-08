import SwiftUI
import UIKit

// MARK: - 数据模型
struct LinkCardItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

// MARK: - SwiftUI 详情页
struct DetailView: View {
    let title: String
    var body: some View {
        VStack {
            Text("这是 \(title) 的详情页")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle(title)
    }
}

// MARK: - SwiftUI 卡片视图
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

// MARK: - UIKit + Compositional Layout 控制器
final class CompositionalController: UICollectionViewController {
    private let cellID = "linkCardCell"
    private var items: [LinkCardItem]

    // Diffable Data Source
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, LinkCardItem> = {
        UICollectionViewDiffableDataSource<Int, LinkCardItem>(collectionView: collectionView) { cv, ip, item in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: ip)
            cell.contentConfiguration = UIHostingConfiguration {
                HighlightSquareView(title: item.title)
            }
            return cell
        }
    }()

    // 构造器传入数据
    init(items: [LinkCardItem]) {
        self.items = items
        let layout = CompositionalController.createLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        applySnapshot()
        // 确保自己成为 delegate
        collectionView.delegate = self
    }

    private func applySnapshot() {
        var snap = NSDiffableDataSourceSnapshot<Int, LinkCardItem>()
        snap.appendSections([0])
        snap.appendItems(items)
        dataSource.apply(snap, animatingDifferences: false)
    }

    // MARK: —— 点击处理 ——
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        // 用 SwiftUI 的 DetailView 包装成 UIViewController
        let detailVC = UIHostingController(rootView: DetailView(title: item.title))
        detailVC.title = item.title
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // 布局：80% 宽度、200pt 高度、水平分页正交滚动
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        .init { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let sideLength: CGFloat = 250
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(sideLength),
                heightDimension: .absolute(sideLength)
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

// MARK: - SwiftUI 封装
struct AppsCompositionalView: UIViewControllerRepresentable {
    let items: [LinkCardItem]

    func makeUIViewController(context: Context) -> UIViewController {
        // 注意已经在这里创建了 UINavigationController
        UINavigationController(rootViewController: CompositionalController(items: items))
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - App 入口
@main
struct HStackCardsTestApp: App {
    private let sampleItems: [LinkCardItem] = (1...10).map {
        LinkCardItem(title: "Card \($0)")
    }

    var body: some Scene {
        WindowGroup {
            AppsCompositionalView(items: sampleItems)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
