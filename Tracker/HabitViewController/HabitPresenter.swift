

import UIKit

final class HabitPresenter: HabitPresenterProtocol {
    
    var delegate: NewHabitDelegate?
    
    var trackerName: String?
    
    var subTitleForCategory: String = ""
    
    var categories: [TrackerCategory]
    
    var selectedCategory: TrackerCategory?
    
    var view: HabitViewControllerProtocol?
    
    var type: TrackerType
    
    var schedule: [Int] = []
    
    var isValidForm: Bool {
        selectedCategory != nil && trackerName != nil && !schedule.isEmpty
    }
    
    init(type: TrackerType, categories: [TrackerCategory]) {
        self.type = type
        self.selectedCategory = categories.first
        self.categories = categories
    }
    
    // создаём новый трекер, вызов  из делегата, где в параметрах передаём значения ё имя берём с интерфейса, а категория создана выше
    func createNewTracker() {
        guard let name = trackerName,
              let selectedCategory
        else { return }
        
        let newTracker = Tracker(id: UUID(), name: name, color: .ypSelection2 ?? .black, emoji: "🌺", schedule: schedule)
        
        delegate?.didCreateTracker(newTracker, at: selectedCategory)
        
    }
    
}
