import Foundation

class StationLoader {
    static func loadStations() -> [SubwayStation] {
        guard let url = Bundle.main.url(forResource: "stations", withExtension: "json") else {
            print("🚫 stations.json 파일을 찾을 수 없습니다.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            print("✅ JSON 파일 로드 성공: \(url)")
            let stations = try JSONDecoder().decode([SubwayStation].self, from: data)
            print("✅ JSON 파싱 성공, 총 \(stations.count)개 역")
            return stations
        } catch {
            print("❌ JSON 파싱 에러: \(error)")
            return []
        }
    }
}
