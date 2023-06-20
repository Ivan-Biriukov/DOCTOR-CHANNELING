import UIKit

class TextFieldsLabel : UILabel {
    
    
    private let labelText: String
    
    init(labelText : String) {
        self.labelText = labelText
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = .averiaRegular22()
        text = labelText
        textColor = .black
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
}
