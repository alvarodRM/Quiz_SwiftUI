//
//  ContentView.swift
//  P!Quiz
//
//  Created by u011 DIT UPM on 14/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var quizModel : QuizModel
    
    
    @EnvironmentObject var scoreModel : ScoreModel
    @State var showAll: Bool = true
    
    var body: some View {
        
        NavigationView{
            List {
                Toggle(isOn: $showAll){
                    Label("Ver todo", systemImage: "list.bullet")
                }
                ForEach(quizModel.quizzes.indices, id: \.self){ i in
                    if showAll || !scoreModel.acertado(quizModel.quizzes[i]){
                        VStack{
                            NavigationLink(destination: QuizDetail(quiz: $quizModel.quizzes[i])){
                                QuizRow(quiz: quizModel.quizzes[i])
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("P3 Quiz")
            
           
            
            VStack{
                Text("UPSSSSSSSSSSS")
                Image("none")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                
            }
        }
        .background(Color.gray)
    }
}


struct ContentView_Previews: PreviewProvider {
    static let quizModel: QuizModel = {
       let qm = QuizModel()
        qm.loadExamples()
        return qm
    }()
    
    static var previews: some View {
        
        ContentView()
            .environmentObject(quizModel)
    }
}
