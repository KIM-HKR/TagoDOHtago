import Foundation

struct ArrivalInfo: Codable, Identifiable {
    var id: UUID { UUID() }

    let destination: String
    let direction: String
    let message: String
    let remainSeconds: String  

    enum CodingKeys: String, CodingKey {
        case destination = "trainLineNm"
        case direction = "updnLine"
        case message = "arvlMsg2"
        case remainSeconds = "barvlDt"
    }
}
