//
//  ViewController.swift
//  DemoObject
//
//  Created by 向阳凡 on 2023/11/21.
//

import UIKit
import FanKitSwift

class ViewController: UIViewController {
    
    var topImgView:UIImageView?
    var imgView2:UIImageView?
    var slider:UISlider?
    var image2:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let str = FanKitSwift().text
        let bc = FanColor(black: 0.2)
        let wc = FanColor(white: 0.3)
        let hexColor = FanColor(hex: "73ff9f")
        print("hex颜色:\(hexColor)")
        let path  = FanPath(fileAllName: "loona@2x.png")
        print("图片路径： \(path)")
        
        let imgView = UIImageView(frame: CGRect(x: 20, y: 50, width: 200, height: 200))
        imgView.image = FanImage(allName: "loona@2x.png")
//        imgView.image = FanImage(onlyName: "loona")
        imgView.backgroundColor = hexColor
        self.view.addSubview(imgView)
        topImgView = imgView
        if UIApplication.shared.delegate?.responds(to: Selector(("window"))) ?? false {
            print("swift responds :window")
        }
        
//        test()
//        testTool()
        testString()
        testImage()
        print("所有IP地址：\(FanTool.fan_allIPAddress())")
        print("本地IP地址：\(FanTool.fan_ipAddress(.wifiIpv4))")
    }
    func testImage(){
        let imgView = UIImageView(frame: CGRect(x: 20, y: 300, width: 200, height: 200))
        imgView.backgroundColor = FanColor(black: 0.3)
        imgView.contentMode = .scaleAspectFit
        self.view.addSubview(imgView)
        imgView2 = imgView
        slider = UISlider(frame: CGRect(x: 20, y: 520, width: 200, height: 40))
        self.view.addSubview(slider!)
        
        slider?.addTarget(self, action: #selector(changeValue(slider:)), for: .valueChanged)
        
        //200x100
        let image = FanImage(allName: "2@2x.png")
        image2 = image
//        let newImage = image?.fan_scaleAspectFit(maxSize: CGSize(width: 200, height: 200))
//        
//        imgView.image = newImage
        
//        let clipImage = image?.fan_clip(maxSize: CGSize(width: 200, height: 100), clipRect: CGRect(x: 50, y: 0, width: 100, height: 100),isOval: true,autoScale: false,scale: 2.0)
//        
//        imgView.image = clipImage
//        
//        imgView.image = UIImage.fan_image(color: .red, size: CGSize(width: 200, height: 200),cornerRadius: 20)
//        
//        imgView.image = UIImage.fan_image(snapshotView: topImgView)
        
//        imgView.image = UIImage.fan_image(snapshotLayer: topImgView!.layer, renderSize: topImgView!.bounds.size)
//        imgView.image = image?.fan_clip(clipRect: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        imgView.image = image?.fan_gaussianBlur(0)

    }
    @objc func changeValue(slider:UISlider){
        let p = CGFloat(slider.value)
        print("进度：\(p)")
        imgView2?.image = image2?.fan_gaussianBlur(10.0*p)
    }
    func testString(){
        print("随机字符串：\(String(randomLen: 10))")
        print("随机字符串：\(String(randomLen: 20))")
    }
    func test() {
        let dic = ["a":"b","data":["abc","xxx"]] as NSDictionary
        let a = dic.fan_bool("data")
        let arr:[Any] = dic.fan_array("data")
        var arr1 = dic.fan_nsarray("data")
        arr1 = ["aa"]        
    }
    
    public func testTool(){
        let json:[String : Any] = ["name":"fan","age":30]
        let jsonStr:String = "{\"name\":\"fan\",\"age\":30}"
        print("json字符串：\(FanTool.fan_dic(jsonStr))")
        let filePath = FanPath(fileAllName: "heartos.json")
        
        print("json字符串路径：\(FanTool.fan_dic(jsonPath: filePath))")
        
        let jsonArr:String = "[\"name\",\"fan\",\"age\",\"30\"]"
        print("json字符串数组：\(FanTool.fan_array(jsonArr))")
        
        
        print("路径：\(FanTool.fan_documentPath())")
        
        print("路径1：\(FanTool.fan_cachePath())")
        //    FanTool.fan_tmpPath = "23456"
        print("路径2：\(FanTool.fan_tmpPath())")
        
        let tmpPath = FanTool.fan_tmpPath().appending("/abc/a.json")
        let tmpPath2 = FanTool.fan_tmpPath().appending("/def/a.json")
        FanTool.fan_copy(atPath: FanPath(fileAllName: "heartos.json"), toPath: tmpPath)
        FanTool.fan_copy(atPath: FanPath(fileAllName: "heartos.json"), toPath: tmpPath2)
        print("json字符串路径：\(FanTool.fan_dic(jsonPath: tmpPath))")
        
        let copyPath = FanTool.fan_cachePath().appending("/fan")
        FanTool.fan_copy(from: FanTool.fan_tmpPath(), to: copyPath)
        
        FanTool.fan_move(frome: copyPath, to: FanTool.fan_cachePath().appending("/fan2"),removeOld: true)
        
        print("文件夹大小：\(FanTool.fan_folderSize(tmpPath))")
        print("文件夹大小2：\(FanTool.fan_folderSize(FanTool.fan_cachePath()))")

        //    FanTool.fan_delete(copyPath+"/a.json")
    //    FanTool.fan_delete(atPath: copyPath)
        
        let enumerator = FileManager.default.enumerator(atPath: FanTool.fan_cachePath())
        while let file = enumerator?.nextObject() {
            if let fileName = file as? String{
                print("文件遍历：\(fileName)")
            }
            
        }
        
        var str1 =  "沃尔玛"
        str1.append("fan")
        
        print("字符串追加：\(str1)")
        
        let tmpUrl = URL(string: tmpPath)
        let tmpUrl2 = NSURL(fileURLWithPath: tmpPath)
        print(tmpUrl?.absoluteString,tmpUrl?.fan_path)
        print(tmpUrl2.absoluteString,tmpUrl2.path)
        
    }
}

