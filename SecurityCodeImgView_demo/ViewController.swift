//
//  ViewController.swift
//  SecurityCodeImgView_demo
//
//  Created by fashion on 2018/3/22.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var codeview : SecurityCodeImgView!

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        codeview = SecurityCodeImgView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40))
//        codeview.block = { code in
//            print(code)
//        }
//        codeview.isRotation = true
//        codeview.refreshSecurityCode()
        view.addSubview(codeview)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(codeview.imageCodeStr)
    }


}

