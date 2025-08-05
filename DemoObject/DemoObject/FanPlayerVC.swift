//
//  FanPlayerVC.swift
//  DemoObject
//
//  Created by 凡向阳 on 2024/3/27.
//

import UIKit
import FanKitSwift
import AVFoundation

@available(iOS 13.0, *)
class FanPlayerVC: UIViewController {
    
    @IBOutlet weak var videoView: FanPlayerView!
    var player:FanPlayer?
    var imgView:UIImageView?
    var slider:UISlider?
    var image2:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testPayer()
    }
    func testPayer(){

        player = FanPlayer(playerView: videoView)
        player?.loopPlay = true
//        player?.playAudio = true //支持播放mp3
        player?.loadedCacheBlock =  { (progress) in
//            print("缓存播放进度\(progress)")
        }
        
//        player
        //200x100
        image2 = FanImage(allName: "2@2x.png")
        
        imgView = UIImageView(frame: CGRect(x: 20, y: 300, width: 200, height: 200))
        imgView?.backgroundColor = FanColor(black: 0.3)
        imgView?.contentMode = .scaleAspectFit
        self.view.addSubview(imgView!)
        slider = UISlider(frame: CGRect(x: 20, y: 520, width: 200, height: 40))
        self.view.addSubview(slider!)
        
        slider?.addTarget(self, action: #selector(changeValue(slider:)), for: .valueChanged)
        
        
        imgView?.image = image2?.fan_gaussianBlur(0)

    }
    @objc func changeValue(slider:UISlider){
        let p = CGFloat(slider.value)
//        print("进度：\(p)")
        player?.seek(progress: p)
        let image = UIImage.fan_image(snapshotView: videoView)
        imgView?.image = image
//        imgView?.image = image?.fan_gaussianBlur(10.0*p)
    }
    
    @IBAction func playUrl(_ sender: Any) {
        let url = "https://ksapp-1251538927.cos.ap-nanjing.myqcloud.com/loona_ios_check/iOS_controle.mp4"
        let url2 = "https://ksapp-1251538927.cos.ap-nanjing.myqcloud.com/loona_ios_check/iOS_connect.mp4"
        player?.play(urlPath: url)
    }
    
    @IBAction func playLocal(_ sender: Any) {
        let filePath = FanPath(fileAllName: "loona.mp4")
        player?.play(filePath: filePath)
    }
    
    @IBAction func stop(_ sender: Any) {
        if(player?.avPlayer?.timeControlStatus == .playing){
            player?.avPlayer?.pause()
        }else{
            player?.avPlayer?.play()
        }
        imgView?.image = self.player?.screenshot()
        return
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
