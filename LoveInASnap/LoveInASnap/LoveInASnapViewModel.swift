//
//  LoveInASnapViewModel.swift
//  LoveInASnap
//
//  Created by Khoa Tran on 30/11/2021.
//

import UIKit
import SwiftUI
import TesseractOCR
import GPUImage

class LoveInASnapViewModel: ObservableObject {
    @Published private(set) var recognizedText = "Nothing here..."
    
    // MARK: - Intent(s)
    
    func recognizeImage(_ image: UIImage, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let tesseract = G8Tesseract(language: "eng+fra") {
                tesseract.engineMode = .tesseractCubeCombined
                tesseract.pageSegmentationMode = .auto
                let scaledImage = image.scaledImage(1000) ?? image
                let preprocessedImage = scaledImage.preprocessedImage() ?? scaledImage
                tesseract.image = preprocessedImage
                tesseract.recognize()
                
                DispatchQueue.main.async {
                    self.recognizedText = tesseract.recognizedText ?? String()
                    completion()
                }
            }
        }
    }
}

// MARK: - UIImage extension

extension UIImage {
    func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            scaledSize.height = size.height / size.width * scaledSize.width
        } else {
            scaledSize.width = size.width / size.height * scaledSize.height
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    func preprocessedImage() -> UIImage? {
        let stillImageFilter = GPUImageAdaptiveThresholdFilter()
        stillImageFilter.blurRadiusInPixels = 15.0
        let filteredImage = stillImageFilter.image(byFilteringImage: self)
        return filteredImage
    }
}
