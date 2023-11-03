//
//  ListOfBooksViewController.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation
import UIKit

class ListOfBooksViewController: UIViewController {

    var tableView: UITableView!
    private var viewModel: ListOfBookViewModel?
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListOfBookViewModel()
        setupTableView()
        setupNavigationBar()
        setupActivityIndicator()
        loadLibraryData()
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "house")!,
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white
        view.addSubview(tableView)

        tableView.register(BookInfoCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
    private func loadLibraryData() {
        activityIndicator.startAnimating()
        viewModel?.fetchLibrary { [weak self] in
            self?.activityIndicator.stopAnimating()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func logoutButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        print("LogOut \(UserDefaults.standard.bool(forKey: "isAuthenticated"))")
        UserDefaults.standard.synchronize()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ListOfBooksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BookInfoCell

        guard let tableViewCell = cell,
              let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModelForIndexPath(indexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
}
