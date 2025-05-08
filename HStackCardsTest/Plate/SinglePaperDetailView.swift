//
//  SinglePaperDetailView.swift
//  HStackCardsTest
//
//  Created by Ao XU on 5/9/25.
//


import SwiftUI

/// 单篇论文的详情页
public struct SinglePaperDetailView: View {
    let paper: Paper

    public init(paper: Paper) {
        self.paper = paper
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(paper.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("作者：\(paper.author)")
                .font(.title2)
            Spacer()
        }
        .padding()
        .navigationTitle("论文详情")
    }
}
