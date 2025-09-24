//
//  StepperView.swift
//  BakeryApp
//
//  Created by Maxik on 24.09.2025.
//

import UIKit
import SnapKit


class StepperView: UIView {

    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)
    private let countLabel = UILabel()

    private var count = 1 {
        didSet {
            countLabel.text = "\(count)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 6
        clipsToBounds = true

        
        minusButton.setTitle("−", for: .normal)
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        minusButton.addTarget(self, action: #selector(decrease), for: .touchUpInside)
        minusButton.setTitleColor(.white, for: .normal)
        

        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        plusButton.addTarget(self, action: #selector(increase), for: .touchUpInside)
        plusButton.setTitleColor(.white, for: .normal)


        countLabel.text = "\(count)"
        countLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        countLabel.textAlignment = .center
        countLabel.textColor = .white

        
        let stack = UIStackView(arrangedSubviews: [minusButton, countLabel, plusButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @objc private func decrease() {
           if count > 1 {
               count -= 1
               
           }
       }

       @objc private func increase() {
           count += 1
       }
   }
