//
//  ProductsViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource {
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK:- Properties
    var productList: [Datum] = []
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getProducts()
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        let product = productList[indexPath.row]
        cell.setCellWith(title: product.attributes.name,
                         withDescription: product.attributes.attributesDescription,
                         andWith: product.attributes.productImageURL)
        return cell
    }
    
    func getProducts() {
        
        let url = URL(string: "https://c2c-server.herokuapp.com/products")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            let productModel = try? JSONDecoder().decode(Products.self, from: data)
            
            guard let model = productModel else {
                return
            }
            
            self.productList = model.data
            
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }.resume()
        
    }
    
}

struct Products: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let id, type: String
    let attributes: Attributes
}

struct Attributes: Codable {
    let id: Int
    let name, attributesDescription: String
    let price: Int
    let productImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case attributesDescription = "description"
        case price
        case productImageURL = "product_image_url"
    }
}
