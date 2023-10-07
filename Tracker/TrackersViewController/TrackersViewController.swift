

import UIKit

final class TrackersViewController: UIViewController, TrackersViewControllerProtocol, TrackerTypeDelegate, NewHabitDelegate, TrackerViewCollectionCellDelegate {
    
    enum TrackerConstant {
        static let cellIdentifier = "TrackerCell"
        static let contentInsets: CGFloat = 16
        static let spacing: CGFloat = 9
    }
    
    var presenter: TrackersViewPresenterProtocol?
    var comletedTracker: Bool = false
    //Делегаты
    func didSelectType(_ type: TrackerType) {
        let viewCont3 = HabitViewController()
        let presenter = HabitPresenter(type: type, categories: presenter?.categories ?? [])
        
        viewCont3.presenter = presenter
        presenter.view = viewCont3
        
        presenter.delegate = self
        
        viewCont3.modalPresentationStyle = .formSheet
        viewCont3.modalTransitionStyle = .coverVertical
        viewCont3.isModalInPresentation = true
        let navigationController = UINavigationController(rootViewController: viewCont3)
        self.present(navigationController, animated: true)
    }
    
    //ХоботДелегат)
    func didCreateTracker(_ tracker: Tracker, at category: TrackerCategory) {
        presenter?.addTracker(tracker, at: category)
        trackersCollectionView.reloadData()
    }
    
    func toDidCompleted(_ complete: Bool, tracker: Tracker) {
        presenter?.completedTracker(complete, tracker: tracker)
        comletedTracker = !comletedTracker
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateCategories()
        allSetup()
    }
    
    private func allSetup() {
        view.backgroundColor = .ypWhite
        setupNavigationBar()
        addSubviews()
        setupTrackersCollectionView()
        setupEmptyScreenView()
    }
    
    private lazy var emptyScreenView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyScreenImage)
        view.addSubview(emptyScreenText)
        
        emptyScreenImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            emptyScreenImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            emptyScreenText.topAnchor.constraint(equalTo: emptyScreenImage.bottomAnchor, constant: 8).isActive = true
            emptyScreenText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    private lazy var emptyScreenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EmptyTrackers")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emptyScreenText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Что будем отслеживать?"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var trackersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .ypWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: TrackerConstant.cellIdentifier)
        collectionView.register(TrackerViewCollectionCell.self, forCellWithReuseIdentifier: TrackerConstant.cellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 24, left: TrackerConstant.contentInsets, bottom: 24, right: TrackerConstant.contentInsets)
        collectionView.register(SupportView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    private lazy var datePickerButton: UIBarButtonItem = {
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(setDateForTrackers), for: .valueChanged)
// Закомитил так как это визуально прикольно но ограничивать даты просмотра привычек противоречит ТЗ как вариант эксперементировать в будущем оставлю
//        datePicker.maximumDate = Date()
        let dateButton = UIBarButtonItem(customView: datePicker)
        
        return dateButton
    }()
    
    private func addSubviews() {
        view.addSubview(trackersCollectionView)
        view.addSubview(emptyScreenView)
    }
    
    private func setupTrackersCollectionView() {
        trackersCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        trackersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trackersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupEmptyScreenView() {
        emptyScreenView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        emptyScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushTrackerTypeViewController))
        leftButton.tintColor = .ypBlack
        navigationBar.topItem?.setLeftBarButton(leftButton, animated: true)
        
        navigationBar.topItem?.title = "Трекеры"
        navigationBar.prefersLargeTitles = true
        navigationBar.topItem?.largeTitleDisplayMode = .always
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationBar.topItem?.searchController = searchController
        
        navigationBar.topItem?.setRightBarButton(datePickerButton, animated: true)
    }
    
     func setupEmptyScreen() {
         let isSearch = presenter?.search.isEmpty ?? true
                  emptyScreenImage.image = isSearch ? UIImage(named: "EmptyTrackers") : UIImage(named: "EmptyStatistics")
         emptyScreenText.text = isSearch ? "Что будем отслеживать?" : "Ничего не найдено"
        emptyScreenView.isHidden = presenter?.categories.count ?? 0 > 0
        trackersCollectionView.isHidden = presenter?.categories.count == 0
    }
    
    @objc
    private func pushTrackerTypeViewController() {
        let viewCont2 = TrackerTypeViewController()
        let presenter = TrackerTypePresenter()
        
        viewCont2.presenter = presenter
        presenter.view = viewCont2
        
        presenter.delegate = self
        viewCont2.modalTransitionStyle = .coverVertical
        viewCont2.modalPresentationStyle = .formSheet
        let navigationController = UINavigationController(rootViewController: viewCont2)
        self.present(navigationController, animated: true)
    }
    
    @objc
    private func setDateForTrackers(_ sender: UIDatePicker) {
        presenter?.currentDate = sender.date
        trackersCollectionView.reloadData()
    }
}

extension TrackersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search = searchText
        trackersCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.search = ""
        trackersCollectionView.reloadData()
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - TrackerConstant.contentInsets * 2 - TrackerConstant.spacing) / 2 , height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return TrackerConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 0, bottom: 16, right: 0)
    }
}

extension TrackersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let id = "header"
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? SupportView else { return UICollectionReusableView() }
        view.title.text = presenter?.categories[indexPath.section].name
        return view
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        setupEmptyScreen()
        return presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerConstant.cellIdentifier, for: indexPath) as? TrackerViewCollectionCell,
              let presenter
        else { return UICollectionViewCell() }
        cell.viewModel = presenter.trackerViewModel(at: indexPath)
        cell.delegate = self
        return cell
    }
}
