//
//  FanUITestVC.swift
//  DemoObject
//
//  Created by 凡向阳 on 2024/4/12.
//

import UIKit
import FanKitSwift
import SnapKit

class FanUITestVC: UIViewController {

    var aBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        test1()
    }
    func test1(){

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemOrange
        let label = UILabel(frame: CGRectMake(20, 80, 200, 50))
        label.backgroundColor = FanColor(white: 0.2)
        label.numberOfLines = 2
        self.view.addSubview(label)
        label.text = "这个是swift界面"
        let f = FanFont(bold: 14);
        
        print("屏幕宽：\(FanWidth)")
        print("屏幕高：\(FanUIKitTool.fan_height)")
        let date = Date()
        let dateStr = date.fan_string(format: "yyyy-MM-dd HH:mm:ss")
        
        let date2 = Date.fan_date(from: "2016-09-09 15:47:11", format: "Y-M-dd HH:mm:ss")
        print("日期：\(String(describing: date2))")
        var aStr = NSMutableAttributedString(string: "这个是swift界面-改变颜色")
        aStr.fan_add(font: f,textColor: FanColor(hex: "ffueif", 1))
        aStr.fan_add(underline: .double)
        aStr.fan_add(paragraphStyle: NSMutableParagraphStyle(alignment: .right))
        aStr.fan_append(string: "追加"+dateStr, font: FanFont(10), textColor: UIColor.red)
        label.attributedText = aStr
        
        label.fan_addClip(8)
        label.fan_addBorder(color: UIColor.purple,width: 2)
        label.fan_hugging(.defaultHigh)
        
        let stackView = UIStackView.fan_stackView(spacing: 0,axis: .horizontal)
        stackView.alignment = .center
        
        let btn1 = UIButton.fan_btn(title: "这是Button Layer动画+画图", textColor: UIColor.red, font: FanFont(bold: 14), edge: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        btn1.backgroundColor = .white
        self.view.addSubview(btn1)
        btn1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.leading.equalToSuperview().inset(20)
        }
        btn1.fan_add(textColor: .darkGray, font: FanFont(medium: 20))
        
        btn1.setImage(UIImage(named: "hm_ok_24"), for: .normal)
        btn1.fan_add(imagePadding: 20)
        
        let btn2 = UIButton.fan_btn(imageName: "hm_ok_24",edge: .init(top: 20, left: 30, bottom: 20, right: 30))
        btn2.backgroundColor = .white
        btn2.setTitle("按钮跳转Nav", for: .normal)
        btn2.fan_add(textColor: .green, font: FanFont(semibold: 20))
        self.view.addSubview(btn2)
        btn2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160+60)
            make.leading.equalToSuperview().inset(20)
        }
        btn2.fan_add(imagePadding: 20,postion: .right)
        if #available(iOS 14.0, *) {
            btn2.addAction(UIAction(handler: {[weak self] act in
                self?.jumpNavAnimationVC()
            }), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
            btn2.addTarget(self, action: #selector(jumpNavAnimationVC), for: .touchUpInside)
        }
        btn1.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)

        aBtn = btn1
    }
    @objc func jumpNavAnimationVC(){
        let vc = UIViewController()
        vc.view.backgroundColor = .brown
        vc.title = "动画效果"
        self.navigationController?.pushViewController(vc, animated: false)
        self.navigationController?.view.layer.add(FanLayerTool.fan_transitionAnimation(type: .init(rawValue: "oglFlip"), subType: .fromRight,duration: 0.8), forKey: "nav")
    }
    @objc func startAnimation(){
        //透明闪烁
//        aBtn?.layer.add(FanLayerTool.fan_animation(key: .opacity, from: 1.0, to: 0.0,duration: 0.8, repeatCount: .greatestFiniteMagnitude,autoreverses: true), forKey: "opacity")
        //移动
//        aBtn?.layer.add(FanLayerTool.fan_animation(type: .moveX, from: 20, to: 200,repeatCount: .greatestFiniteMagnitude,autoreverses: true), forKey: "move")
        //点移动
//        aBtn?.layer.add(FanLayerTool.fan_animation(type: .movePoint, from: CGPoint(x: 20, y: 100), to: CGPoint(x: 300, y: 500),repeatCount: .greatestFiniteMagnitude,autoreverses: true), forKey: "movePoint")
        //缩放
//        aBtn?.layer.add(FanLayerTool.fan_animation(type: .scale, from: 1.0, to: 0.3,repeatCount: .greatestFiniteMagnitude,autoreverses: true), forKey: "scale")
//        aBtn?.layer.add(FanLayerTool.fan_animation(type: .scale, from: 1.0, to: 0.3,repeatCount: .greatestFiniteMagnitude,autoreverses: true), forKey: "scale")
        //3d  首尾相接
//        aBtn?.layer.add(FanLayerTool.fan_animation(type: .transform3D, from:CATransform3DMakeRotation((.pi), 0, 0, 1), to: CATransform3DMakeRotation(0, 0, 0, 1),repeatCount: .greatestFiniteMagnitude,autoreverses: false,cumulative: false), forKey: "3d")
        
        //画虚线
        let lineLayer = FanLayerTool.fan_layer(lineWidth: 2, lineColor: UIColor.red, start: CGPoint(x: 20, y: 300), end: CGPoint(x: 200, y: 300),dashedWidth: 4, dashedSpace: 6)
        self.view.layer.addSublayer(lineLayer)
        //画椭圆
        let ovalLayer = FanLayerTool.fan_layer(frame:CGRectZero, path:UIBezierPath(ovalIn: CGRect(x: 20, y: 310, width: 200, height: 200)), lineWidth: 6, lineColor: UIColor.gray)
        self.view.layer.addSublayer(ovalLayer)
        
        ///画矩形
        let roundLayer = FanLayerTool.fan_layer(frame: CGRect(x: 30, y: 320, width: 180, height: 180),path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 180, height: 180), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8, height: 8)), fillColor: UIColor.red.withAlphaComponent(0.5))
        self.view.layer.addSublayer(roundLayer)
        //画圆环
        let ringLayer = FanLayerTool.fan_layer(frame: CGRect(x: 30, y: 320, width: 180, height: 180), center: CGPoint(x: 90, y: 90), radius: 70, startAngle: -.pi*0.5, ringWidth: 6, ringColor: UIColor.green,clockwise: false)
        ringLayer.strokeStart = 0
        ringLayer.strokeEnd = 0.7
        self.view.layer.addSublayer(ringLayer)
        //渐变layer
        let gradientLayer = FanLayerTool.fan_layer(frame: CGRect(x: 30+200, y: 320, width: 180, height: 180), colors: [UIColor.purple,UIColor.green,UIColor.orange],  locations: [0,0.5,1.0], endPoint: CGPoint(x: 0, y: 1),cornerRadius: 20)
        self.view.layer.addSublayer(gradientLayer)
        
        let cutoutLayer = FanLayerTool.fan_layer(bounds: gradientLayer.bounds, cutoutFrame: CGRectMake(20, 20, 60, 60))
        gradientLayer.mask = cutoutLayer

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
