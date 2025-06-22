//
//  Untitled.swift
//  BakeryApp
//
//  Created by Maxik on 20.06.2025.
//

import UIKit
import SnapKit


struct YourModel: Codable {
    let id: Int
    let name: String
    
}

class APIService {
    func fetchData(from url: String) async throws -> [YourModel] {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode([YourModel].self, from: data)
        return decodedData
    }
}

@MainActor
class YourViewModel: ObservableObject {
    @Published var items: [YourModel] = []
    private let apiService = APIService()
    
    func loadData() async {
        do {
            let data = try await apiService.fetchData(from: "https://api.sampleapis.com/coffee/iced")
            items = data
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}


