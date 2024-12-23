//
//  NetworkManager.swift
//  KoloniReservation
//
//  Created by Koloni on 19/12/24.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct ReservationsResponse: Decodable {
    let items: [Reservation]
    let total: Int
    let pages: Int
}

final class NetworkManager {
    let apiKey = "MGM2OGU2ZGM3OThkYzZiNGZiMTg2YTZjYmI5OGY2MDEwOTViZjI0NmI4NDkxYzA1ZWMwMTU0N2JlMjIyNzY5YQ"
    let baseURL = URL(string: "https://qa.api.koloni.io/")!

    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: Encodable? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = body {
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch {
                print("Error encoding request body: \(error)")
                completion(.failure(error))
                return
            }
        }

        // Debug: Print request info
        print("----- REQUEST INFO -----")
        print("URL: \(request.url?.absoluteString ?? "No URL")")
        print("Method: \(request.httpMethod ?? "No Method")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        } else {
            print("Body: None")
        }
        print("-----------------------")

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network or server errors
            if let error = error {
                print("Network Error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("----- RESPONSE INFO -----")
                print("Status Code: \(httpResponse.statusCode)")
                print("Headers: \(httpResponse.allHeaderFields)")
                print("------------------------")
            }

            guard let data = data else {
                print("No data received from server.")
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                print("Decoding success: \(T.self)")
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                print("JSON Decoding Error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
extension NetworkManager {
    func fetchReservations(completion: @escaping (Result<[Reservation], Error>) -> Void) {
        print("Starting fetchReservations...")
        request(endpoint: "v3/partner/reservations") { (result: Result<ReservationsResponse, Error>) in
            print("fetchReservations result: \(result)")
            switch result {
            case .success(let response):
                print("Success: Received \(response.items.count) reservations.")
                completion(.success(response.items))
            case .failure(let error):
                print("Error fetching reservations: \(error)")
                completion(.failure(error))
            }
        }
    }

}
