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
    func fetchCountryName(url: String, completion: @escaping(Result<Country, BaseError>)->Void){
        guard let url = URL(string: url) else {
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
                let countries = try decoder.decode(Country.self, from: data)
                completion(.success(countries))
            }catch{
                completion(.failure(.parsedDataError))
                
            }
        }
        task.resume()
    }
    
    func fetchCountryCode(url: String,completion: @escaping(Result<Country, BaseError>)->Void){
        guard let url = URL(string: url) else {
            completion(.failure(.urlError))
            print(0)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestError))
                print(1)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(.requestError))
                print(2)
                return
            }
            
            guard let data = data else {
                completion(.failure(.parsedDataError))
                print(3)
                return
            }
            do{
                let decoder = JSONDecoder()
                let countries = try decoder.decode(Country.self, from: data)
                completion(.success(countries))
            }catch{
                completion(.failure(.parsedDataError))
                
            }
        }
        task.resume()
    }
}
