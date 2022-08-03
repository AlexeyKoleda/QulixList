//
//  NetworkService.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation

enum DataStatus {
    case success
    case empty
    case error
}

protocol NetworkService {
    func downloadImage(url: String, completion: @escaping ((Data) -> Void))
    func getAppList(_ completion: @escaping (([AppModel], DataStatus) -> Void))
    func getAppDetails(for appId: String, completion: @escaping ((AppData?, DataStatus) -> Void))
}

final class NetworkServiceImplementation: NetworkService {
    
    // MARK: Requests
    func downloadImage(url: String, completion: @escaping ((Data) -> Void)) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data,
                  error == nil else {
                return
            }
            completion(data)
        }.resume()
    }
    
    func getAppList(_ completion: @escaping ([AppModel], DataStatus) -> Void) {
        let url = URLFactory.makeAppListURL()
        let request = configureRequest(for: url)
        makeUrlRequest(request) { (result: Result<AppListResponceModel, RequestError>) in
            switch result {
            case .success(let successValue):
                let apps = successValue.appList.apps
                if apps.count == 0 {
                    completion([AppModel](), .empty)
                    return
                } else {
                    completion(apps.filter { $0.name != "" }, .success)
                }
                
            case .failure(let error):
                completion([AppModel](), .error)
                print(error.localizedDescription)
            }
        }
    }
    
    func getAppDetails(for appId: String, completion: @escaping ((AppData?, DataStatus) -> Void)) {
        let url = URLFactory.makeAppDetailsURL(appId: appId)
        let request = configureRequest(for: url)
        makeUrlRequest(request) { (result: Result<AppDetailsResponceModel, RequestError>) in
            switch result {
            case .success(let result):
                if let app = result.appDetails,
                   app.success {
                    completion(app.data, .success)
                } else {
                    completion(nil, .empty)
                }
            case .failure(let error):
                print(error)
                completion(nil, .error)
            }
        }
    }
    
    // MARK: Private methods
    private func configureRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func makeUrlRequest<T: Decodable>(_ request: URLRequest, resultHandler: @escaping (Result<T, RequestError>) -> Void) {
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }

            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                return
            }

            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }

            guard let decodedData: T = self.decodedData(data) else {
                resultHandler(.failure(.dataDecodingError))
                return
            }

            resultHandler(.success(decodedData))
        }

        urlTask.resume()
    }
    
    private func decodedData<T: Decodable>(_ data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        let decodedData = try? jsonDecoder.decode(T.self, from: data)
        return decodedData
    }
    
    private enum RequestError: Error {
        case clientError
        case serverError
        case noData
        case dataDecodingError
    }
}

