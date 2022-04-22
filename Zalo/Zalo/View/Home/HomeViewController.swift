//
//  HomeViewController.swift
//  Zalo
//
//  Created by AnhLe on 14/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Subview
    lazy var searchBar: UISearchBar = {
        let availableWidth: CGFloat = view.bounds.size.width - (24 * 3 +  12 * 3)
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.searchTextField.textColor = .white
        let emptyImage = UIImage()
        searchBar.setImage(emptyImage, for: .search, state: .normal)
        
        var attrs = [NSAttributedString.Key: AnyObject]()
        attrs[.foregroundColor] = UIColor.white
        
        var attrsText = NSAttributedString(string: "Tìm bạn bè, tin nhắn...", attributes: attrs)
        searchBar.searchTextField.attributedPlaceholder = attrsText
        return searchBar
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Properties
    
    var homeViewModel: HomeViewModel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        style()
        
        layout()
       
//        setupDissmissKeyboard()
       

    }
    
    
    // MARK: - Selector
    @objc func plusButtonTapped(_ sender: UIButton){
        SocketIOManager.shared.connectSocket { [weak self] in
            guard let self = self else {return}
            let alert = UIAlertController(title: "Đăng nhập", message: "Nhập tên của bạn: ", preferredStyle: .alert)
            alert.addTextField { (textfield: UITextField) in
                textfield.placeholder = "Tên của bạn"
            }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if let name = alert.textFields![0].text {
                    SocketIOManager.shared.nickName = name
                }
                SocketIOManager.shared.connectToServerWithNickname(nickname: SocketIOManager.shared.nickName)
            }))

            self.present(alert, animated: true, completion: nil)
        }
//
//        homeViewModel.fetchUser()

    }
    
    

    
    // MARK: - API
    
    // MARK: - Helper

    
    func configLeftNavBar(){
        //left items
        let leftBtnSearchTextField = UIBarButtonItem(customView: searchBar)
        
        searchBar.delegate = self
        
        let button = makeNavBarButton(image: Image.search)
        let leftSearchBtn = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItems = [leftSearchBtn, leftBtnSearchTextField]
    }
    
    func configRightNavBar(){
        let plusButton = makeNavBarButton(image: Image.plus)
        plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
        let qrScanButton = makeNavBarButton(image: Image.qrScan)
        
        let rightPlusButton = UIBarButtonItem(customView: plusButton)
        
        let rightQrScanButton = UIBarButtonItem(customView: qrScanButton)
        self.navigationItem.rightBarButtonItems = [rightPlusButton, rightQrScanButton]
    }
    
    func configTableView(){
        tableView.register(HomeTableCell.self, forCellReuseIdentifier: HomeTableCell.reuseIdentifier)
        tableView.rowHeight = HomeTableCell.rowHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.removeExcessCell()

    }
    
    func bindingViewModel(){
        homeViewModel = HomeViewModel()
        
        homeViewModel.needReloadView = { [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
            
        }
        
        homeViewModel.fetchUser()
        
    }
}
// MARK: - Extension
extension HomeViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        
        configLeftNavBar()
        configRightNavBar()
        configTableView()
    }
    func layout(){
        view.addSubview(tableView)
        
        //tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("DEBUG: \(searchText)")
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = homeViewModel.didSelectRowAt(indexPath: indexPath)
        let vc = ConversationViewController(friend: friend)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.reuseIdentifier, for: indexPath) as! HomeTableCell
        cell.user = homeViewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    
}
