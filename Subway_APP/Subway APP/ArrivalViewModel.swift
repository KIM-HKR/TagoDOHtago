import Foundation
import Combine

class ArrivalViewModel: ObservableObject {
    @Published var arrivals: [ArrivalInfo]? = nil
    @Published var isLoading = false

    func fetchArrivalInfo(for stationName: String) {
        let apiKey = "6c546c6d58676f6f38346d6f674e4f"
        let urlStr = "http://swopenapi.seoul.go.kr/api/subway/\(apiKey)/json/realtimeStationArrival/0/10/\(stationName)"

        guard let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encoded) else {
            print("❌ URL 생성 실패: \(urlStr)")
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                print("❌ 네트워크 오류: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ 응답 형식 오류")
                return
            }

            guard httpResponse.statusCode == 200 else {
                print("❌ 서버 응답 코드: \(httpResponse.statusCode)")
                return
            }

            guard let data = data else {
                print("❌ 데이터 없음")
                return
            }

            do {
                let result = try JSONDecoder().decode(ArrivalResponse.self, from: data)
                DispatchQueue.main.async {
                    self.arrivals = result.realtimeArrivalList
                }
            } catch {
                print("❌ JSON 파싱 실패: \(error)")
                if let jsonStr = String(data: data, encoding: .utf8) {
                    print("📦 응답 원본:\n\(jsonStr)")
                }
            }
        }.resume()
    }
}

// 📦 이 구조체는 이 파일 안에만 존재해야 함 (중복 금지!)
struct ArrivalResponse: Codable {
    let realtimeArrivalList: [ArrivalInfo]
}
