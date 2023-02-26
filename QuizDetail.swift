//
//  QuizDetail.swift
//  P!Quiz
//
//  Created by u011 DIT UPM on 14/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    
    @EnvironmentObject var scoreModel : ScoreModel
    @State var respuesta: String = ""
    
    @EnvironmentObject var quizModel: QuizModel
    
    //@State var puntos : Int = 0
    
    @State var muestraAlerta: Bool = false
    
    @Binding var quiz: QuizItem
    @EnvironmentObject var imageStore: ImageStore

    //var res: Respuesta = Respuesta(quiz: <#T##QuizItem#>)
    @State var x : String = " "
    //let ideaImage = UIImage(named: "idea")!
    
    var body: some View {
        VStack{
            HStack{
                Text(quiz.question)
                    .font(.largeTitle)
                
                Button(action: {
                    self.quizModel.toggleFavourite(quiz)
                }){
                    Image(quiz.favourite ? "favLleno": "favVacio")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .scaledToFit()
                }
            }
            Text("Puntos = \(scoreModel.acertadas.count)")
                .font(.headline)
            
            TextField("Teclee su respuesta",
                      text: $respuesta,
                      onEditingChanged: {b in},
                      onCommit: {
                        scoreModel.check(respuesta: respuesta, quiz: quiz)
                        muestraAlerta = true
                      })
                .alert(isPresented: $muestraAlerta){
                    let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    return Alert(title: Text("Resultado"),
                          message: Text(r1 == r2 ? "Correcto" : "Falso"),
                        
                          dismissButton: .default(Text("OK")))
                    
                }
            
            Image(uiImage: imageStore.image(url: quiz.attachment?.url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20 )
                .animation(.easeInOut)
            
            //Mejora 2
            VStack{
            HStack{
                //Spacer()
                
                Text("La respuesta correcta es:")
                
               // var x : String = "Hola"
                Button(action: {
                
                   x = quiz.answer
                
                }){
                    /*Text("fer")
                        .font(.title)*/
                    Image("idea")
                        .resizable()
                        .frame(width:35, height: 35)
                }
                //Text("\(x)")
                    
                    
            }
                
                Text("\(x)")
                    .foregroundColor(.red)
                    .fontWeight(.black)
                    .font(.title2)
                    
            }
            
        }
        .padding()
    }
    
}

struct QuizDetail_Previews: PreviewProvider {
    static let quizModel: QuizModel = {
    let qm = QuizModel()
     qm.loadExamples()
     return qm
 }()
    
    static var previews: some View {
        EmptyView()
        //QuizDetail(quiz: quizModel.quizzes[0])
    }
}

/*struct Respuesta: View{
    var quiz: QuizItem
    
    var body: some View{
        Text("\(quiz.answer)")
    }
}*/

