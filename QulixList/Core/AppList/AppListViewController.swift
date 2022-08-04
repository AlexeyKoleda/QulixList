//
//  AppListViewController.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import UIKit

class AppListViewController: UIViewController {

    private let customView = GamesListView()
    private let viewModel: AppListViewModel
   
    private let goToDetails: (AppModel) -> Void

    // MARK: initializers
    public init(viewModel: AppListViewModel, goToDetails: @escaping (AppModel) -> Void) {
        self.viewModel = viewModel
        self.goToDetails = goToDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startIndicator()
        setupCustomView()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }

    // MARK: Private methods
    private func loadData() {
        viewModel.loadAppList { [weak self] (appList, dataStatus) in
            DispatchQueue.main.async {
                self?.customView.setupView(with: dataStatus)
                self?.customView.appListTableView.reloadData()
                self?.stopIndicator()
                self?.customView.scrollView.refreshControl?.endRefreshing()
            }
        }
    }

    private func updateData() {
        customView.appListTableView.reloadData()
    }

    private func setupCustomView() {
        customView.appListTableView.delegate = self
        customView.appListTableView.dataSource = self
        customView.searchBar.delegate = self
        customView.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    private func startIndicator() {
        customView.indicatorView.isHidden = false
        customView.indicatorView.startAnimating()
    }

    private func stopIndicator() {
        customView.indicatorView.stopAnimating()
        customView.indicatorView.isHidden = true
    }

    @objc private func refresh() {
        self.loadData()
    }
}

// MARK: TableView Data source extension
extension AppListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredAppList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.backgroundColor = .clear
        
        let gameItem = viewModel.filteredAppList[indexPath.row]
        
        cell.textLabel?.text = gameItem.name
        return cell
    }
}

// MARK: TableView Delegate extension
extension AppListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let app = viewModel.filteredAppList[indexPath.row]
        goToDetails(app)

    }
}

// MARK: SearchBar Delegate extension
extension AppListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterAppList(searchText: searchText)
        self.customView.appListTableView.reloadData()
    }
}

