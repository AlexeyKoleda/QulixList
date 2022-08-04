//
//  QulixListTests.swift
//  QulixListTests
//
//  Created by Alexey Koleda on 04.08.2022.
//

import XCTest
@testable import QulixList

class AppDetailsViewModelTests: XCTestCase {

    func test_viewModel_loadImageSuccessfully() {
        let (sut, spy) = makeSUT()
        
        sut.loadImage(from: "") { _ in }

        XCTAssertTrue(spy.images.count > 0)
    }
    
    func test_viewModel_loadAppDetailsSuccessfully() {
        let (sut, spy) = makeSUT()
        
        sut.loadAppDetails(appId: "") { _ in }
        
        XCTAssertTrue(spy.apps.count > 0)
    }
    
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (AppDetailsViewModel, NetworkServiceSpy) {
        let service = NetworkServiceSpy()
        let sut = AppDetailsViewModel(networkService: service)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(service, file: file, line: line)
        return (sut, service)
    }

    private class NetworkServiceSpy: NetworkService {
        private(set) var images = [((Data) -> Void)]()
        private(set) var appLists = [(([AppModel], DataStatus) -> Void)]()
        private(set) var apps = [((AppData?, DataStatus) -> Void)]()
        
        func downloadImage(url: String, completion: @escaping ((Data) -> Void)) {
            images.append(completion)
        }
        
        func getAppList(_ completion: @escaping (([AppModel], DataStatus) -> Void)) {
            appLists.append(completion)
        }
        
        func getAppDetails(for appId: String, completion: @escaping ((AppData?, DataStatus) -> Void)) {
            apps.append(completion)
        }
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
