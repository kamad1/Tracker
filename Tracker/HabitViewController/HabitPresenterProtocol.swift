import UIKit

protocol HabitPresenterProtocol {
    var view: HabitViewControllerProtocol? { get }
    var trackerName: String? { get set }
    var subtitleForCategory: String { get set }
    var type: TrackerType { get set }
    func createNewTracker()
    var selectedCategory: TrackerCategory? { get }
    var schedule: [Int] { get set }
    var isValidForm: Bool { get }
}
