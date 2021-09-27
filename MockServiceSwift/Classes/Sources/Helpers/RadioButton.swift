import UIKit

class RadioButton: UIButton {
    
    static let resourceBundle: Bundle = {
        let bundleName = "Resources"
        let bundle = Bundle(for: RadioButton.self)
        
        guard let resourceBundleURL = bundle.url(forResource: bundleName, withExtension: "bundle") else { return Bundle.main
        }
        
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            return Bundle.main
        }
        
        return resourceBundle
    }()
    
    var radioSelected: UIImage? {
        return UIImage(named: "ic_radio_selected", in: RadioButton.resourceBundle, compatibleWith: nil)
    }
    
    var radioUnselectedSelected: UIImage? {
        return UIImage(named: "ic_radio_unselected", in: RadioButton.resourceBundle, compatibleWith: nil)
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
