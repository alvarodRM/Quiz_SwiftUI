//
//  P_QuizApp.swift
//  P!Quiz
//
//  Created by u011 DIT UPM on 14/10/2020.
//

import SwiftUI

@main
struct P_QuizApp: App {
    
    let quizModel: QuizModel = {
        let qm = QuizModel()
        qm.load()
        return qm
        
    }()
    
    let imageStore = ImageStore()
    let scoreModel = ScoreModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(imageStore)
                .environmentObject(scoreModel)
                .environmentObject(quizModel)
        }
    }
}
