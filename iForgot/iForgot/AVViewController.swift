//
//  AVViewController.swift
//  iForgot
//
//  Created by Jeremy on 4/13/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit

let SCREENWIDTH = UIScreen.main.bounds.width
let SCREENHEIGHT = UIScreen.main.bounds.height
class AVViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var layer1: CAShapeLayer?
    var layer2: CAShapeLayer?
    var layer3: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layer1 = CAShapeLayer()
        var path = UIBezierPath(roundedRect: CGRect(x: 50, y: 100, width: 100, height: 40), cornerRadius: 10)
        layer1?.path = path.cgPath
        layer1?.fillColor = UIColor.clear.cgColor
        layer1?.strokeColor = UIColor.black.cgColor
        self.view.layer.addSublayer(layer1!)
        
        layer2 = CAShapeLayer()
        path = UIBezierPath.init(ovalIn: CGRect(x: 200, y: 100, width: 40, height: 40))
        layer2?.path = path.cgPath
        layer2?.fillColor = UIColor.clear.cgColor
        layer2?.strokeColor = UIColor.black.cgColor
        self.view.layer.addSublayer(layer2!)
        
        layer3 = CAShapeLayer()
        path = UIBezierPath.init(ovalIn: CGRect(x: 280, y: 100, width: 40, height: 40))
        layer3?.path = path.cgPath
        layer3?.fillColor = UIColor.clear.cgColor
        layer3?.strokeColor = UIColor.black.cgColor
        self.view.layer.addSublayer(layer3!)
        
        animation()
        scrollView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    private func animation() {
        var animation = CABasicAnimation.init(keyPath: "position")
        animation.fromValue = layer1?.value(forKey: "position")
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: SCREENWIDTH / 2 - 100, y: 0))
        animation.duration = 1
        layer1?.add(animation, forKey: "position")
        
//        var animation = CABasicAnimation.init(keyPath: "bounds")
//        animation.fromValue = layer1?.value(forKey: "bounds")
//        animation.toValue = NSValue.init(cgRect: <#T##CGRect#>)//NSValue.init(cgPoint: CGPoint.init(x: SCREENWIDTH / 2 - 100, y: 0))
//        animation.duration = 1
//        layer1?.add(animation, forKey: "position")
        
        animation.fromValue = layer2?.value(forKey: "position")
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: SCREENWIDTH / 2 - 220, y: 0))
        animation.duration = 1
        layer2?.add(animation, forKey: "position")
        
        animation.fromValue = layer2?.value(forKey: "position")
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: SCREENWIDTH / 2 - 300, y: 0))
        animation.duration = 1
        layer3?.add(animation, forKey: "position")
        
        let delayTime = DispatchTime.now() + 0.9
        DispatchQueue.main.asyncAfter(deadline: delayTime) { 
            var path = UIBezierPath(roundedRect: CGRect(x: SCREENWIDTH / 2 - 50, y: 100, width: 100, height: 40), cornerRadius: 10)
            self.layer1?.path = path.cgPath
            path = UIBezierPath.init(ovalIn: CGRect(x: SCREENWIDTH / 2 - 20, y: 100, width: 40, height: 40))
            self.layer2?.path = path.cgPath
            path = UIBezierPath.init(ovalIn: CGRect(x: SCREENWIDTH / 2 - 20, y: 100, width: 40, height: 40))
            self.layer3?.path = path.cgPath
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
