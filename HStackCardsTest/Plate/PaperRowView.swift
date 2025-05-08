//
//  PaperRowView.swift
//  HStackCardsTest
//
//  Created by Ao XU on 5/9/25.
//


import SwiftUI

/// 单行论文展示，可点击
public struct PaperRowView: View {
    let paper: Paper
    let onTap: (Paper) -> Void

    public init(paper: Paper, onTap: @escaping (Paper) -> Void) {
        self.paper = paper
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: { onTap(paper) }) {
            VStack(alignment: .leading, spacing: 4) {
                Text(paper.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(paper.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
