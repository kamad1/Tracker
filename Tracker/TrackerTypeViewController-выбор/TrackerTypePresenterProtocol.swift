
import UIKit

protocol TrackerTypePresenterProtocol {
    var view: TrackerTypeViewControllerProtocol? { get set }
    func selectType(_ type: TrackerType)
}
