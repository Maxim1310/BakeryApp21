

// ThirdViewController


import UIKit
import SnapKit
import SDWebImage

class ThirdViewController: UIViewController {
    
    private var isFavorite = false
    private var heartButton: UIBarButtonItem!
    public var coffee: Coffee!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorBackground
        
        
        setupData()
        
        setupHeartButton()
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func setupData () {
        banner2ImageView.sd_setImage(with: URL(string: coffee.image))
        
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
    
   

    
    var banner2ImageView: UIImageView = {
        let object = UIImageView()
        
        object.image = UIImage()
        object.contentMode = .scaleAspectFill
        object.clipsToBounds = true
        object.layer.cornerRadius = 10
        
        
        return object
    }()
    
    var phrase: UILabel = {
            let object = UILabel()
            
            object.font = UIFont(name:"Inter-Medium", size: 20)
            object.textColor = .white
            object.textAlignment = .left
            object.numberOfLines = 0
            
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(40)
            $0.height.equalTo(banner2ImageView.snp.width).multipliedBy(1.2)
        }
        
        self.view.addSubview(phrase)
        phrase.snp.makeConstraints {
            $0.top.equalTo(banner2ImageView.snp.bottom).offset(40)
            $0.left.equalTo(banner2ImageView.snp.left)
            $0.width.equalTo(200)
            
        }

        
        let stepper = StepperView()
        view.addSubview(stepper)
        stepper.snp.makeConstraints {
            $0.top.equalTo(banner2ImageView).offset(450)
            $0.width.equalTo(120)
            $0.height.equalTo(40)
            $0.right.equalTo(banner2ImageView).offset(10)
            
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
        
        phrase.text = "Aromatic coffee made with care — the perfect start to your day."
        orderNowButton.setTitle("Order Now", for: .normal)
        orderNowButton.addTarget(self, action: #selector(orderNowButtonPressed(_sender:)), for: .touchUpInside)
        priceLabel.text = "Price: $2.49"
        
    }
    
    
    @objc func orderNowButtonPressed(_sender: UIButton) {
        
        let alertController = UIAlertController(title: "Ordered Successfully!",
                                                message: "Expect your order to be delivered soon", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true)
        
    }
    
}

