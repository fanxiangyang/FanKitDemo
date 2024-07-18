//
//  ContentView.swift
//  Demo
//
//  Created by 向阳凡 on 2023/11/21.
//

import SwiftUI
import FanKitSwift


struct ContentView: View {
    
    @State var number:Int = 0
    
    @State var isPresent : Bool = false
    
    @StateObject var fanManager:FanManager = FanManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!").border(Color.red)
            Button {
                isPresent = true
            } label: {
                Text("我是一个按钮").font(Font.system(size: 20))
            }
            .frame(height: 32)
            .modifier(FanImageBgModifier(imageName: "hm_yellow_bg_32",padding: .init(top: 0, leading: 20, bottom: 0, trailing: 20)))
            
            Button {
                fanManager.sheetItem = .init(rawValue: "about")
            } label: {
                Text("这个是另外一个button")
            }
            .background(Color.gray)
            .font(.bold(Font.title)())
            .fan_textColor(.yellow)
//            .tint(.primary)
        }
        .border(Color.black)
        //        .padding()
        .onAppear(){
            self.number = 1
            //            let c = FanKitSwift().text
            //            print(c)
            print("随机字符串：\(String(randomLen: 10))")
            
        }
        .onChange(of: number, perform: { value in
            print(" newValue=\(value)")
        })
        //            .task {
        //                print("数字值：\(await number)")
        //            }
        .sheet(item: $fanManager.sheetItem) { item in
//            if item == .about {
//                print("about界面")
//            }
            FanAlphaView()
        }
//        .alert(isPresented: $isPresent) {
//            Alert(title:Text("这个是alert界面"))
//        }
//        .alert(Text("这个是alert界面"), isPresented: $isPresent) {
//            Text("这个是alert确定按钮")
//        }
        
        
        
    }
}
struct FanAlphaView : View {
    var body: some View{
        
        if #available(iOS 15.0, *) {
            Text("我们是sheet界面")
                .background {
                    Color.red
                }
        } else {
            // Fallback on earlier versions
            EmptyView()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
