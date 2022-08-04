//
//  AppListView.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import UIKit

final class GamesListView: UIView {

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    var appListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        scrollView.refreshControl = refreshControl
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = .white
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        createSubViews()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }

    func setupView(with dataStatus: DataStatus) {
        switch dataStatus {
        case .success:
            setupSearchBar()
            setupTableView()
        case .empty:
            setupScrollView()
            setupErrorLabel(text: "Oops... No data here")
        case .error:
            setupScrollView()
            setupErrorLabel(text: "Oops... Something went wrong")
        }
    }

    private func createSubViews() {
        self.backgroundColor = UIColor.theme.backgroundColor
        setupActivityIndicator()
        self.addGestureRecognizer(createOutOfSerchTap())
    }

    private func setupSearchBar() {

        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }

    private func setupTableView() {

        addSubview(appListTableView)
        NSLayoutConstraint.activate([
            appListTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            appListTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            appListTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            appListTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupErrorLabel(text: String) {
        scrollView.addSubview(errorLabel)
        errorLabel.text = text
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupActivityIndicator() {
        addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func createOutOfSerchTap() -> UITapGestureRecognizer {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        return singleTapGestureRecognizer
    }

    @objc private func singleTap() {
        self.searchBar.endEditing(true)
    }
}

