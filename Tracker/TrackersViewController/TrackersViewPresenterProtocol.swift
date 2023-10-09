
import UIKit

protocol TrackersViewPresenterProtocol {
    var view: TrackersViewControllerProtocol? { get }
    
    var search: String { get set }
    
    var currentDate: Date { get set }
    
    var visibleCategories: [TrackerCategory] { get }
    
    var categoriess: [TrackerCategory] { get }
    
    func addTracker(_ tracker: Tracker, at category: TrackerCategory)
    
    func completedTracker(_ complete: Bool, tracker: Tracker)
    
    func trackerViewModel(at indexPath: IndexPath) -> TrackerCell
    
    func updateCategories()
    
    func numberOfItemsInSection(section: Int) -> Int
    
    func numberOfSections() -> Int?
}
