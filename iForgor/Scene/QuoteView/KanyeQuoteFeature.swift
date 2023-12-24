//
//  KanyeQuoteFeature.swift
//  iForgor
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import Foundation
import ComposableArchitecture

@Reducer
struct KanyeQuoteFeature {
    @Dependency(\.kanyeQuoteClient) var kanyeQuoteClient
    
    struct State: Equatable {
        var theme: Theme
        var quote: String
    }
    
    enum Action {
        case onAppear
        case refreshButtonTapped
        case kanyeQuoteResponse(Result<String, Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear, .refreshButtonTapped:
                return .run { send in
                    let quoteMethod = kanyeQuoteClient.fetch
                    do {
                        let quote: Result<String, any Error> = try await quoteMethod()
                        await send(.kanyeQuoteResponse(quote))
                    } catch {
                        await send(.kanyeQuoteResponse(.failure(error)))
                    }
                }
            case let .kanyeQuoteResponse(result):
                state.theme = Theme
                    .allCases
                    .filter({ $0 != .error })
                    .randomElement() ?? .theme2
                
                switch result {
                case let .success(quote):
                    state.quote = quote
                case .failure:
                    state.theme = .error
                }
                return .none
            }
        }
    }
}
