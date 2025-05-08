import SwiftUI
import UIKit

// MARK: - 数据模型
struct PlateItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

// MARK: - SwiftUI 详情页
struct PlateDetailView: View {
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
struct PlateItemView: View {
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

// MARK: - UICollectionViewController（卡片走马灯）
final class PlateCarouselViewController: UICollectionViewController {
    private let cellIdentifier = "PlateCell"
    private var PlateItems: [PlateItem]

    // Diffable Data Source
    private lazy var dataSource = UICollectionViewDiffableDataSource<Int, PlateItem>(collectionView: collectionView) { cv, ip, Plate in
        let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: ip)
        cell.contentConfiguration = UIHostingConfiguration {
            PlateItemView(title: Plate.title)
        }
        return cell
    }

    init(PlateItems: [PlateItem]) {
        self.PlateItems = PlateItems
        let layout = PlateCarouselViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PlateItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(PlateItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: —— 点击跳转 ——
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = PlateItems[indexPath.item]
        let detailVC = UIHostingController(rootView: PlateDetailView(title: selected.title))
        detailVC.title = selected.title
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // 布局：250pt×250pt 卡片、16pt 间距、水平分页正交滚动
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(250),
                heightDimension: .absolute(250)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(16)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
    }
}

// MARK: - SwiftUI 封装
struct PlateCarouselView: UIViewControllerRepresentable {
    let PlateItems: [PlateItem]

    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: PlateCarouselViewController(PlateItems: PlateItems))
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - App 入口
@main
struct PlateCarouselApp: App {
    private let Plates = (1...10).map { PlateItem(title: "Plate \($0)") }

    var body: some Scene {
        WindowGroup {
            PlateCarouselView(PlateItems: Plates)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
