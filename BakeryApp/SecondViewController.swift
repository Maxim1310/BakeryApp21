





import UIKit
import SnapKit


class SecondViewController: UIViewController {
    
    struct Coffee: Codable {
        let title: String
        let description: String
        let ingredients: [String]
        let image: String
        let id: Int
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorBackground
        
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    
    class CoffeeTableViewCell: UITableViewCell {
        let coffeeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 18)
            label.numberOfLines = 0
            return label
        }()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.numberOfLines = 0
            return label
        }()
        
        let ingredientsLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12)
            label.textColor = .gray
            label.numberOfLines = 0
            return label
        }()
        
        var continueButton2: UIButton = {
            let object = UIButton()
            
            object.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
            object.backgroundColor = UIColor(named: "ColorButton")
            object.titleLabel?.textColor = .white
            object.layer.cornerRadius = 4
            return object
            
            
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
            
            
            
            coffeeImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.top.equalToSuperview().offset(16)
                make.width.height.equalTo(100)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(coffeeImageView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.top.equalToSuperview().offset(16)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.leading.equalTo(coffeeImageView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
            }
            
            ingredientsLabel.snp.makeConstraints { make in
                make.leading.equalTo(coffeeImageView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
                make.bottom.equalToSuperview().offset(-16)
            }
            
           
            continueButton2.snp.makeConstraints {
                $0.width.equalTo(241)
                $0.height.equalTo(40)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(64)
            }
            continueButton2.addTarget(self, action: #selector(buttonTapped2), for: .touchUpInside)
        }
        
        func configure(with coffee: Coffee) {
            titleLabel.text = coffee.title
            descriptionLabel.text = coffee.description
            ingredientsLabel.text = "Ингредиенты: \(coffee.ingredients.joined(separator: ", "))"
            
            continueButton2.setTitle("Continue", for: .normal)
            
            
            coffeeImageView.image = nil
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
            return tableView
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            navigationItem.title = "Кофейное меню"
            setupTableView()
            loadCoffeeData()
        }
        
        private func setupTableView() {
            view.addSubview(tableView)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(CoffeeTableViewCell.self, forCellReuseIdentifier: "CoffeeCell")
            
            tableView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        private func loadCoffeeData() {
            guard let url = URL(string: "https://api.sampleapis.com/coffee/hot") else {
                showError(message: "Неверный URL API")
                return
            }
            
            Task {
                do {
                    let fetchedCoffees = try await fetchCoffeeData(from: url)
                    coffees = fetchedCoffees
                    tableView.reloadData()
                } catch {
                    showError(message: "Не удалось загрузить данные о кофе: \(error.localizedDescription)")
                }
            }
        }
        
        private func fetchCoffeeData(from url: URL) async throws -> [Coffee] {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            let coffees = try decoder.decode([Coffee].self, from: data)
            return coffees
        }
        
        private func showError(message: String) {
            let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
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
    
    @objc func buttonTapped2() {
          print("Button was tapped!!")
           let vc = ThirdViewController()
           self.navigationController?.pushViewController(vc, animated: true)
      }
    
}
