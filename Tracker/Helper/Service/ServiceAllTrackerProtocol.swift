
import UIKit

protocol ServiceAllTrackerProtocol {
    var categories: [TrackerCategory] { get set }
    var completedTrackers: Set<TrackerRecord> { get set }
}
