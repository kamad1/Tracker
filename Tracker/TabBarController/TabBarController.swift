
import UIKit

final class TabBarController: UITabBarController {
    
    private func getStatisticViewController() -> UINavigationController {
        let statistic = UINavigationController(rootViewController: StatisticsViewController())
        statistic.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(systemName: "hare.fill"), selectedImage: nil)
        return statistic
    }
    
    private func getTrackersViewController() -> UINavigationController {
        let viewCont = TrackersViewController()
        let presenter = TrackersViewPresenter()
        presenter.view = viewCont
        viewCont.presenter = presenter
        
        let trackers = UINavigationController(rootViewController: viewCont)
        trackers.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill"), selectedImage: nil)
        return trackers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [getTrackersViewController(), getStatisticViewController()]
    }
}
