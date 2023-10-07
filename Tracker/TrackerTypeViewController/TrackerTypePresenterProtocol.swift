
import UIKit

protocol TrackerTypePresenterProtocol {
    var view: TrackerTypeViewControllerProtocol? { get }
    func selectType(_ type: TrackerType)
}
