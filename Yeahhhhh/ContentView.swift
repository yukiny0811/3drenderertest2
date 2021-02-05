//
//  ContentView.swift
//  Yeahhhhh
//
//  Created by クワシマ・ユウキ on 2021/02/03.
//

import SwiftUI
import MetalKit

struct ContentView: View {
    var body: some View {
        VStack {
            DisplayMetalView()
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
                
//                .padding()
//                .frame(width: UIScreen.main.bounds.height + 50, height: UIScreen.main.bounds.height + 50, alignment: .center)
            
//            DisplayMetalView()
//                .padding()
            
//            Text("khkjh")
        }
        .background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
