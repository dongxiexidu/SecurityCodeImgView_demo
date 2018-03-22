//
//  SecurityCodeImgView.swift
//  SecurityCodeImgView_demo
//
//  Created by fashion on 2018/3/22.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

class SecurityCodeImgView: UIView {
    /// 生成图片的验证码值
    public var imageCodeStr : String = ""
    /// 验证码字符是否可以斜着 (可以:YES)
    public var isRotation : Bool = true
    /// 是否有背景色
    public var labelColor : UIColor?
    
    private let ARC4RAND_MAX : CGFloat = 0x100000000
    ///字符数量
    public let codeCount : Int = 4
    ///干扰线数量
    public let lineCount : Int = 7
    
    /// 背景图
    private var bgView : UIView?
    
    private let textArr = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    /// 点击验证图，重新获取验证码的方法
    public func refreshSecurityCode() {
        changeCodeStr()
        initImageCodeView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        refreshSecurityCode()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshSecurityCode()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshSecurityCode()
    }
    
    /// 随机获取字符码
    private func changeCodeStr() {
        for i in 0..<codeCount {
            
            let index = Int(arc4random()) % (textArr.count-1)
            let oneText = textArr[index]
            if i == 0 {
                imageCodeStr = oneText
            }else{
                imageCodeStr = imageCodeStr + oneText
            }
        }
    }
    /// 初始化背景
    private func initImageCodeView() {
        if bgView != nil {
            bgView?.removeFromSuperview()
        }
        bgView = UIView.init(frame: self.bounds)
        self.addSubview(bgView!)
        bgView?.backgroundColor = getRandomBgColor()
        
        
        let textSize = ("W" as NSString).size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20)])
        let randWidth : Int = Int(frame.size.width)/Int(imageCodeStr.count) - Int(textSize.width)
        let randHeight : Int = Int(frame.size.height)/Int(imageCodeStr.count) - Int(textSize.height)
        
        for i in 0..<imageCodeStr.count {
            
            let px : CGFloat = CGFloat(Int(arc4random())%randWidth) + CGFloat(i)*(frame.size.width-3)/CGFloat(imageCodeStr.count)
            let py : CGFloat = CGFloat(Int(arc4random())%randHeight)
            
            let label = UILabel.init(frame: CGRect.init(x: px+3, y: py, width: textSize.width, height: textSize.height))
            label.text = String.init(format: "%C", (imageCodeStr as NSString).character(at: i))
            label.font = UIFont.systemFont(ofSize: 20)
            if labelColor != nil {
                label.textColor = labelColor
            }else{
                label.textColor = UIColor.black
            }
            
            if isRotation == true {
                var r : CGFloat = CGFloat(arc4random()) / ARC4RAND_MAX * 2 - 1
                if r > 0.3 {
                    r = 0.3
                }else if r < -0.3 {
                    r = -0.3
                }
                label.transform = CGAffineTransform.init(rotationAngle: r)
            }
            
            bgView?.addSubview(label)
        }
        // 添加干扰线于背景
        for _ in 0..<lineCount {
            let path = UIBezierPath.init()
            
            let pathX : CGFloat = CGFloat(arc4random() % UInt32(frame.size.width))
            let pathY : CGFloat = CGFloat(arc4random() % UInt32(frame.size.height))
            path.move(to: CGPoint.init(x: pathX, y: pathY))
            
            let pathEndX : CGFloat = CGFloat(arc4random() % UInt32(frame.size.width))
            let pathEndY : CGFloat = CGFloat(arc4random() % UInt32(frame.size.height))
            path.addLine(to: CGPoint.init(x: pathEndX, y: pathEndY))
            
            let layers = CAShapeLayer.init()
            layers.strokeColor = getRandomBgColor(alpha: 0.2).cgColor
            layers.lineWidth = 1.0
            layers.fillColor = UIColor.clear.cgColor
            layers.path = path.cgPath
            bgView?.layer.addSublayer(layers)
            
        }
    }
    
    /// 背景随机色
    private func getRandomBgColor(alpha : CGFloat = 0.5) -> UIColor {

        let red : CGFloat = CGFloat(arc4random_uniform(256)) / 255
        let green : CGFloat = CGFloat(arc4random_uniform(256)) / 255
        let blue : CGFloat = CGFloat(arc4random_uniform(256)) / 255
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
