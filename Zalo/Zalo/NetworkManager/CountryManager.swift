//
//  CountryManager.swift
//  Zalo
//
//  Created by AnhLe on 10/04/2022.
//

import UIKit
class CountryManager {
    static let shared = CountryManager()
    
    // MARK: - URL
    let countryUrl = Configs.countryNameBaseUrl
    
    func fetchCountryUrl(completion: @escaping(Result<[CountryName], BaseError>)->Void){
        guard let url = URL(string: countryUrl) else {
            completion(.failure(.urlError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(.requestError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.parsedDataError))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode([CountryName].self, from: data)
                completion(.success(data))
            }catch{
                completion(.failure(.parsedDataError))
            }
        }
        task.resume()
    }
}
