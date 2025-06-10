
import Foundation
import Combine

struct StationKey: Hashable, Codable {
    let name: String
    let line: String
}

class FavoriteManager: ObservableObject {
    static let shared = FavoriteManager()

    @Published private(set) var favorites: Set<StationKey> = []

    private let key = "FavoriteStationsV2"

    private init() {
        loadFavorites()
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: key),
           let saved = try? JSONDecoder().decode(Set<StationKey>.self, from: data) {
            favorites = saved
        }
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func isFavorite(name: String, line: String) -> Bool {
        favorites.contains(StationKey(name: name, line: line))
    }

    func toggle(name: String, line: String) {
        let key = StationKey(name: name, line: line)
        if favorites.contains(key) {
            favorites.remove(key)
        } else {
            favorites.insert(key)
        }
        saveFavorites()
    }
}
