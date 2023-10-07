

import UIKit

final class TextFieldCell: UITableViewCell {
    
    var delegate: TextFieldCellDelegate?
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .always
        textField.delegate = self
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubviews()
        stupTextField()
        backgroundColor = .ypBackground
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(textField)
    }
    
    private func stupTextField() {
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

extension TextFieldCell: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didTextChange(text: textField.text)
    }
}
