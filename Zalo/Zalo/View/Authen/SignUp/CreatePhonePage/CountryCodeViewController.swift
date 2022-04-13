//
//  CountryCodeViewController.swift
//  Zalo
//
//  Created by AnhLe on 11/04/2022.
//

import UIKit
protocol CountryCodeViewControllerDelegate: AnyObject {
    func didCountryCodeTapped(country: CountryPhone)
}
class CountryCodeViewController: SignupViewController {
    // MARK: - Subview
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Tìm kiếm"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isTranslucent = false
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.searchBarStyle = .default
        return searchBar
    }()
    
    // MARK: - Properties
    var viewModel: CountryViewModel!
    weak var delegate: CountryCodeViewControllerDelegate?
    
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
        configViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateSearchResult(searchBar: searchBar)
    }
    
    // MARK: - Selector
    override func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    // MARK: - Helper
    
    override func configureNavBar() {
        self.navigationController?.navigationBar.barTintColor = .blueZalo
        self.navigationController?.navigationBar.barStyle = .black
        self.title = "Chọn mã quốc gia"
        let leftBarItem = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItems = [leftBarItem]
    }

    
    private func configTableView(){
        tableView.register(CountryCodeTableViewCell.self, forCellReuseIdentifier: CountryCodeTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = CountryCodeTableViewCell.rowHeight
        tableView.register(CountryCodeCustomHeaderCell.self, forHeaderFooterViewReuseIdentifier: CountryCodeCustomHeaderCell.reuseIdentifier)
        tableView.tintColor = .darkGray
    }
    
    private func configViewModel(){
        viewModel.needReloadTableView = { [weak self] in
            guard let self = self else {return}
            //end loading indicator
            self.tableView.reloadData()
        }
    }
}
// MARK: - Extension
extension CountryCodeViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
        configTableView()
    }
    func layout(){
        view.addSubview(tableView)
        view.addSubview(searchBar)
        //searchBar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
        ])
        
        //tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CountryCodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.didSelectRowAt(indexPath: indexPath)
        delegate?.didCountryCodeTapped(country: country)
        self.dismiss(animated: true, completion: nil)
    }
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
        headerCell.bindingData(letter: viewModel.titleForHeaderInSection(section: section) ?? "")
        return headerCell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexTitles(for: tableView)
    }
}


extension CountryCodeViewController: UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchResult(searchBar: searchBar)
    }
}
