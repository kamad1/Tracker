import UIKit

final class TrackersViewPresenter: TrackersViewPresenterProtocol {
    var categories: [TrackerCategory] = []
    weak var view: TrackersViewControllerProtocol?
    private let service = ServiceAllTracker()
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
}
