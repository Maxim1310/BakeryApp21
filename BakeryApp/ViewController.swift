//
//  ViewController.swift
//  BakeryApp
//
//  Created by Bogdan on 12.05.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var bannerImageView: UIImageView = {
        let object = UIImageView()
        
        object.image = UIImage(named: "Banner")
        object.contentMode = .scaleAspectFit
        
        
        
        return object
    }()
    
    var titleLabel: UILabel = {
        let object = UILabel()
        
        object.font = UIFont(name:"Inter-SemiBold", size: 20)
        object.numberOfLines = 0
        object.textAlignment = .center
        object.textColor = .white
        
        
        return object
    }()
    
    var descriptionLabel: UILabel = {
        let object = UILabel()
        
        object.font = .systemFont(ofSize: 14)
        object.numberOfLines = 0
        object.textAlignment = .center
        object.textColor = .white
        
        return object
    }()
    
    var continueButton: UIButton = {
        let object = UIButton()
        
        object.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        object.backgroundColor = UIColor(named: "ColorButton")
        object.titleLabel?.textColor = .white
        object.layer.cornerRadius = 4
        return object
        
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.colorBackground

       
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setupObjects()
        setupUI()
        
    }
    private func setupUI() {
        
        continueButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    
        self.view.addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.width.equalToSuperview().inset(90)
            $0.left.right.equalToSuperview().inset(100)
            
            $0.centerX.equalToSuperview()
            
            
        }
        
        
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bannerImageView).offset(550)
            $0.left.equalTo(bannerImageView.snp.left)
            $0.right.equalTo(bannerImageView.snp.right)
            
        }
        
        self.view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
        }
        
        self.view.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.width.equalTo(241)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(64)
            
            
        }
    }

    private func setupObjects() {
        titleLabel.text = "The Only Coffee You’ll Love Our Coffee is Rich & Natural"
        descriptionLabel.text = "We use a unique method for cultivating our coffee beans."
        continueButton.setTitle("Continue", for: .normal)
        
        
        
    }
    
    @objc func buttonTapped() {
           print("Button was tapped!")
            let vc = SecondViewController()
            self.navigationController?.pushViewController(vc, animated: true)
       }
        

    
}
  
