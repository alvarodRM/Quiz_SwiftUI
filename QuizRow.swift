//
//  QuizRow.swift
//  P!Quiz
//
//  Created by u011 DIT UPM on 14/10/2020.
//

import SwiftUI

struct QuizRow: View {
    var quiz: QuizItem
    @EnvironmentObject var imageStore : ImageStore
    var body: some View {
        HStack{
            Image(uiImage : imageStore.image(url : quiz.attachment?.url))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            
            Text(quiz.question)
            
            
            Spacer()
            
            VStack{
                
                
                    //Spacer()
                    
                    Image(uiImage : imageStore.image(url : quiz.author?.photo?.url))
                        .resizable()
                        .frame(width: 25, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    //Spacer()
              
                Text(quiz.author?.username ?? "Desconocido")
                    .font(.footnote)
                    
                //Text(quiz.author?.username)
                
            }
        }
        
        
    }
    
    
}

struct QuizRow_Previews: PreviewProvider {
    
    static let quizModel: QuizModel = {
       let qm = QuizModel()
        qm.loadExamples()
        return qm
    }()
    static var previews: some View {
        QuizRow(quiz: quizModel.quizzes[0])
    }
}
