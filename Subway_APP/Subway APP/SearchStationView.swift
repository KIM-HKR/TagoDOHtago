import SwiftUI

struct SearchStationView: View {
    @State private var query = ""
    @State private var stations: [SubwayStation] = StationLoader.loadStations()
    @ObservedObject private var favoriteManager = FavoriteManager.shared

    var filteredStations: [SubwayStation] {
        var result: [SubwayStation] = []
        var seen = Set<String>()
        let lineOrder = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "경의중앙", "경춘", "수인분당", "신분당", "우이신설"]

        let filtered = query.isEmpty ? stations : stations.filter { $0.name.contains(query) }

        for station in filtered {
            let lines = station.line.components(separatedBy: ",")
            for line in lines {
                let key = "\(station.name)-\(line)"
                if !seen.contains(key) {
                    seen.insert(key)
                    let splitStation = SubwayStation(name: station.name, line: line, code: station.code)
                    result.append(splitStation)
                }
            }
        }

        return result.sorted {
            let line1 = $0.line.trimmingCharacters(in: .whitespaces)
            let line2 = $1.line.trimmingCharacters(in: .whitespaces)

            let l1 = lineOrder.firstIndex(of: line1) ?? Int.max
            let l2 = lineOrder.firstIndex(of: line2) ?? Int.max

            if l1 != l2 {
                return l1 < l2
            } else {
                let c1 = Int($0.code) ?? 0
                let c2 = Int($1.code) ?? 0
                return c1 < c2
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("지하철역 검색", text: $query)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding([.horizontal, .top])

                List(filteredStations) { station in
                    NavigationLink(destination: RealtimeScheduleView(selectedStation: station.name)) {
                        HStack {
                            Image("line\(station.line)")
                                .resizable()
                                .frame(width: 28, height: 28)

                            Text(station.name)
                                .font(.body)
                                .padding(.leading, 8)

                            Spacer()

                            Button(action: {
                                favoriteManager.toggle(name: station.name, line: station.line)
                            }) {
                                Image(systemName: favoriteManager.isFavorite(name: station.name, line: station.line) ? "star.fill" : "star")
                                    .foregroundColor(favoriteManager.isFavorite(name: station.name, line: station.line) ? .yellow : .gray)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("지하철역 검색")
        }
    }
}
