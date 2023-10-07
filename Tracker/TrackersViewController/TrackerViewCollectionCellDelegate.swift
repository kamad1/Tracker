

import UIKit


protocol TrackerViewCollectionCellDelegate: AnyObject {
    func toDidCompleted(_ complete: Bool,  tracker: Tracker)
}
