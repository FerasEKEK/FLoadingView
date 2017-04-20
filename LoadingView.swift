//
//  LoadingView.swift
//  LoadingAnimationTest
//
//  Created by Firas Al Khatib Al Khalidi on 2/13/17.
//  Copyright © 2017 Firas Al Khatib Al Khalidi. All rights reserved.
//

import UIKit
class LoadingView: UIView {
    private static let shared = LoadingView()
    let overlay = UIVisualEffectView()
    var textAnimator: VRMTextAnimator!
    private init() {
        super.init(frame: .zero)
        self.addSubview(overlay)
        self.frame = UIScreen.main.bounds
        textAnimator = VRMTextAnimator(referenceView: self)
        textAnimator.delegate = self
        textAnimator.fontName = "Avenir-Roman"
        textAnimator.fontSize = 40
        textAnimator.textColor = UIColor.white.cgColor
        textAnimator.textToAnimate = "Loading"
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    func orientationChanged(){
        self.textAnimator.clearAnimationText()
        layoutSubviews()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    static func show(){
        LoadingView.shared.textAnimator.textToAnimate = "Loading"
        LoadingView.shared.textAnimator.fontSize = 20
        LoadingView.shared.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(LoadingView.shared)
        UIView.animate(withDuration: 0.5, animations: {
            LoadingView.shared.overlay.effect = UIBlurEffect(style: .dark)
            LoadingView.shared.alpha = 1
        }) { (Bool) in
            LoadingView.shared.textAnimator.startAnimation()
        }
    }
    static func show(withText text: String){
        LoadingView.shared.textAnimator.textToAnimate = text
        LoadingView.shared.textAnimator.fontSize = 20
        LoadingView.shared.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(LoadingView.shared)
        UIView.animate(withDuration: 0.5, animations: {
            LoadingView.shared.overlay.effect = UIBlurEffect(style: .dark)
            LoadingView.shared.alpha = 1
        }) { (Bool) in
            LoadingView.shared.textAnimator.startAnimation()
        }
    }
    static func show(withText text: String, fontSize: CGFloat, textColor: UIColor, textOutlineColor: UIColor, andBlurEffectStyle style: UIBlurEffectStyle){
        LoadingView.shared.textAnimator.textToAnimate = text
        LoadingView.shared.textAnimator.fontSize = fontSize
        LoadingView.shared.textAnimator.textBorderColor = textOutlineColor.cgColor
        LoadingView.shared.textAnimator.textColor = textColor.cgColor
        LoadingView.shared.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(LoadingView.shared)
        UIView.animate(withDuration: 0.5, animations: {
            LoadingView.shared.overlay.effect = UIBlurEffect(style: style)
            LoadingView.shared.alpha = 1
        }) { (Bool) in
            LoadingView.shared.textAnimator.startAnimation()
        }
    }
    static func show(withText text: String, fontSize: CGFloat, andBlurEffectStyle style: UIBlurEffectStyle){
        LoadingView.shared.textAnimator.textToAnimate = text
        LoadingView.shared.textAnimator.fontSize = fontSize
        LoadingView.shared.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(LoadingView.shared)
        UIView.animate(withDuration: 0.5, animations: {
            LoadingView.shared.overlay.effect = UIBlurEffect(style: style)
            LoadingView.shared.alpha = 1
        }) { (Bool) in
            LoadingView.shared.textAnimator.startAnimation()
        }
    }
    static func hide(){
        UIView.animate(withDuration: 0.5, animations: { 
            LoadingView.shared.alpha = 0
            LoadingView.shared.overlay.effect = nil
        }) { (Bool) in
            LoadingView.shared.textAnimator.stopAnimation()
            LoadingView.shared.removeFromSuperview()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = UIScreen.main.bounds.size.height
        let width = UIScreen.main.bounds.size.width
        self.overlay.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: height >= width ? height:width , height: height < width ? width: height))
        self.frame = UIScreen.main.bounds
        self.textAnimator.referenceView = self
        self.textAnimator.defaultConfiguration()
    }
}
extension LoadingView: VRMTextAnimatorDelegate{
    func textAnimator(_ textAnimator: VRMTextAnimator, animationDidStop animation: CAAnimation) {
        textAnimator.clearAnimationText()
        textAnimator.startAnimation()
    }
    func textAnimator(_ textAnimator: VRMTextAnimator, animationDidStart animation: CAAnimation) {

    }
}
