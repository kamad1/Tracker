import UIKit

final class TrackersViewPresenter: TrackersViewPresenterProtocol {
    var categories: [TrackerCategory] = []
    weak var view: TrackersViewControllerProtocol?
    var search: String = "" {
        didSet {
            updateCategories()
        }
    }
    var currentDate: Date = Date() {
        didSet {
            updateCategories()
        }
    }
    
    private let service = ServiceAllTracker()
    
    func updateCategories() {
        categories = service.getCategories(date: currentDate, search: search)
    }
    
    func addTracker(_ tracker: Tracker, at category: TrackerCategory) {
        service.addTracker(tracker, at: category)
        updateCategories()
    }
    
    func completedTracker(_ completed: Bool, tracker: Tracker) {
        if completed {
            service.addCompliteTrackers(tracker: tracker, date: currentDate)
        } else {
            service.removeCompletedTrackers(tracker: tracker, date: currentDate)
        }
    }
    
    func isCompletedTracker(_ tracker: Tracker) -> Bool {
        service.completedTrackers.first(where: { $0.id == tracker.id && $0.date == currentDate }) != nil
    }
    
    func countRecordTracker(_ tracker: Tracker) -> Int {
        service.completedTrackers.filter({ $0.id == tracker.id }).count
    }
    
    func numberOfSections() -> Int? {
             view?.setupEmptyScreen()
             return categories.count
         }

    func numberOfItemsInSection(section: Int) -> Int {
             categories[section].trackers.count
         }
    func trackerViewModel(at indexPath: IndexPath) -> TrackerCell {
        let tracker = categories[indexPath.section].trackers[indexPath.row]
                 return TrackerCell(tracker: tracker, isCompleted: isCompletedTracker(tracker), daysCounter: countRecordTracker(tracker))
    }
}
