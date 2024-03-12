//
//  WebService.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidResponse
    case decodingFailed
}

class WebService {
    static func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                print("Request 에러: \(error)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, 200 ..< 300 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                print("상태이상")
                return
            }
            
            do {
                // API 출력
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let prettyJSONData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                
                if let prettyPrintedString = String(data: prettyJSONData, encoding: .utf8) {
                    print(prettyPrintedString)
                }
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
                print("Decode 실패: \(error)")
            }
        }.resume()
    }
}
