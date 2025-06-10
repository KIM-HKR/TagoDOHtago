import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class NoticeBoardViewModel: ObservableObject {
    @Published var notices: [Notice] = []

    private var db = Firestore.firestore()

    func fetchNotices() {
        db.collection("notices")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Firestore 오류: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("❌ 문서 없음")
                    return
                }

                do {
                    self.notices = try documents.map { try $0.data(as: Notice.self) }
                } catch {
                    print("❌ 디코딩 실패: \(error.localizedDescription)")
                }
            }
    }
}
