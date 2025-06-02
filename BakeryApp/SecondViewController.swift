//
//  SecondViewController.swift
//  BakeryApp
//
//  Created by Maxik on 19.05.2025.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    private var isFavorite = false
    private var heartButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorBackground
        
        
        
        setupHeartButton()
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func setupHeartButton() {
        heartButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(heartButtonTapped)
        )
        heartButton.tintColor = .white
        navigationItem.rightBarButtonItem = heartButton
    }

    @objc private func heartButtonTapped() {
        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        heartButton.image = UIImage(systemName: imageName)
        
        print("Heart tapped: \(isFavorite ? "selected" : "unselected")")
    }
    
    
    
    var banner2ImageView: UIImageView = {
        let object = UIImageView()
        
        object.image = UIImage(named: "GroundCoffee")
        object.contentMode = .scaleAspectFit
        object.layer.cornerRadius = 10
        
        
        
        return object
    }()
    

        
    
    class StepperView: UIView {

        private let minusButton = UIButton(type: .system)
        private let plusButton = UIButton(type: .system)
        private let countLabel = UILabel()

        private var count = 100 {
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
               if count > 100 {
                   count -= 100
                   
               }
           }

           @objc private func increase() {
               count += 100
           }
       }
    
    class CoffeeTypeSelector: UIView {

        private let groundButton = UIButton(type: .system)
        private let beanButton = UIButton(type: .system)

        private let selectedColor = UIColor.white
        private let unselectedColor = UIColor.lightGray

        private var selectedType: CoffeeType = .ground {
            didSet {
                updateUI()
            }
        }

        enum CoffeeType {
            case ground
            case bean
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
            groundButton.setTitle("  ● Ground", for: .normal)
            beanButton.setTitle("  ○ Bean", for: .normal)

            [groundButton, beanButton].forEach {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                $0.setTitleColor(unselectedColor, for: .normal)
                $0.contentHorizontalAlignment = .center
                $0.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            }

            let stack = UIStackView(arrangedSubviews: [groundButton, beanButton])
            stack.axis = .horizontal
            stack.spacing = 20
            stack.distribution = .fillEqually

            addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: topAnchor),
                stack.bottomAnchor.constraint(equalTo: bottomAnchor),
                stack.leadingAnchor.constraint(equalTo: leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])

            updateUI()
        }

        @objc private func optionTapped(_ sender: UIButton) {
            if sender == groundButton {
                selectedType = .ground
            } else {
                selectedType = .bean
            }
        }

        private func updateUI() {
            switch selectedType {
            case .ground:
                groundButton.setTitle("  ● Ground", for: .normal)
                groundButton.setTitleColor(selectedColor, for: .normal)
                beanButton.setTitle("  ○ Bean", for: .normal)
                beanButton.setTitleColor(unselectedColor, for: .normal)
            case .bean:
                beanButton.setTitle("  ● Bean", for: .normal)
                beanButton.setTitleColor(selectedColor, for: .normal)
                groundButton.setTitle("  ○ Ground", for: .normal)
                groundButton.setTitleColor(unselectedColor, for: .normal)
            }
        }
    }


    
    var title2Label: UILabel = {
        let object = UILabel()
        
        object.font = UIFont(name:"Inter-SemiBold", size: 20)
        object.numberOfLines = 0
        object.textColor = .white
        object.textAlignment = .left
        
        return object
    }()
    
    var title3Label: UILabel = {
        let object = UILabel()
        
        object.font = UIFont(name:"Inter-SemiBold", size: 20)
        object.numberOfLines = 0
        object.textColor = UIColor.white.withAlphaComponent(0.5)
        object.textAlignment = .left
        
        return object
    }()
    
    var title4Label: UILabel = {
        let object = UILabel()
        
        object.font = UIFont(name:"Inter-SemiBold", size: 20)
        object.numberOfLines = 0
        object.textAlignment = .left
        object.textColor = .white
        
        return object
    }()
    
    var orderNowButton: UIButton = {
        let object = UIButton()
        
        object.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        object.backgroundColor = UIColor(named: "ColorButton")
        object.titleLabel?.textColor = .white
        object.layer.cornerRadius = 4
        
        
        
        return object
    }()
    
    var priceLabel: UILabel = {
        let object = UILabel()
        
        object.font = UIFont(name:"Inter-Medium", size: 20)
        object.textColor = .white
        object.textAlignment = .left
        object.numberOfLines = 0
        
        return object
    }()
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setupUI()
        setup2Objects()
        
    }
    
    
    private func setupUI() {
        
        
        
        self.view.addSubview(banner2ImageView)
        
        banner2ImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.width.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview().inset(100)
            
            
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(title2Label)
        
        title2Label.snp.makeConstraints {
            $0.top.equalTo(banner2ImageView).offset(450)
            $0.left.equalTo(banner2ImageView.snp.left)
            $0.right.equalTo(banner2ImageView).offset(20)
            
            $0.centerX.equalToSuperview()
            
        }
        
        self.view.addSubview(title3Label)
        
        title3Label.snp.makeConstraints {
            $0.top.equalTo(title2Label).offset(100)
            $0.left.equalTo(title2Label).offset(150)
            $0.right.equalTo(title2Label).offset(50)
            
        }
        
        self.view.addSubview(title4Label)
        
        title4Label.snp.makeConstraints {
            $0.top.equalTo(title2Label).offset(60)
            $0.left.equalTo(title2Label).offset(-50)
            $0.right.equalTo(title2Label).offset(-80)
            
            
        }
        
        let selector = CoffeeTypeSelector()
        view.addSubview(selector)
        selector.snp.makeConstraints {
            $0.top.equalTo(title4Label.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(40)

        }

        
        let stepper = StepperView()
        view.addSubview(stepper)
        stepper.snp.makeConstraints {
            $0.top.equalTo(banner2ImageView).offset(500)
            $0.width.equalTo(120)
            $0.height.equalTo(40)
            $0.right.equalTo(banner2ImageView).offset(60)
            
        }
        
        self.view.addSubview(orderNowButton)
        orderNowButton.snp.makeConstraints {
            $0.width.equalTo(190)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(64)
            $0.right.right.equalToSuperview().inset(44)
            
            
        }
        
        self.view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.bottom.equalToSuperview().inset(64)
            $0.right.right.equalToSuperview().inset(270)
        }
    }
    
    
    
    private func setup2Objects() {
        title2Label.text = "BeanCoffee&GroundCoffee"
        title3Label.text = "How many grams of coffee do you need?"
        title4Label.text = "Enjoy the aroma of premium-quality coffee — available as whole beans or pre-ground for your convenience."
        orderNowButton.setTitle("Order Now", for: .normal)
        orderNowButton.addTarget(self, action: #selector(orderNowButtonPressed(_sender:)), for: .touchUpInside)
        priceLabel.text = "Price: $2.49"
        
    }
    
    @objc func orderNowButtonPressed(_sender: UIButton) {
        
        let alertController = UIAlertController(title: "Ordered Successfully!", message: "Expect your order to be delivered soon", preferredStyle: .alert)
       
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true)
        
    }

    
    

    
}
