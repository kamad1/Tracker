
import UIKit

protocol TrackersViewControllerProtocol: AnyObject {
    var presenter: TrackersViewPresenterProtocol? { get }
    func setupEmptyScreen()
}
