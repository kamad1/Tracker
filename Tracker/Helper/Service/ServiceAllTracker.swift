
import UIKit

final class ServiceAllTracker: ServiceAllTrackerProtocol {
    
    var categories: [TrackerCategory] = []
    //    var visibleCategories: [TrackerCategory] = []
    var completedTrackers: Set<TrackerRecord> = []
    
    init() {
        let tracker = Tracker(id: UUID(), name: "Поливать растения", color: .ypSelection18, emoji: "❤️", schedule: [2])
        let category = TrackerCategory(name: "Домашний уют", trackers: [tracker])
        categories.append(category)
        let tracker1 = Tracker(id: UUID(), name: "Кошка заслонила камеру на созвоне", color: .ypSelection12, emoji: "😻", schedule: [3, 2])
        let tracker2 = Tracker(id: UUID(), name: "Бабушка прислала открытку в вотсапеБабушка прислала открытку в вотсапе", color: .ypSelection16, emoji: "🌺", schedule: [2])
        let tracker3 = Tracker(id: UUID(), name: "Свидания в апреле", color: .ypSelection11, emoji: "❤️", schedule: [3, 2])
        let category2 = TrackerCategory(name: "Радостные мелочи", trackers: [tracker1, tracker2, tracker3])
        categories.append(category2)
    }
    
    func getCategories(date: Date, search: String) -> [TrackerCategory] {
        let weekday = date.weekdayIndex
        var result: [TrackerCategory] = []
        for category in categories {
            let trackers = search.isEmpty ? category.trackers.filter({ $0.schedule.contains(weekday) }) : category.trackers.filter({ $0.schedule.contains(weekday) && $0.name.contains(search) })
            if !trackers.isEmpty {
                let newCategory = TrackerCategory(name: category.name, trackers: trackers)
                result.append(newCategory)
            }
        }
        return result
    }
    
    func addTracker(_ tracker: Tracker, at category: TrackerCategory) {
        var trackers = category.trackers
        
        trackers.append(tracker)
        
        let newCategory = TrackerCategory(name: category.name, trackers: trackers)
        var categories = self.categories
        
        if let index = categories.firstIndex(where: { $0.name == category.name } ) {
            categories[index] = newCategory
        } else {
            categories.append(newCategory)
        }
        self.categories = categories
    }
    
    func addCompliteTrackers(tracker: Tracker, date: Date) {
        var completedTrackers = self.completedTrackers
        let trackerToRecord = TrackerRecord(id: tracker.id, date: date)
        
        completedTrackers.insert(trackerToRecord)
        
        self.completedTrackers = completedTrackers
        
    }
    
    func removeCompletedTrackers(tracker: Tracker, date: Date) {
        var completedTrackers = self.completedTrackers
        let trackerToRemove = TrackerRecord(id: tracker.id, date: date)
        
        completedTrackers.remove(trackerToRemove)
        
        self.completedTrackers = completedTrackers
    }
}

