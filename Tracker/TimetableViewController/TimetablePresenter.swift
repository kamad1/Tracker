

import UIKit

final class TimetablePresenter: TimetablePresenterProtocol {
    
    var view: TimetableViewControllerProtocol
    var delegate: TimetableDelegate
    
    var selectedWeekdays: [Int]
    let weekdays = DayFormatter.weekdays
    
    init(view: TimetableViewControllerProtocol, selected: [Int], delegate: TimetableDelegate) {
        self.view = view
        self.delegate = delegate
        self.selectedWeekdays = selected
    }
    
    func done() {
        delegate.didSelect(weekdays: selectedWeekdays)
        print(selectedWeekdays)
    }
}
