import UIKit

class HabitViewController: UIViewController, HabitViewControllerProtocol, TextFieldCellDelegate, TimetableDelegate, CollectionCellDelegate {
    
    var presenter: HabitPresenterProtocol?
    
    enum Constant {
        static let textFieldCellIdentifier = "TextFieldCell"
        static let planningCellIdentifier = "PlaningCell"
        static let emojiCellIdentifier = "EmojiCell"
        static let colorCellIdentifier = "ColorCell"
    }
    
    enum Section: Int, CaseIterable {
        case textField
        case planning
        case emoji
        case color
        
        enum Row {
            case textField
            case category
            case schedule
            case emoji
            case color
        }
    }
    
    private let emojis: [String] = ["🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝️", "😪"]
    
    private let colors: [UIColor] = [.ypSelection1, .ypSelection2, .ypSelection3, .ypSelection4, .ypSelection5, .ypSelection6, .ypSelection7, .ypSelection8, .ypSelection9, .ypSelection10, .ypSelection11, .ypSelection12, .ypSelection13, .ypSelection14, .ypSelection15, .ypSelection16, .ypSelection17, .ypSelection18]
    
    private lazy var tableView: UITableView = {
        let planningTableView = UITableView(frame: .zero, style: .insetGrouped)
        planningTableView.translatesAutoresizingMaskIntoConstraints = false
        planningTableView.separatorStyle = .singleLine
        planningTableView.contentInsetAdjustmentBehavior = .never
        planningTableView.backgroundColor = .ypWhite
        planningTableView.isScrollEnabled = true
        planningTableView.showsVerticalScrollIndicator = false
        planningTableView.dataSource = self
        planningTableView.delegate = self
        planningTableView.allowsSelection = true
        return planningTableView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.ypRed.cgColor
        cancelButton.backgroundColor = .ypWhite
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        cancelButton.setTitleColor(.ypRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelHabitCreation), for: .touchUpInside)
        return cancelButton
    }()
    
    private lazy var createButton: UIButton = {
        let createButton = UIButton()
        createButton.layer.cornerRadius = 16
        createButton.backgroundColor = .ypBlack
        createButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        createButton.setTitleColor(.ypWhite, for: .normal)
        createButton.addTarget(self, action: #selector(createHabit), for: .touchUpInside)
        return createButton
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(createButton)
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 8
        buttonsStackView.distribution = .fillEqually
        return buttonsStackView
    }()
    
    func didSelect(weekdays: [Int]) {
        presenter?.schedule = weekdays
        updateButtonState()
        let section = Section.planning
        if let row = rowsForSection(section).firstIndex(of: Section.Row.schedule) {
            tableView.reloadRows(at: [IndexPath(row: row, section: section.rawValue)], with: .none)
        }
    }
    
    func didTextChange(text: String?) {
        presenter?.trackerName = text
        updateButtonState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewHabitScreen()
        tableView.reloadData()
    }
    
    private func setupNewHabitScreen() {
        self.hideKeyboardOnTap()
        view.backgroundColor = .ypWhite
        SetupAllSubViews()
        
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: Constant.textFieldCellIdentifier)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constant.planningCellIdentifier)
        tableView.register(CollectionCell.self, forCellReuseIdentifier: Constant.emojiCellIdentifier)
        tableView.register(CollectionCell.self, forCellReuseIdentifier: Constant.colorCellIdentifier)
        
        setupNavigationBar()
        
        cancelButton.setTitle("Отменить", for: .normal)
        createButton.setTitle("Создать", for: .normal)
        
        updateButtonState()
    }
    
    private func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = "Новая привычка"
        }
    }
    
    private func setupTableView() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setuupButtonsStackView() {
        buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func SetupAllSubViews() {
        view.addSubview(tableView)
        view.addSubview(buttonsStackView)
        setuupButtonsStackView()
        setupTableView()
    }
    
    private func rowsForSection(_ type: Section) -> [Section.Row] {
        switch type {
        case .textField:
            return [.textField]
        case .planning:
            switch presenter?.type {
            case .habit:
                return [.category, .schedule]
            case .notRegularEvent:
                return [.category]
            case .none:
                return []
            }
        case .emoji:
            return [.emoji]
        case .color:
            return [.color]
        }
    }
    
    @objc
    private func cancelHabitCreation() {
        dismiss(animated: true)
    }
    
    @objc
    private func createHabit() {
        presenter?.createNewTracker()
        dismiss(animated: true)
    }
    
    private func textFieldCell(at indexPath: IndexPath, placeholder: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.textFieldCellIdentifier) as? TextFieldCell else {
            return UITableViewCell()
        }
        cell.placeholder = placeholder
        cell.delegate = self
        return cell
    }
    
    private func planningCell(at indexPath: IndexPath, title: String, subtitle: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.planningCellIdentifier) as? TableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func emojiCell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.emojiCellIdentifier) as? CollectionCell else { return UITableViewCell() }
        cell.delegate = self
        cell.type = .emoji(items: emojis)
        return cell
    }
    
    private func colorCell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.colorCellIdentifier) as? CollectionCell else { return UITableViewCell() }
        cell.delegate = self
        cell.type = .color(items: colors)
        return cell
    }
    
    private func showTimeTable() {
        let vc = TimetableViewController()
        let presenter = TimetablePresenter(view: vc, selected: presenter?.schedule ?? [], delegate: self)
        vc.presenter = presenter
        presenter.view = vc
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .coverVertical
        vc.isModalInPresentation = true
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true)
    }
    
    private func showCategory() {}
    
    private func updateButtonState() {
        createButton.isEnabled = presenter?.isValidForm ?? false
        createButton.backgroundColor = createButton.isEnabled ? .ypBlack : .ypGray
    }
    
    func didEmojiSet(emoji: String?) {
        presenter?.emoji = emoji
        updateButtonState()
    }
    
    func didColorSet(color: UIColor?) {
        presenter?.color = color
        updateButtonState()
    }
}

extension HabitViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        return rowsForSection(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch rowsForSection(section)[indexPath.row] {
            
        case .textField:
            return textFieldCell(at: indexPath, placeholder: "Введите название трекера")
        case .category:
            return planningCell(at: indexPath, title: "Категория", subtitle: presenter?.categoryName)
        case .schedule:
            return planningCell(at: indexPath, title: "Расписание", subtitle: presenter?.sheduleString)
        case .emoji:
            return emojiCell(at: indexPath)
        case .color:
            return colorCell(at: indexPath)
        }
    }
}

extension HabitViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch rowsForSection(section)[indexPath.row] {
        case .category:
            showCategory()
        case .schedule:
            showTimeTable()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { return 0 }
        switch rowsForSection(section)[indexPath.row] {
            
        case .textField, .category, .schedule:
            return 75
        case .emoji, .color:
            return UITableView.automaticDimension
        }
    }
}

