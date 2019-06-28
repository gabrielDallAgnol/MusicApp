//
//  InitalViewController.swift
//  MusicApp
//
//  Created by Palmsoft  on 25/06/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    // MARK: - UTILS
    let color = Colors.color
    let font = Fonts.font
    
    // MARK: - ANIMATION
    let transition = CircularTransition()
    var pulseLayers = [CAShapeLayer]()

    // MARK: - Button
    @IBOutlet weak var StartButton: UIButton!
    
    // MARK: - UIView
    @IBOutlet var BackgroundView: UIView!
    
    // MARK: - UIIMAGE
    @IBOutlet weak var headphone: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // MARK: - UILABEL
    @IBOutlet weak var ClickLabel: UILabel!
    
    
    // MARK: - VARIABLES
    var delay: Int!
    var timer: Timer!
    var check1: Bool!
    var check2: Bool!
  
    // MARK: - SETUP LAYOUT
    func SetupLayout() {
        headphone.image = UIImage(named: "headphones")
        headphone.contentMode = .center
        backgroundImage.image = UIImage(named: "home")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.2
        BackgroundView.backgroundColor = color.fontColor
        StartButton.setTitle("", for: UIControl.State.normal)
        StartButton.bordedButton(borderColor: color.quaternaryColor, backgroundColor: color.clearColor, widthBorder: 2.50, radiusBorder: StartButton.frame.width/2)
        StartButton.isUserInteractionEnabled = false
        ClickLabel.textColor = color.quaternaryColor
        ClickLabel.text = "Só um instante..."
        ClickLabel.font = font.staticBold
        ClickLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupLayout()
        createPulse()
        check1 = false
        check2 = false
        delay = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        
        // MARK: - REQUEST
        DataService.shared.getTopArtists() { (Bool) in }
    }
    
    // MARK: - TIMER LOOP
    @objc func loop() {
        delay -= 1
    
        if delay == 5{
            ClickLabel.fadeTransition(0.2)
            ClickLabel.text = "Pronto!"
        }
        if delay == 3{
            ClickLabel.fadeTransition(0.2)
            ClickLabel.text = "Pressione para começar!"
            check1 = true
        }
        if  DataService.artistService.count >= 30{
            if !check2 {
            delay = 6
            }
            StartButton.isUserInteractionEnabled = true
            StartButton.fadeTransition(0.8)
            StartButton.backgroundColor = color.quaternaryColor.withAlphaComponent(0.8)
            StartButton.layer.borderColor = color.whiteColor.cgColor
            check2 = true
        }
        if check1 && check2 {
            
            timer.invalidate()
        }
    }
    
    
    
    // MARK: - ANIMATION DEPENDECES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! GenreNatigationController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = StartButton.center
        transition.circleColor = color.quaternaryColor
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = StartButton.center
        transition.circleColor = color.quaternaryColor
        
        return transition
    }
    
    func createPulse() {
        for _ in 0...1 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/4, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 5.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: headphone.frame.size.width/2.0, y: headphone.frame.size.height/2.0)
            StartButton.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.animatePulse(index: 0)
        }
    }
    
    func animatePulse(index: Int) {
        pulseLayers[index].strokeColor = color.quaternaryColor.cgColor
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 1.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 1.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }

    
}
