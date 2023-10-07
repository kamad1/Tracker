import UIKit

protocol HabitPresenterProtocol {
    
    var schedule: [Int] { get set }
    
    var type: TrackerType { get set }
    
    var view: HabitViewControllerProtocol? { get }
    
    var trackerName: String? { get set }
    
    var subTitleForCategory: String { get set }
    
    var selectedCategory: TrackerCategory? { get }
    
    var isValidForm: Bool { get }
    
    func createNewTracker()
}
