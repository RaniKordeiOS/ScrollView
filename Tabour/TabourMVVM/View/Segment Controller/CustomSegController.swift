//
//  CustomSegController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 25/10/22.
//

import Foundation
import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl{
    
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    //MARK: property of custom SegmentControl View
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet{
            updateView()
        }
    }
    //MARK: Function updateView
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        let buttonsTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonsTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button: )), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttonsTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        //MARK: Stack View for buttons
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    //MARK: Override Function draw
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    //MARK: Function button tapped
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, buttonn) in buttons.enumerated() {
            buttonn.setTitleColor(textColor, for: .normal)
            
            if buttonn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                } )
                buttonn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }// end of func
    
}
 
