import SwiftUI
import Firebase

@main
struct SubwayInfoApp: App {
    
    //   Firebase 초기화
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
