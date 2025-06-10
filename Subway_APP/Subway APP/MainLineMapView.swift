// MainLineMapView.swift
import SwiftUI

struct MainLineMapView: View {
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Image("line_map")
                .resizable()
                .scaledToFit()
                .padding()
        }
        .navigationTitle("지하철 노선도")
    }
}
