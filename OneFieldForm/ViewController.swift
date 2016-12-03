//
//  ViewController.swift
//  OneFieldForm
//
//  Created by becarefullee on 2016/12/2.
//  Copyright © 2016年 Qinyuan-Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
  
  var step: Step = .One
  
  enum Step {
    case One
    case Two
    case Three
    case Four
    mutating func next() {
      switch self {
      case .One:
        self = .Two
      case .Two:
        self = .Three
      case .Three:
        self = .Four
      case .Four:
        self = .Four
      }
    }
  }
  @IBAction func signupBtnPressed(_ sender: UIButton) {
    
    UIView.animate(withDuration: 0.05, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: [], animations: {
      self.bg.transform = CGAffineTransform(scaleX: 0.8 , y: 0.9)
    }, completion: { Void in
      UIView.animate(withDuration: 0.1, animations: {
        self.signup.alpha = 0
      })
      UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: [], animations: {
        self.bg.transform = CGAffineTransform.identity
        self.label.alpha = 1
        self.textview.alpha = 1
        self.emailLeading.constant = 0
        self.email.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
        self.email.transform = CGAffineTransform.identity
        self.nextTrailing.constant = 0
        self.view.layoutIfNeeded()
      }, completion: { Void in })
      UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [], animations: {
        self.passLeading.constant = 0
        self.pass.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
        self.pass.transform = CGAffineTransform.identity
        self.view.layoutIfNeeded()
      }, completion: { Void in })
      UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [], animations: {
        self.avaLeading.constant = 0
        self.ava.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
        self.ava.transform = CGAffineTransform.identity
        
        self.view.layoutIfNeeded()
      }, completion: { Void in })
    })
  }
  
  @IBOutlet weak var centerx: NSLayoutConstraint!
  @IBOutlet weak var nextTrailing: NSLayoutConstraint!
  @IBOutlet weak var nextBtn: UIButton!
  @IBOutlet weak var signup: UIButton!
  @IBOutlet weak var avaLeading: NSLayoutConstraint!
  @IBOutlet weak var emailLeading: NSLayoutConstraint!
  @IBOutlet weak var passLeading: NSLayoutConstraint!
  @IBOutlet weak var textview: UITextView!
  @IBOutlet weak var label: UILabel!
  var textViewWidth: CGFloat?
  @IBAction func next(_ sender: Any) {
    if textview.text == "" {
      shakeAnimation(view: bg)
      return
    }
    
    switch step {
    case .One:
      textview.isSecureTextEntry = true
      animate(view: ava, withLabel: "Password", withLeading: avaLeading, step: step)
    case .Two:
      textview.isSecureTextEntry = false
      animate(view: pass, withLabel: "Email", withLeading: passLeading, step: step)
    case .Three:
      animate(view: email, withLabel: "", withLeading: emailLeading, step: step)
    case .Four:
      print("end")
    }
  }
  
  @IBOutlet weak var bg: UIView!
  @IBOutlet weak var ava: UIImageView!
  @IBOutlet weak var pass: UIImageView!
  
  @IBOutlet weak var email: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bg.layer.borderWidth = 1
    bg.layer.borderColor = UIColor.white.cgColor
    bg.layer.cornerRadius = bg.bounds.size.height/2
    bg.clipsToBounds = true
    
    pass.layer.borderColor = UIColor.white.cgColor
    pass.layer.borderWidth = 1
    pass.layer.cornerRadius = bg.bounds.size.height/2
    pass.clipsToBounds = true
    
    email.layer.borderColor = UIColor.white.cgColor
    email.layer.borderWidth = 1
    email.layer.cornerRadius = bg.bounds.size.height/2
    email.clipsToBounds = true
    
    ava.layer.borderColor = UIColor.white.cgColor
    ava.layer.borderWidth = 1
    ava.layer.cornerRadius = bg.bounds.size.height/2
    ava.clipsToBounds = true
    textview.delegate = self
    ava.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
    email.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
    pass.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
    
    
    
    label.alpha = 0
    textview.alpha = 0
    UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
      //      self.textview.text = ""
      self.bg.transform = CGAffineTransform(scaleX: 0.7 , y: 1.0)
      self.bg.transform = CGAffineTransform.identity
      
    }, completion: { Void in
    })
    
    
  }
  
  func textViewDidChange(_ textView: UITextView) {
    print(textview.contentSize.width)
    textViewWidth = textView.contentSize.width
  }
  
  func animate(view: UIImageView, withLabel: String, withLeading: NSLayoutConstraint, step: Step) {
    UIView.animate(withDuration: 0.3, animations: {
      self.textview.alpha = 0
      self.label.alpha = 0
      view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/12)
    })
    
    UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
      self.textview.alpha = 1
      self.label.alpha = 1
      self.label.text = withLabel
      self.textview.text = ""
    }, completion: nil)
    
    UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.curveEaseIn], animations: {
      self.view.bringSubview(toFront: view)
      withLeading.constant = self.textViewWidth! + 150
      self.view.layoutIfNeeded()
    }, completion: { Void in
      self.step.next()
      withLeading.constant = -200
      UIView.animate(withDuration: 0.3, animations: {
        self.ava.transform = CGAffineTransform(rotationAngle: CGFloat.pi/12)
        self.ava.transform = CGAffineTransform.identity
      })
    })
  }
  
  
  func shakeAnimation(view: UIView) {
    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.9, options: [], animations: {
      view.transform = CGAffineTransform.identity
      view.transform = CGAffineTransform(translationX: 3, y: 0)
    }, completion: { Void in
      UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.9, options: [], animations: {
        view.transform = CGAffineTransform.identity
        view.transform = CGAffineTransform(translationX: -3, y: 0)
      }, completion: nil)
    })
  }
  
}

