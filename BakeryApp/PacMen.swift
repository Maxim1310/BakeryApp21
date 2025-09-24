
//  PacMen.swift




import UIKit

class PacManTransitionViewController: UIViewController {
    private let pacManView = UIView()
    private let pacManShapeLayer = CAShapeLayer()
    private var dots: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupPacMan()
        setupDots(count: 8)
        animatePacMan()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupPacMan() {
        pacManView.frame = CGRect(x: -50, y: view.frame.height / 2 - 25, width: 50, height: 50)
        pacManView.layer.addSublayer(pacManShapeLayer)
        view.addSubview(pacManView)
        pacManShapeLayer.fillColor = UIColor.yellow.cgColor
        updatePacManPath(openAngle: 0)
    }
    
    private func updatePacManPath(openAngle: CGFloat) {
        let center = CGPoint(x: 25, y: 25)
        let startAngle = openAngle
        let endAngle = 2 * .pi - openAngle
        
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: 25, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        pacManShapeLayer.path = path.cgPath
    }
    
    private func createPacmanPath(openAngle: CGFloat) -> UIBezierPath {
        let center = CGPoint(x: 25, y: 25)
        let startAngle = openAngle
        let endAngle = 2 * .pi - openAngle
        
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: 25, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        return path
    }
    
    private func setupDots(count: Int) {
        let dotSize: CGFloat = 10
        for i in 0..<count {
            let dot = UIView()
            let spacing = CGFloat(i + 1) * 40
            dot.frame = CGRect(x: spacing + 80, y: view.frame.height / 2 - dotSize / 2, width: dotSize, height: dotSize)
            dot.backgroundColor = .white
            dot.layer.cornerRadius = dotSize / 2
            view.addSubview(dot)
            dots.append(dot)
        }
    }
    
    private func animatePacMan() {
        // Рот
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.2
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        let closedPath = createPacmanPath(openAngle: 0)
        let openPath = createPacmanPath(openAngle: .pi / 6)
        
        animation.fromValue = closedPath.cgPath
        animation.toValue = openPath.cgPath
        pacManShapeLayer.add(animation, forKey: "mouth")
        
        // Движение
        UIView.animate(withDuration: 2.5, delay: 0, options: .curveLinear, animations: {
            self.pacManView.frame.origin.x = self.view.frame.width + 50
        }, completion: { _ in
            self.dismiss(animated: false) {
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    let navController = UINavigationController(rootViewController: CoffeeListViewController())
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                }
            }
        })
        
        // Поедание точек
        for (i, dot) in dots.enumerated() {
            let delay = Double(i) * 0.3 + 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                UIView.animate(withDuration: 0.2, animations: {
                    dot.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    dot.alpha = 0
                }, completion: { _ in
                    dot.removeFromSuperview()
                })
            }
        }
    }
}
