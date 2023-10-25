import UIKit

class DayFormatter {
    
    private static let dateFormatter = DateFormatter()
    
    static let weekdays = Calendar.current.weekdaySymbols
    
    static func shortWeekday(at index: Int) -> String {
        dateFormatter.shortWeekdaySymbols[index]
    }
}

extension Date {
    
    var weekdayIndex: Int {
        Calendar.current.component(.weekday, from: self) - 1
    }
}

