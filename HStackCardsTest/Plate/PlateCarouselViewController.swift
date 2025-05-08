//
//  PlateCarouselViewController.swift
//  HStackCardsTest
//
//  Created by Ao XU on 5/9/25.
//


import UIKit
import SwiftUI

/// UICollectionViewController（Plate 走马灯）
public final class PlateCarouselViewController: UICollectionViewController {
    private let cellIdentifier = "PlateCell"
    private var plateItems: [PlateItem]

    public init(plateItems: [PlateItem]) {
        self.plateItems = plateItems
        super.init(collectionViewLayout: Self.createLayout())
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )

        // —— 新增两行 ——
        // 2. 禁用系统自动 SafeArea inset（否则会往上下塞额外 inset）
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior =  .automatic
        }
        // 3. 只允许横向弹性，不让竖向滚动/弹性
        collectionView.alwaysBounceVertical = false

        collectionView.delegate = self
        collectionView.allowsSelection = false
        applySnapshot()
    }

    private lazy var dataSource = UICollectionViewDiffableDataSource<Int, PlateItem>(
        collectionView: collectionView
    ) { [weak self] cv, ip, plate in
        guard let self = self else { return UICollectionViewCell() }
        let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: ip)
        cell.contentConfiguration = UIHostingConfiguration {
            HStack(alignment: .top) {
                PaperPlateView(papers: plate.papers) { tapped in
                    self.showSinglePaperDetail(paper: tapped)
                }
                Spacer()
            }
            // 控制卡片间距
            .padding(.leading, -16)
        }
        return cell
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PlateItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(plateItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func showSinglePaperDetail(paper: Paper) {
        let detailVC = UIHostingController(
            rootView: SinglePaperDetailView(paper: paper)
        )
        detailVC.title = paper.title
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(300),
                heightDimension: .estimated(400)           // ← 用估算值（比你预期的内容略大即可）
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize, subitems: [item]
            )
            group.interItemSpacing = .fixed(16)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            // 修改卡片偏移
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 16, leading: 32, bottom: 16, trailing: 16
            )
            return section
        }
    }
}
