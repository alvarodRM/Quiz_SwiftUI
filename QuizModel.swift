//
//  QuizModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 28/09/2020.
//

import Foundation


struct QuizItem: Codable {
    let id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    var favourite: Bool
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String?
        let profileName: String?
        let photo: Attachment?
    }
    
    struct Attachment: Codable {
        let filename: String?
        let mime: String?
        let url: URL?
    }
}


class QuizModel: ObservableObject {
       
    //private(set) static var shared = QuizModel()
    
    @Published var quizzes = [QuizItem]()
    
    /*private init() {
       load()
    }*/
    
   
    let session = URLSession.shared
    let urlBase = "https://core.dit.upm.es"
    let TOKEN = "579b10c364a32e7b351a"
    
    func load() {
        
        /*guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }*/
        
        let s = "\(urlBase)/api/quizzes/random10wa?token=\(TOKEN)"
        guard let url = URL(string: s) else{
            print("Fallo 1, creando URL")
            return
        }
        
        let t = session.dataTask(with: url){ (data , res, error) in
            if  error != nil {
                print("Fallo 2")
                return
            }
            if (res as! HTTPURLResponse).statusCode != 200{
                print("Fallo 3")
                return
            }
            let decoder = JSONDecoder()
            
            // let str = String(data: data, encoding: String.Encoding.utf8)
            // print("Quizzes ==>", str!)
            
            if let quizzes = try? decoder.decode([QuizItem].self, from: data!){
            
                // print("Quizzes cargados")
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                }
            }
            
        }
        
        t.resume()
            
            
    }
    
    func toggleFavourite(_ quizItem: QuizItem){
        guard let index = quizzes.firstIndex(where: {
            $0.id == quizItem.id
            
        }) else{
            print("Fallo 5")
            return
        }
        let surl = "\(urlBase)/api/users/tokenOwner/favourites/\(quizItem.id)?token=\(TOKEN)"
       
        guard let url = URL(string: surl) else {
            print("Fallo 6 creando url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        let t = session.uploadTask(with: request, from: Data()){
            (data, res, error) in
            if error != nil{
                print("Fallo 20")
                return
            }
            if (res as! HTTPURLResponse).statusCode != 200{
                print("Fallo 30")
                return
            }
            DispatchQueue.main.async{
                self.quizzes[index].favourite.toggle()
            }
        }
        t.resume()
    }
    
    func loadExamples(){
        
        quizzes = [
            QuizItem(id:1,
                     question:"una y una",
                     answer: "dos",
                     author: nil,
                     attachment: nil,
                     favourite: true
            ),
            QuizItem(id:1,
                     question:"dos por dos",
                     answer: "cuatro",
                     author: nil,
                     attachment: nil,
                     favourite: true
            ),
        ]
    }
}

