//
//  DetailViewViewController.swift
//  First Demo
//
//  Created by Sarang Jiwane on 24/10/17.
//  Copyright © 2017 com.demo. All rights reserved.
//

import UIKit
import SDWebImage
class DetailViewViewController: UIViewController {
    @IBOutlet var backBtnView: UILabel!
    
    @IBOutlet var detailImage: UIImageView!
    var myArray = [[String: AnyObject]]()
    var tapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TAP Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        backBtnView.addGestureRecognizer(tapGesture)
        backBtnView.isUserInteractionEnabled = true
        
        detailImage.sd_setImage(with: URL(string: myArray[0]["cat_image"] as! String), placeholderImage: UIImage(named: "placeholder.png"))
        
       // detailImage.image = UIImage.init(named: myArray[0] as! [UIImage])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
}
