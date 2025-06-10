import SwiftUI

struct RealtimeScheduleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedStation: String
    @State private var arrivals: [ArrivalInfo] = []
    @State private var showToast = true

    let allStations: [SubwayStation] = StationLoader.loadStations()
    private let apiKey = "6c546c6d58676f6f38346d6f674e4f"

    var body: some View {
        VStack(spacing: 0) {
            // 🔙 뒤로가기 버튼 (왼쪽 상단에 따로 배치)
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
                .padding(.leading)
                Spacer()
            }
            .padding(.top, 8)

            // 📍 역 이름 + 이전/다음 버튼
            HStack {
                Button(action: {
                    moveToPreviousStation()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text(previousStationName)
                            .font(.caption)
                    }
                }
                .disabled(currentIndex == 0)

                Spacer()

                Text(selectedStation)
                    .font(.title2)
                    .bold()

                Spacer()

                Button(action: {
                    moveToNextStation()
                }) {
                    HStack {
                        Text(nextStationName)
                            .font(.caption)
                        Image(systemName: "chevron.right")
                    }
                }
                .disabled(currentIndex == allStations.count - 1)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)

            Divider()

            ScrollView {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(arrivals.filter { $0.direction == "상행" }) { arrival in
                            ArrivalCardView(arrival: arrival)
                        }
                    }
                    Spacer(minLength: 16)
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(arrivals.filter { $0.direction == "하행" }) { arrival in
                            ArrivalCardView(arrival: arrival)
                        }
                    }
                }
                .padding()
            }

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(selectedStation)역 도착정보")
        .overlay(
            Group {
                if showToast {
                    VStack {
                        Spacer()
                        Text("🚇 \(selectedStation)역이 선택되었습니다.")
                            .font(.caption)
                            .padding(10)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                            .padding(.bottom, 20)
                            .transition(.opacity)
                            .animation(.easeInOut, value: showToast)
                    }
                }
            }
        )
        .onAppear {
            fetchArrivals(for: selectedStation)
            showToastTemporarily()
        }
    }

    var currentIndex: Int {
        allStations.firstIndex(where: { $0.name == selectedStation }) ?? 0
    }

    var previousStationName: String {
        if currentIndex > 0 {
            return allStations[currentIndex - 1].name
        }
        return ""
    }

    var nextStationName: String {
        if currentIndex < allStations.count - 1 {
            return allStations[currentIndex + 1].name
        }
        return ""
    }

    func moveToPreviousStation() {
        let newIndex = max(0, currentIndex - 1)
        selectedStation = allStations[newIndex].name
        fetchArrivals(for: selectedStation)
        showToastTemporarily()
    }

    func moveToNextStation() {
        let newIndex = min(allStations.count - 1, currentIndex + 1)
        selectedStation = allStations[newIndex].name
        fetchArrivals(for: selectedStation)
        showToastTemporarily()
    }

    func showToastTemporarily() {
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
        }
    }

    func fetchArrivals(for station: String) {
        let encoded = station.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? station
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/\(apiKey)/json/realtimeStationArrival/0/10/\(encoded)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ArrivalResponse.self, from: data)
                    DispatchQueue.main.async {
                        arrivals = decoded.realtimeArrivalList
                    }
                } catch {
                    print("❌ 도착정보 파싱 실패: \(error)")
                }
            }
        }.resume()
    }
}

struct ArrivalCardView: View {
    let arrival: ArrivalInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("행선지: \(arrival.destination)")
                .font(.subheadline)
                .foregroundColor(.red)

            Text("도착메시지: \(arrival.message)")
                .font(.footnote)
                .foregroundColor(.gray)

            if let seconds = Int(arrival.remainSeconds), seconds > 0 {
                let minutes = seconds / 60
                Text("⏱ \(minutes)분 후 도착")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
        .onAppear {
            print("⏱ remainSeconds 값: \(arrival.remainSeconds)")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}
