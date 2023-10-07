

import UIKit

protocol TimetablePresenterProtocol {
    var view: TimetableViewControllerProtocol { get }
    var selectedWeekdays: [Int] { get set }
    var weekdays: [String] { get }
    func done()
}
