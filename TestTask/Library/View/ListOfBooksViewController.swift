//
//  ListOfBooksViewController.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation
import UIKit

final class ListOfBooksViewController: UIViewController {

    var tableView: UITableView!
    private var viewModel: ListOfBookViewModel?
    private var activityIndicator = UIActivityIndicatorView()

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
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc private func logoutButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        UserDefaults.standard.synchronize()
        navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: - LoadData
extension ListOfBooksViewController {
    private func loadLibraryData() {
        activityIndicator.startAnimating()
        viewModel?.fetchLibrary { [weak self] in
            self?.activityIndicator.stopAnimating()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
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
