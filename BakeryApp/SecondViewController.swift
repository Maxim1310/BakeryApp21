
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
        navigationItem.title = "Coffee menu"
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
            loadCoffeeFromLocalFile()
            return
        }

        Task {
            do {
                let fetchedCoffees = try await fetchCoffeeData(from: url)
                self.coffees = fetchedCoffees
                print("Данные получены с API")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Ошибка получения данных с API: \(error.localizedDescription)")
                showError(message: "Не удалось загрузить данные с API. Загружаем резервные данные.")
                loadCoffeeFromLocalFile()
            }
        }
    }

    private func loadCoffeeFromLocalFile() {
        guard let fileURL = Bundle.main.url(forResource: "Data", withExtension: "json") else {
            print(" Data.json не найден")
            showError(message: "Локальный файл с кофе не найден")
            return
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try JSONDecoder().decode([Coffee].self, from: data)
            self.coffees = decoded
            print(" Данные загружены из файла Data.json")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            showError(message: "Ошибка загрузки локальных данных: \(error.localizedDescription)")
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
        let coffes = coffees[indexPath.row]
        let vc = ThirdViewController()
        vc.coffee = coffes
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

