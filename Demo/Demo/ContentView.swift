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
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(){
            self.number = 1
//            let c = FanKitSwift().text
//            print(c)
            print("随机字符串：\(String(randomLen: 10))")
            
        }
        .onChange(of: number, perform: { value in
            print(" newValue=\(value)")
        })
        .task {
            print("数字值：\(number)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
