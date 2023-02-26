//
//  ScoreModel.swift
//  P!Quiz
//
//  Created by u011 DIT UPM on 15/10/2020.
//

import Foundation


class ScoreModel : ObservableObject {
    
    
    //@Published var puntos : Int
    
    @Published var acertadas: Set<Int> = []
    
    init(){
        let us = UserDefaults.standard
        if let acertadas = us.object(forKey: "acertadas") as? Array<Int> {
            self.acertadas = Set(acertadas)
        }
        
        
        
    }
    
    func check(respuesta: String, quiz: QuizItem){
        
        let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if r1 == r2,
           !acertadas.contains(quiz.id) {
                acertadas.insert(quiz.id)
            
            let us = UserDefaults.standard
            us.set( Array<Int>(acertadas)   ,forKey: "acertadas")
        }
        print(acertadas)
    }
    func acertado(_ quiz: QuizItem) -> Bool {
        acertadas.contains(quiz.id)
    }
    func limpiar() {
        acertadas.removeAll()
        UserDefaults.standard
            .set(Array<Int>(acertadas), forKey: "acertadas")
    }
}
