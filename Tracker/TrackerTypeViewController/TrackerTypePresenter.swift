

import UIKit

final class TrackerTypePresenter: TrackerTypePresenterProtocol {
    
    weak var view: TrackerTypeViewControllerProtocol?
    var delegate: TrackerTypeDelegate?
    func selectType(_ type: TrackerType) {
        delegate?.didSelectType(type)
    }
}
