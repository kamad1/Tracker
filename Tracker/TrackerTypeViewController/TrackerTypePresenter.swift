

import UIKit

class TrackerTypePresenter: TrackerTypePresenterProtocol {
    
    var view: TrackerTypeViewControllerProtocol?
    var delegate: TrackerTypeDelegate?
    func selectType(_ type: TrackerType) {
        delegate?.didSelectType(type)
    }
}
