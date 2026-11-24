//
//  ViewController.swift
//  Preloved
//
//  Created by Elena Bandzaite on 14/11/2026.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    private var products: [Product] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pre-loved"
        
        setUpTableView()
        loadProducts()
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
    
    private func loadProducts() {
        Task {
            do {
                products = try await ProductService().fetchProducts()
                tableView.reloadData()
            } catch {
                print("Error: \(error)")
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let product = products[indexPath.row]
        
        content.text = product.title
        content.secondaryText = "€\(product.price)"
        cell.contentConfiguration = content
        
        return cell
    }
    
}
