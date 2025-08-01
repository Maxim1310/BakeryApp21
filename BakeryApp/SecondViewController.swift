
// SecondViewController


import UIKit
import SnapKit
import SDWebImage


struct Coffee: Codable {
    let title: String
    let description: String
    let ingredients: [String]
    let image: String
    let id: Int
}

class CoffeeTableViewCell: UITableViewCell {
   
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
       
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(image)
        
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(image.snp.left).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(image.snp.left).offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with coffee: Coffee) {
        titleLabel.text = coffee.title
        descriptionLabel.text = coffee.description
        image.sd_setImage(with: URL(string: coffee.image))
    }
}

// Основной контроллер
class CoffeeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var coffees: [Coffee] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
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
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
                print("Loaded \(coffees.count) coffees")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("Table view reloaded")
                }
            } catch {
                print("Error fetching coffee data: \(error)")
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
        print("numberOfRowsInSection called: \(coffees.count)")
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt called for indexPath: \(indexPath)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! CoffeeTableViewCell
        let coffee = coffees[indexPath.row]
        cell.configure(with: coffee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coffees = coffees[indexPath.row]
        let vc = ThirdViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt called for indexPath: \(indexPath)")
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        print("estimatedHeightForRowAt called for indexPath: \(indexPath)")
        return 150
    }
    
    
}

