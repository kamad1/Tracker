import UIKit

protocol NewHabitDelegate {
    func didCreateTracker(_ tracker: Tracker, at category: TrackerCategory)
}
