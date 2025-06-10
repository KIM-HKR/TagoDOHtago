import Foundation

class PresetManager: ObservableObject {
    @Published var presets: [String] = []
    private let key = "PresetStations"
    private let allStations: [String] = [
        "서울역", "신도림", "강남", "왕십리", "건대입구", // ✅ 여기에 실제 존재하는 역 이름 전체 추가 필요
        "잠실", "삼성", "홍대입구", "시청", "동대문"
    ]

    init() {
        loadPresets()
    }

    func loadPresets() {
        presets = UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func addPreset(_ station: String) {
        guard !presets.contains(station), allStations.contains(station) else { return }
        presets.append(station)
        UserDefaults.standard.set(presets, forKey: key)
    }

    func removePreset(_ station: String) {
        presets.removeAll { $0 == station }
        UserDefaults.standard.set(presets, forKey: key)
    }

    func getSuggestions(for query: String) -> [String] {
        guard !query.isEmpty else { return [] }
        return allStations.filter { $0.contains(query) && !presets.contains($0) }
    }
}
