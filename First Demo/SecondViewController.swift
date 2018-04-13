//
//  SecondViewController.swift
//  First Demo
//
//  Created by Sarang Jiwane on 24/10/17.
//  Copyright © 2017 com.demo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import GoogleSignIn
import Google
class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myTable: UITableView!
    @IBOutlet var backBtnView: UIView!
     var json : [Any]?
    var images : [String] = []
    var allData : [[String: Any]]?
    var petitions = [[String: AnyObject]]()
    var tapGesture = UITapGestureRecognizer()
    let devCousesImages = [UIImage(named: "call_blue"), UIImage(named: "handicap_filled"), UIImage(named: "pet_filled"), UIImage(named: "pet_filled"), UIImage(named: "pet_filled")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // TAP Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        backBtnView.addGestureRecognizer(tapGesture)
        backBtnView.isUserInteractionEnabled = true
        self.hitApi()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count

    }
    func hitApi()  {
       // print(UserDefaults.standard.object(forKey: "deviceToken") as Any)
//        let params : Parameters = ["device_type": "ios",
//                                      "gcm_id": UserDefaults.standard.object(forKey: "deviceToken") as! String,
//                                      "mobile": 8446578334,
//                                      "password": "admin"]
        
        
        let para: Parameters = ["mode": "list_of_cities"]
        print(para as Any)
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request("http://luckystrikeapp.com/api/", method : .post , parameters : para, encoding: URLEncoding.default,  headers: headers).responseJSON { response in
            switch response.result{
            case .success(_:):
                let json = JSON(response.result.value!)
                print(json)
                self.allData = json["data"].arrayObject as? [[String:Any]]
                print(self.allData as Any)
                for item in json["data"].arrayValue {

//                    print(item["cat_image"].string!)
//                    self.images.append(item["cat_image"].string!)
                    self.petitions.append(item.dictionaryObject! as [String : AnyObject])
                }
                print(self.petitions)
                self.petitions.remove(at: 7)
                self.petitions.remove(at: 6)
                self.petitions.remove(at: 5)
                print(self.petitions.count)
                self.myTable.reloadData()
                break
            case .failure(_:):
                print(response.error as Any)
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.myImageView.sd_setImage(with: URL(string: petitions[indexPath.row]["cat_image"] as! String), placeholderImage: UIImage(named: "placeholder.png"))
        cell.myLabel.text = petitions[indexPath.row]["name"] as? String
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewViewController") as! DetailViewViewController
        viewController.myArray = [petitions[indexPath.row]]
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(viewController, animated: false, completion: nil)
        

        
        

    }

    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
        GIDSignIn.sharedInstance().signOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
