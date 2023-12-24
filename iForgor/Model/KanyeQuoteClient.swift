//
//  KanyeQuoteClient.swift
//  iForgor
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import Foundation
import ComposableArchitecture

struct KanyeQuoteClient {
    enum KanyeQuoteClientError: Error {
        case fetchingError
    }
    
    var fetch: () async throws -> Result<String, Error>
}

extension KanyeQuoteClient: DependencyKey {
    static var liveValue = KanyeQuoteClient(fetch: {
        guard let url = URL(string: "https://api.kanye.rest/") else {
            throw KanyeQuoteClientError.fetchingError
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw KanyeQuoteClientError.fetchingError
        }
        
        let quote = try JSONDecoder().decode(KanyeQuote.self, from: data).quote
        return .success(quote)
    })
}

extension DependencyValues {
    var kanyeQuoteClient: KanyeQuoteClient {
        get { self[KanyeQuoteClient.self] }
        set { self[KanyeQuoteClient.self] = newValue }
    }
}
