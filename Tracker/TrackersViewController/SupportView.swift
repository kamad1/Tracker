
import UIKit

class SupportView: UICollectionReusableView {
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.textColor = .ypBlack
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        title.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 12).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

