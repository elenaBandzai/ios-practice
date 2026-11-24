//
//  ViewController.swift
//  Preloved
//
//  Created by Elena Bandzaite on 14/11/2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pre-loved"
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPurple
        
        Task {
                do {
                    let products = try await ProductService().fetchProducts()
                    print("Loaded \(products.count) products")
                    print(products.first?.title ?? "no products")
                } catch {
                    print("Error: \(error)")
                }
            }

    }


}

