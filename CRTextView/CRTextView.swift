//
//  CRTextView.swift
//  CRTextView
//
//  Created by Insu Byeon on 2021/04/21.
//

#if canImport(UIKit)
import UIKit

@IBDesignable
final class CRTextView: UITextView {
  
  @IBInspectable
  var placeholder: String = "" {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable
  var placeholderColor: UIColor = .systemGray {
    didSet {
      setNeedsLayout()
    }
  }
  
  @IBInspectable
  lazy var placeholderPoint: CGPoint = .init(x: 6, y: 8) {
    didSet {
      setNeedsLayout()
    }
  }

  private lazy var placeholderLabel: UILabel = {
    let label = UILabel(
      frame: CGRect(
        origin: placeholderPoint,
        size: .init(width: bounds.size.width - 16, height: 40)
      )
    )
    
    label.lineBreakMode = .byTruncatingTail
    label.numberOfLines = 0
    label.font = font
    label.backgroundColor = .clear
    label.textAlignment = .left
    label.textColor = placeholderColor
    label.alpha = 1
    label.text = placeholder
    label.sizeToFit()
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(textViewDidChangeValue),
      name: UITextView.textDidChangeNotification,
      object: nil
    )
    addSubview(placeholderLabel)
  }

  @objc
  private func textViewDidChangeValue() {
    placeholderLabel.alpha = text.isEmpty ? 1 : 0
  }
  
  deinit {
    NotificationCenter.default.removeObserver(
      self,
      name: UITextView.textDidChangeNotification,
      object: nil
    )
  }
  
}
#endif

