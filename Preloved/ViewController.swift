//
//  ViewController.swift
//  Preloved
//
//  Created by Elena Bandzaite on 14/11/2026.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let items = ["Jacket", "Jeans", "Sneakers"]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pre-loved"
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
    
        tableView.backgroundColor = .systemYellow

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

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = items[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
}
