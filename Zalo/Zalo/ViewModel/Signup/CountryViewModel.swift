//
//  CountryViewModel.swift
//  Zalo
//
//  Created by AnhLe on 10/04/2022.
//

import UIKit
struct Section {
    let letter: String
    let countries : [CountryPhone]
}
class CountryViewModel{
    // MARK: - Properties
    var needReloadTableView: (()->Void)?
    var needShowError: ((BaseError)->Void)?
    var names: Country?
    var codes: Country?
    var countries: [CountryPhone] = [CountryPhone]()
    var sections: [Section] = [Section]()
    
    
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
        if self.countries.isEmpty{
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
                    let code = codes[key]!.isEmpty ? "N/A" : self.configCodeNumber(code: codes[key])
                    let country = CountryPhone(name: key, shorthand: value, code: code)
                    self.countries.append(country)
                }
                //initialize dict , key = letter, value = [countries]
                let groupedDictionary = Dictionary(grouping: self.countries, by: {String($0.shorthand.prefix(1))})
                //get key to map the sections
                let keys = groupedDictionary.keys.sorted()
                
                //sort the sections by keys
                self.sections = keys.map({Section(letter: $0, countries: groupedDictionary[$0]!.sorted(by: {$0.shorthand < $1.shorthand}))})
                
                self.needReloadTableView?()
                
                
            }
        }

    }
    
    //add '+' at first character
    func configCodeNumber(code: String?) -> String{
        guard let code = code else { return ""}
        var codeChars = Array(code)
        if codeChars[0] == "+" {
            return String(codeChars)
        }
        codeChars.insert("+", at: 0)
        return String(codeChars)
    }
        
    func numberOfRowsInSection(section: Int) -> Int {
        return sections[section].countries.count
    }
    
    func numberOfSections(in tableView: UITableView)->Int{
        return sections.count
    }
    
    func titleForHeaderInSection(section: Int) -> String?{
        return sections[section].letter
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CountryPhone{
        let section = sections[indexPath.section]
        let country = section.countries[indexPath.row]
        return country
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> CountryPhone {
        let section = sections[indexPath.section]
        let country = section.countries[indexPath.row]
        return country
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }
}
    

