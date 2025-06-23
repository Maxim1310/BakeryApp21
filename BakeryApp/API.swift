//
//  Untitled.swift
//  BakeryApp
//
//  Created by Maxik on 20.06.2025.
//

import UIKit
import SnapKit


struct Coffee: Codable {
    let title: String
    let description: String
    let ingredients: [String]
    let image: String
    let id: Int
}


let jsonString = """
[
    {"title":"Black Coffee","description":"Classic hot black coffee","ingredients":["Coffee","Water"],"image":"https://images.unsplash.com/photo-1494314671902-399b18174975?auto=format&fit=crop&q=80&w=800","id":26},
    {"title":"Latte","description":"Espresso with steamed milk","ingredients":["Espresso","Steamed Milk"],"image":"https://images.unsplash.com/photo-1561882468-9110e03e0f78?auto=format&fit=crop&q=80&w=800","id":27},
    {"title":"Caramel Latte","description":"A sweet latte with caramel syrup.","ingredients":["Espresso","Steamed Milk","Caramel Syrup"],"image":"https://images.unsplash.com/photo-1599398054066-846f28917f38?auto=format&fit=crop&q=80&w=800","id":28},
    {"title":"Cappuccino","description":"Espresso with steamed milk and foam.","ingredients":["Espresso","Steamed Milk","Foam"],"image":"https://images.unsplash.com/photo-1557006021-b85faa2bc5e2?auto=format&fit=crop&q=80&w=800","id":29}
]
"""

func parseCoffeeData() -> [Coffee]? {
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }
    let decoder = JSONDecoder()
    do {
        let coffees = try decoder.decode([Coffee].self, from: jsonData)
        return coffees
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}


class CoffeeTableViewCell: UITableViewCell {
    let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(coffeeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ingredientsLabel)
        
        NSLayoutConstraint.activate([
            coffeeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coffeeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            coffeeImageView.widthAnchor.constraint(equalToConstant: 100),
            coffeeImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: coffeeImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: coffeeImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            ingredientsLabel.leadingAnchor.constraint(equalTo: coffeeImageView.trailingAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ingredientsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with coffee: Coffee) {
        titleLabel.text = coffee.title
        descriptionLabel.text = coffee.description
        ingredientsLabel.text = "Ingredients: \(coffee.ingredients.joined(separator: ", "))"
        

        if let url = URL(string: coffee.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.coffeeImageView.image = image
                    }
                }
            }
        }
    }
}

class CoffeeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var coffees: [Coffee] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Coffee Menu"
        setupTableView()
        loadCoffeeData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoffeeTableViewCell.self, forCellReuseIdentifier: "CoffeeCell")
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadCoffeeData() {
        if let coffeeData = parseCoffeeData() {
            coffees = coffeeData
            tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! CoffeeTableViewCell
        let coffee = coffees[indexPath.row]
        cell.configure(with: coffee)
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}



