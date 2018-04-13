//
//  singlton.swift
//  First Demo
//
//  Created by Sarang Jiwane on 25/10/17.
//  Copyright © 2017 com.demo. All rights reserved.
//

import UIKit

final class singlton: NSObject {
    
    var named : String?
    
    static let sharedInstance: singlton = {
        let instance = singlton()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    func sum(a:Int,b:Int) -> Int {
        return a + b 
    }
}
