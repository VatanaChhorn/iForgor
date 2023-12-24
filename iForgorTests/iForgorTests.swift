//
//  iForgorTests.swift
//  iForgorTests
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import XCTest
@testable import iForgor
import ComposableArchitecture

@MainActor
final class iForgorTests: XCTestCase {

    func testKanyeQuoteFeature_onAppear() async {
        let testStore = TestStore(initialState: KanyeQuoteFeature.State(theme: .theme1, quote: "is Fetching Kanye Quote")) {
            KanyeQuoteFeature()
        } withDependencies: { kanyeQuoteClient in
            kanyeQuoteClient.kanyeQuoteClient.fetch = {
                .success("This is a cool kanye quote")
            }
        }
        
        testStore.exhaustivity = .off
        await testStore.send(.onAppear)
        await testStore.receive(\.kanyeQuoteResponse, timeout: .seconds(1)) {
            XCTAssertFalse($0.theme == .error)
            $0.quote = "This is a cool kanye quote"
        }
    }
    
    func testKanyeQuoteFeature_refreshButtonTapped() async {
        let testStore = TestStore(initialState: KanyeQuoteFeature.State(theme: .theme1, quote: "is Fetching Kanye Quote")) {
            KanyeQuoteFeature()
        } withDependencies: { kanyeQuoteClient in
            kanyeQuoteClient.kanyeQuoteClient.fetch = {
                .success("This is a cool kanye quote")
            }
        }
        
        testStore.exhaustivity = .off
        await testStore.send(.refreshButtonTapped)
        await testStore.receive(\.kanyeQuoteResponse, timeout: .seconds(1)) {
            XCTAssertFalse($0.theme == .error)
            $0.quote = "This is a cool kanye quote"
        }
    }
    
    func testKanyeQuoteFeatureOnError() async {
        let testStore = TestStore(initialState: KanyeQuoteFeature.State(theme: .theme1, quote: "is Fetching Kanye Quote")) {
            KanyeQuoteFeature()
        } withDependencies: { kanyeQuoteClient in
            kanyeQuoteClient.kanyeQuoteClient.fetch = {
                .failure(KanyeQuoteClient.KanyeQuoteClientError.fetchingError)
            }
        }
        
        await testStore.send(.onAppear)
        await testStore.receive(\.kanyeQuoteResponse, timeout: .seconds(1)) {
            $0.theme = .error
        }
    }
}
