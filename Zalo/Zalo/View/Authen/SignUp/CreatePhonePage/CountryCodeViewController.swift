//
//  CountryCodeViewController.swift
//  Zalo
//
//  Created by AnhLe on 11/04/2022.
//

import UIKit

class CountryCodeViewController: SignupViewController {
    // MARK: - Subview
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties
    var viewModel: CountryViewModel!
    
    // MARK: - Lifecycle
    init(viewModel: CountryViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
    // MARK: - Selector
    override func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - API
    
    // MARK: - Helper

    
    private func configTableView(){
        tableView.register(CountryCodeTableViewCell.self, forCellReuseIdentifier: CountryCodeTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = CountryCodeTableViewCell.rowHeight
        tableView.register(CountryCodeCustomHeaderCell.self, forHeaderFooterViewReuseIdentifier: CountryCodeCustomHeaderCell.reuseIdentifier)
        tableView.tintColor = .darkGray
    }
}
// MARK: - Extension
extension CountryCodeViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        configTableView()
    }
    func layout(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension CountryCodeViewController: UITableViewDelegate {
    
}

extension CountryCodeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCodeTableViewCell.reuseIdentifier, for: indexPath) as! CountryCodeTableViewCell
        let country = viewModel.cellForRowAt(indexPath: indexPath)
        cell.bindData(country: country)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: CountryCodeCustomHeaderCell.reuseIdentifier) as! CountryCodeCustomHeaderCell
        headerCell.bindingData(letter: viewModel.titleForHeaderInSection(section: section)!)
        return headerCell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexTitles(for: tableView)
    }
    
}
