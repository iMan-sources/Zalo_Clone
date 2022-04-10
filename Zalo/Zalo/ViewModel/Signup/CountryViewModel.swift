//
//  CountryViewModel.swift
//  Zalo
//
//  Created by AnhLe on 10/04/2022.
//

import Foundation

class CountryViewModel{
    // MARK: - Properties
    var needReloadTableView: (()->Void)?
    var needShowError: ((BaseError)->Void)?
    var names: Country?
    var codes: Country?
    var countries: [CountryPhone] = [CountryPhone]()
    
    
    // MARK: - Function
    func fetchCountryNameData(){
        CountryManager.shared.fetchCountryName(url: Configs.countryNameBaseUrl) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let names):
                self.names = names
            case .failure(let error):
                self.needShowError?(error)
            }
        }
    }
    
    func fetchCountryCodeData(){
        CountryManager.shared.fetchCountryName(url: Configs.countryCodeBaseUrl) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let codes):
                self.codes = codes
            case .failure(let error):
                self.needShowError?(error)
            }
        }
    }
    
    func fetchData(){
        let group = DispatchGroup()
        group.enter()
        fetchCountryNameData()
        group.leave()
        
        group.enter()
        fetchCountryCodeData()
        group.leave()
        
        group.notify(queue: .main) {
            guard let names = self.names else {return}
            guard let codes = self.codes else {return}
            for i in names{
                let key = i.key, value = i.value
                var code = codes[key]
                if code!.isEmpty {
                    code = "N/A"
                }
                let country = CountryPhone(name: key, shorthand: value, code: code!)
                self.countries.append(country)
            }
            self.needReloadTableView?()
        }

    }
    
    
}
