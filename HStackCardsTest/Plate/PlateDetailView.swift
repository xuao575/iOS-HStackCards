//
//  PlateDetailView.swift
//  HStackCardsTest
//
//  Created by Ao XU on 5/9/25.
//


import SwiftUI

/// Plate 详情页（列表形式）
public struct PlateDetailView: View {
    let papers: [Paper]

    public init(papers: [Paper]) {
        self.papers = papers
    }

    public var body: some View {
        List(papers) { paper in
            VStack(alignment: .leading, spacing: 4) {
                Text(paper.title)
                    .font(.headline)
                Text(paper.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("Plate 详情")
    }
}
