

import UIKit


protocol TrackerViewCollectionCellDelegate: AnyObject {
    func toDidComleted(_ complete: Bool,  tracker: Tracker)
}
