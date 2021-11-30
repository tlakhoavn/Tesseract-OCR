//
//  LoveInASnapViewModel.swift
//  LoveInASnap
//
//  Created by Khoa Tran on 30/11/2021.
//

import UIKit
import SwiftUI
import TesseractOCR
//import GPUImage

class LoveInASnapViewModel: ObservableObject {
    @Published private(set) var recognizedText = "Nothing here..."
    
    // MARK: - Intent(s)
    
    func recognizeImage(_ image: UIImage) {
        if let tesseract = G8Tesseract(language: "eng+fra") {
            tesseract.engineMode = .tesseractCubeCombined
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image
            tesseract.recognize()
            recognizedText = tesseract.recognizedText ?? String()
        }
    }
}
