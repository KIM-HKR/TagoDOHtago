import SwiftUI

struct StationDetailView: View {
    let stationName: String
    @StateObject private var viewModel = ArrivalViewModel()

    var body: some View {
        VStack {
            Text("\(stationName)역 도착 정보")
                .font(.title2)
                .padding()

            if viewModel.isLoading {
                ProgressView()
            } else if let arrivals = viewModel.arrivals {
                List(arrivals) { arrival in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("행선지: \(arrival.destination)")
                        Text("방향: \(arrival.direction)")
                        Text("도착메시지: \(arrival.message)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            } else {
                Text("정보를 불러올 수 없습니다.")
            }
        }
        .onAppear {
            viewModel.fetchArrivalInfo(for: stationName)
        }
    }
}
