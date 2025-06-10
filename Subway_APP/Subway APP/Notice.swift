import Foundation
import FirebaseFirestoreSwift

struct Notice: Identifiable, Codable {
    @DocumentID var id: String?           // 문서 ID 자동 매핑
    let title: String
    let content: String
    let timestamp: Date
}
