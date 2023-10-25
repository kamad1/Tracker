
import UIKit

class TrackerTypeViewController: UIViewController, TrackerTypeViewControllerProtocol {
    
    var presenter: TrackerTypePresenterProtocol?
    
    private lazy var newHabitButton: UIButton = {
        let newHabitButton = UIButton()
        newHabitButton.layer.cornerRadius = 16
        newHabitButton.backgroundColor = .ypBlack
        newHabitButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        newHabitButton.setTitleColor(.ypWhite, for: .normal)
        newHabitButton.addTarget(self, action: #selector(pushNewHabitViewController), for: .touchUpInside)
        return newHabitButton
    }()
    
    private lazy var newUnregularEventButton: UIButton = {
        let newUnregularEventButton = UIButton()
        newUnregularEventButton.layer.cornerRadius = 16
        newUnregularEventButton.backgroundColor = .ypBlack
        newUnregularEventButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        newUnregularEventButton.setTitleColor(.ypWhite, for: .normal)
        newUnregularEventButton.addTarget(self, action: #selector(pushUnregularEventViewController), for: .touchUpInside)
        return newUnregularEventButton
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.addArrangedSubview(newHabitButton)
        buttonsStackView.addArrangedSubview(newUnregularEventButton)
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 16
        buttonsStackView.distribution = .fillEqually
        return buttonsStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrackerTypeScreen()
    }
    
    private func setupTrackerTypeScreen() {
        view.backgroundColor = .ypWhite
        setupNavigationBar()
        setupAddSubViews()
        newHabitButton.setTitle("Привычка", for: .normal)
        newUnregularEventButton.setTitle("Нерегулярное событие", for: .normal)
    }
    
    private func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = "Создание трекера"
        }
    }
    
    private func setupAddSubViews() {
        view.addSubview(newHabitButton)
        view.addSubview(newUnregularEventButton)
        view.addSubview(buttonsStackView)
        buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 136).isActive = true
    }
    
    @objc
    private func pushNewHabitViewController(sender: UIButton) {
        dismiss(animated: true) {
            self.presenter?.selectType(.habit)
        }
    }
    
    @objc
    private func pushUnregularEventViewController(sender: UIButton) {
        dismiss(animated: true) {
            self.presenter?.selectType(.notRegularEvent)
        }
    }
}
