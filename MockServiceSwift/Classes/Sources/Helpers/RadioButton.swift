import UIKit

class RadioButton: UIButton {
    
    var radioSelected: UIImage? {
        return UIImage(named: "ic_radio_selected", in: MockServices.bundle, compatibleWith: nil)
    }
    
    var radioUnselectedSelected: UIImage? {
        return UIImage(named: "ic_radio_unselected", in: MockServices.bundle, compatibleWith: nil)
    }
    
    var isChecked: Bool {
        set {
            self.isSelected = newValue
        }
        get {
            return self.isSelected
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setImage(radioSelected, for: .selected)
        setImage(radioUnselectedSelected, for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        self.isSelected = !self.isSelected
    }
}
