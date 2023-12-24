//
//  iForgorApp.swift
//  iForgor
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct iForgorApp: App {
    static let kanyeFeatureStore = Store(initialState: KanyeQuoteFeature.State(theme: .theme1, quote: "iForgor xD")) {
        KanyeQuoteFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            KanyeQuoteView(store: iForgorApp.kanyeFeatureStore)
        }
    }
}
