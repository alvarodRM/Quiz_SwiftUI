//
//  ImageStore.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 28/09/2020.
//

import UIKit

class ImageStore: ObservableObject {
    
    // Cache para las imagenes.
    // La clave es un String con la url.
    @Published var imagesCache = [URL:UIImage]()
    
    let defaultImage = UIImage(named: "none")!
    let errorImage = UIImage(named: "error")!
    let downloadImage = UIImage(named: "download")!
    let ideaImage = UIImage(named: "idea")!
    
    // Si la imagen pedida esta en la cache, entonces la devuelve.
    // Si la imagen no esta en la cache entonces la descarga, y
    // actualizara la cache cuando la reciba.
    func image(url: URL?) -> UIImage {
        
        guard let url = url else {
            return defaultImage
        }
        
        if let img = imagesCache[url] {
            return img
        }
        
        //self.imagesCache[url] = defaultImage
        self.imagesCache[url] = downloadImage
        
        DispatchQueue.global().async { [self] in
            if let data = try? Data(contentsOf: url),
               let img = UIImage(data: data) {
                
                print(url)
                
                DispatchQueue.main.async {
                    self.imagesCache[url] = img
                }
            }else {
                imagesCache[url] = self.errorImage
            }
        }
        // defaultImage
        return downloadImage
        //return errorImage
    }
}

