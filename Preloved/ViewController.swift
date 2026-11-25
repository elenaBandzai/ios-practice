//
//  ViewController.swift
//  Preloved
//
//  Created by Elena Bandzaite on 14/11/2026.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let errorView = UIStackView()
    private let errorLabel = UILabel()
    private let retryButton = UIButton()
    
    private let refreshControl = UIRefreshControl()
    
    private var displayedProducts: [ProductList.DisplayedProduct] = []
    private var interactor: ProductListBusinessLogic?


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVIP()
        title = "Pre-loved"
        
        setUpTableView()
        setUpSpinner()
        setUpErrorView()
        setUpRefreshControl()
        loadProducts()
    }
    
    private func setUpVIP() {
        let presenter = ProductListPresenter()
        let interactor = ProductListInteractor(presenter: presenter, service: ProductService())
        presenter.viewController = self
        self.interactor = interactor
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setUpRefreshControl() {
        refreshControl.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            if self.spinner.isAnimating {
                self.refreshControl.endRefreshing()
            }
            self.loadProducts()
        }, for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setUpSpinner() {
        view.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setUpErrorView() {
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0

        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = "Try again"
        retryButton.configuration = buttonConfig
        retryButton.addAction(UIAction { [weak self] _ in
            self?.loadProducts()
        }, for: .touchUpInside)

        errorView.axis = .vertical
        errorView.spacing = 12
        errorView.alignment = .center
        errorView.addArrangedSubview(errorLabel)
        errorView.addArrangedSubview(retryButton)
        errorView.isHidden = true

        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    

    private func loadProducts() {
        Task {
            await interactor?.loadProducts()
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let product = displayedProducts[indexPath.row]
        
        content.text = product.title
        content.secondaryText = product.price
        cell.contentConfiguration = content
        
        return cell
    }
    
}

extension ViewController: ProductListDisplayLogic {
    func display(viewModel: ProductList.ViewModel) {
        spinner.stopAnimating()
        errorView.isHidden = true

        switch viewModel {
        case .loading:
            if displayedProducts.isEmpty {
                spinner.startAnimating()
            }

        case .loaded(let products):
            refreshControl.endRefreshing()
            displayedProducts = products
            tableView.reloadData()

        case .error(let message):
            refreshControl.endRefreshing()
            displayedProducts = []
            tableView.reloadData()
            errorLabel.text = message
            errorView.isHidden = false
        }
    }
}
