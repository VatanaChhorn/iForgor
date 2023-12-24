//
//  ContentView.swift
//  iForgor
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import SwiftUI
import ComposableArchitecture

struct KanyeQuoteView: View {
    let store: StoreOf<KanyeQuoteFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            KanyeQuoteTheme(theme: viewStore.theme,
                            quote: viewStore.quote) {
                viewStore.send(.refreshButtonTapped)
            }
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }
    }
}

#Preview {
    let store = Store(initialState: KanyeQuoteFeature.State(theme: .theme1, quote: "Fetching Kanye Quote")) {
        KanyeQuoteFeature()
    }
    return KanyeQuoteView(store: store)
}
