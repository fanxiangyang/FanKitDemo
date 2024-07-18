//
//  FanManager.swift
//
//
//  Created by 凡向阳 on 2024/5/16.
//

import Foundation
import SwiftUI


//@State 用于管理简单的局部视图状态。
//@ObservedObject 用于跨视图共享和观察响应式数据模型，但不保证对象的生命周期与视图同步。
//@StateObject 同样用于观察响应式数据模型，但提供了一种方式来确保对象在整个视图树中的唯一性，并且会随视图重建而保留状态，同时在适当的时候自动释放资源。


//MARK: - 全局弹窗设计
public struct FanSheetItem : Identifiable ,RawRepresentable {
    public var rawValue: String
    
    public init(rawValue: String){
        self.rawValue = rawValue
    }
    //Identifiable协议必须实现的
    public var id: UUID {
        return UUID()
    }
    /// 关于
    public static let about:FanSheetItem = .init(rawValue: "about")
    
   
}
@available(iOS 13.0, *)
///全局管理-SwiftUI共享数据
public class FanManager : ObservableObject {
    
    ///单利类全局弹窗
    public static let shared = FanManager()
    
    ///初始化
    public init() {
        
    }
    ///弹窗名称字符串，自己处理显示UI
    @Published public var sheetItem : FanSheetItem?
    
    @Published public var isPresent : Bool = false
    
}

//用法示例
//@available(iOS 13.0, *)
//public extension FanManager {
//    ///获取显示的弹窗View，需要自己去实现
//    func showPopView() -> some View {
//        switch name {
//        default:
//            return EmptyView()
//        }
//    }
//}
