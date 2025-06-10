
import SwiftUI

struct PresetStationView: View {
    @ObservedObject private var favoriteManager = FavoriteManager.shared

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(favoriteManager.favorites).sorted(by: { $0.name < $1.name }), id: \.self) { key in
                        NavigationLink(destination: RealtimeScheduleView(selectedStation: key.name)) {
                            HStack(spacing: 12) {
                                Image("line\(key.line)")
                                    .resizable()
                                    .frame(width: 26, height: 26)

                                Text(key.name)
                                    .font(.body)

                                Spacer()

                                Button(action: {
                                    favoriteManager.toggle(name: key.name, line: key.line)
                                }) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("프리셋")
        }
    }
}
