//
//  Paper.swift
//  HStackCardsTest
//
//  Created by Ao XU on 5/9/25.
//

import Foundation

/// 单篇论文模型
public struct Paper: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let author: String
    public let link: URL

    public init(title: String, author: String, link: URL) {
        self.title = title
        self.author = author
        self.link = link
    }
}

/// Plate 单元模型，包含 3 篇论文
public struct PlateItem: Identifiable, Hashable {
    public let id = UUID()
    public let papers: [Paper]

    public init(papers: [Paper]) {
        self.papers = papers
    }
}
