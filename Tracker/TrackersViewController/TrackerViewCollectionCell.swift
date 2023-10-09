
import UIKit

final class TrackerViewCollectionCell: UICollectionViewCell {
    
    var delegate: TrackerViewCollectionCellDelegate?
    
    private var daysCounter: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    private var tracker: Tracker? {
        didSet {
            name.text = tracker?.name
            emoji.text = tracker?.emoji
            rectangleView.backgroundColor = tracker?.color
            counterButton.backgroundColor = tracker?.color
        }
    }
    
    private var completTracker: Bool = false {
        didSet {
            updateButonState()
        }
    }
    
    var viewModel: TrackerCell? {
        didSet {
            guard let viewModel else { return }
            setupViewModel(viewModel: viewModel)
        }
    }
    
    lazy var days: UILabel = {
        let days = UILabel()
        days.translatesAutoresizingMaskIntoConstraints = false
        days.font = .systemFont(ofSize: 12, weight: .medium)
        return days
    }()
    
    lazy var rectangleView: UIView = {
        let rectangleView = UIView()
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.layer.cornerRadius = 16
        return rectangleView
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        name.numberOfLines = 0
        return name
    }()
    
    lazy var emoji: UILabel = {
        let emoji = UILabel()
        emoji.translatesAutoresizingMaskIntoConstraints = false
        emoji.font = .systemFont(ofSize: 16)
        
        return emoji
    }()
    
    lazy var emojiBackground: UIView = {
        let emojiBackground = UIView()
        emojiBackground.translatesAutoresizingMaskIntoConstraints = false
        emojiBackground.layer.cornerRadius = 15
        emojiBackground.backgroundColor = UIColor(white: 1, alpha: 0.3)
        return emojiBackground
    }()
    
    lazy var counterButton: UIButton = {
        let counterButton = UIButton()
        counterButton.translatesAutoresizingMaskIntoConstraints = false
        counterButton.layer.cornerRadius = 20
        counterButton.addTarget(self, action: #selector(checkForToDay), for: .touchUpInside)
        return counterButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        updateButonState()
        setupRectangleView()
        setupName()
        setupEmoji()
        setupEmojiBackground()
        setupDays()
        setupCounterButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension TrackerViewCollectionCell {
    private func addSubviews() {
        contentView.addSubview(rectangleView)
        rectangleView.addSubview(name)
        rectangleView.addSubview(emojiBackground)
        emojiBackground.addSubview(emoji)
        contentView.addSubview(days)
        contentView.addSubview(counterButton)
    }
    
    
    private func setupRectangleView(){
        rectangleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        rectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        rectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupName() {
        name.topAnchor.constraint(greaterThanOrEqualTo: emojiBackground.bottomAnchor, constant: 4).isActive = true
        name.bottomAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: -12).isActive = true
        name.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 12).isActive = true
        name.trailingAnchor.constraint(equalTo: rectangleView.trailingAnchor, constant: -12).isActive = true
    }
    
    private func setupEmoji() {
        emoji.centerXAnchor.constraint(equalTo: emojiBackground.centerXAnchor).isActive = true
        emoji.centerYAnchor.constraint(equalTo: emojiBackground.centerYAnchor).isActive = true
    }
    
    private func setupEmojiBackground() {
        emojiBackground.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emojiBackground.widthAnchor.constraint(equalToConstant: 30).isActive = true
        emojiBackground.topAnchor.constraint(equalTo: rectangleView.topAnchor, constant: 12).isActive = true
        emojiBackground.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 12).isActive = true
    }
    
    private func setupDays() {
        days.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 16).isActive = true
        days.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
    }
    
    private func setupCounterButton() {
        counterButton.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 8).isActive = true
        counterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        counterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        counterButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func updateButonState() {
        switch completTracker {
        case true:
            counterButton.setImage(UIImage(named: "whiteJackdaw"), for: .normal)
            counterButton.alpha = 0.3
            counterButton.imageView?.tintColor = .ypWhite
        case false:
            counterButton.setImage(UIImage(systemName: "plus"), for: .normal)
            counterButton.alpha = 1
            counterButton.imageView?.tintColor = .ypWhite
        }
    }
    
    private func updateCountLabel() {
        let dayLabelCell = "\(daysCounter) дней"
        days.text = dayLabelCell
    }
    
    private func setupViewModel(viewModel: TrackerCell){
        daysCounter = viewModel.daysCounter
        tracker = viewModel.tracker
        completTracker = viewModel.isCompleted
        counterButton.isEnabled = viewModel.isComplitionEnable
    }
    
    @objc
    private func checkForToDay() {
        if completTracker {
            daysCounter -= 1
        } else {
            daysCounter += 1
        }
        completTracker = !completTracker
        guard let tracker else { return }
        delegate?.toDidCompleted(completTracker, tracker: tracker)
    }
}
