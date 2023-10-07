

import UIKit

protocol TrackersViewPresenterProtocol {
    var view: TrackersViewControllerProtocol? { get }
    var currentDate: Date { get set }
    var categories: [TrackerCategory] { get }
    func addTracker(_ tracker: Tracker, at category: TrackerCategory)
}
