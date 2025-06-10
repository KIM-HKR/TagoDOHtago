import SwiftUI

struct NoticeBoardView: View {
    @StateObject private var viewModel = NoticeBoardViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.notices) { notice in
                VStack(alignment: .leading, spacing: 4) {
                    Text(notice.title)
                        .font(.headline)
                    Text(notice.content)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(formattedDate(notice.timestamp))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("공지사항")
        }
        .onAppear {
            viewModel.fetchNotices()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        return formatter.string(from: date)
    }
}

