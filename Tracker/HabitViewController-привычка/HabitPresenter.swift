
import UIKit

final class HabitPresenter: HabitPresenterProtocol {
    
    weak var view: HabitViewControllerProtocol?
    
    var delegate: NewHabitDelegate?
    
    var trackerName: String?
    
    var subTitleForCategory: String = ""
    
    var categories: [TrackerCategory]
    
    var categoryName: String? {
        selectedCategory?.name
    }

    var selectedCategory: TrackerCategory? {
        didSet {
            
        }
    }
    var emoji: String? {
        didSet {
            print(emoji)
        }
    }
    var color: UIColor? {
        didSet {
            print(color)
        }
    }
    
    var type: TrackerType
    
    var schedule: [Int] = []
    
    var sheduleString: String {
        if schedule.count == DayFormatter.weekdays.count {
            return "Каждый день"
        } else {
            return schedule.map { DayFormatter.shortWeekday(at: $0)}.joined(separator: ", ")
        }
    }
    // jтвечает за активацию кнопок
    var isValidForm: Bool {
        switch type {
        case .habit:
            return selectedCategory != nil && trackerName != nil && trackerName != "" && !schedule.isEmpty && emoji != nil && color != nil
        case .notRegularEvent:
            return selectedCategory != nil && trackerName != nil && trackerName != "" && emoji != nil && color != nil
        }
    }
    

    init(type: TrackerType, categories: [TrackerCategory]) {
        self.type = type
        self.selectedCategory = categories.first
        self.categories = categories
    }
    
    // создаём новый трекер, вызов  из делегата, где в параметрах передаём значения ё имя берём с интерфейса, а категория создана выше
    func createNewTracker() {
        guard let name = trackerName,
              let selectedCategory,
              let emoji,
              let color
        else { return }

        let newTracker = Tracker(id: UUID(), name: name, color: color, emoji: emoji, schedule: schedule)
        
        delegate?.didCreateTracker(newTracker, at: selectedCategory)
    }
}
