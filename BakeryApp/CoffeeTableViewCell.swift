//
//  CoffeeTableViewCell.swift
//  BakeryApp
//
//  Created by Maxik on 24.09.2025.
//


import UIKit
import SnapKit
import SDWebImage

class CoffeeTableViewCell: UITableViewCell {
   
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    /*private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        label.textColor = .gray
        return label
        }()*/
    
    private lazy var coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(coffeeImageView)
        //contentView.addSubview(ingredientsLabel)
        
        coffeeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.lessThanOrEqualToSuperview().offset(-12)
            $0.right.equalToSuperview().inset(16)
            $0.width.height.equalTo(100)
        }
    
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(coffeeImageView.snp.left).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(coffeeImageView.snp.left).offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        /*ingredientsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(descriptionLabel.snp.right).offset(10)
            $0.right.equalTo(coffeeImageView.snp.left).offset(-10)
            
        }*/
    }
    
    func configure(with coffee: Coffee) {
        titleLabel.text = coffee.title
        descriptionLabel.text = coffee.description
        //ingredientsLabel.text = coffee.ingredients
        coffeeImageView.sd_setImage(with: URL(string: coffee.image))
        
    }
}

