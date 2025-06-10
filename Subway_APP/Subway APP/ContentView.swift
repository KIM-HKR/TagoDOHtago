import SwiftUI

struct ContentView: View {
    @StateObject var presetManager = PresetManager()

    var body: some View {
        TabView {
            MainLineMapView()
                .tabItem {
                    Label("노선도", systemImage: "map")
                }
            
            SearchStationView() // ✅ 검색 기능 추가
                .tabItem {
                    Label("검색", systemImage: "magnifyingglass")
                }

          //  RealtimeScheduleView(selectedStation: "서울역") // 초기 테스트용
           //     .tabItem {
            //        Label("실시간", systemImage: "clock")
             //   }

            PresetStationView()
                .tabItem {
                    Label("프리셋", systemImage: "star")
                }

            NoticeBoardView()
                .tabItem {
                    Label("공지사항", systemImage: "bell")
                }
            
        
        }
        .environmentObject(presetManager)
    }
}
