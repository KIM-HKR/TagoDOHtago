import Foundation

//struct ArrivalResponse: Codable {
  //  let realtimeArrivalList: [SubwayArrival]
//}

struct SubwayArrival: Codable, Identifiable {
    let id = UUID()
    let subwayId: String
    let trainLineNm: String
    let arvlMsg2: String
    let barvlDt: String
}
