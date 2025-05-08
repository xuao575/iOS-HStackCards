//
//  PaperPlateView.swift
//  HStackCardsTest
//
//  Created by Ao XU on 5/9/25.
//


import SwiftUI

/// Plate 视图：一列 3 个 PaperRowView
public struct PaperPlateView: View {
    let papers: [Paper]            // 恰好 3 条
    let onPaperTap: (Paper) -> Void

    public init(papers: [Paper], onPaperTap: @escaping (Paper) -> Void) {
        self.papers = papers
        self.onPaperTap = onPaperTap
    }

    public var body: some View {
        VStack(spacing: 0) {
            ForEach(papers) { paper in
                PaperRowView(paper: paper, onTap: onPaperTap)
                if paper.id != papers.last?.id {
                    Divider()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
