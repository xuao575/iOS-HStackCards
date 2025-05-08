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
                // 上方标题：最多 4 行
                Text(paper.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(4)
                    .truncationMode(.middle)

                // 下方作者：最多 3 行
                Text(paper.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
