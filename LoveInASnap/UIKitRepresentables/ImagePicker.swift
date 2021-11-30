//
//  ImagePicker.swift
//  LoveInASnap
//
//  Created by Khoa Tran on 30/11/2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    enum SourceType : Int {
        @available(iOS, introduced: 2, deprecated: 100000, message: "Will be removed in a future release, use PHPicker.")
        case photoLibrary = 0
        
        case camera = 1
        
        @available(iOS, introduced: 2, deprecated: 100000, message: "Will be removed in a future release, use PHPicker.")
        case savedPhotosAlbum = 2
    }
    
    // returns YES if source is available (i.e. camera present)
    static func isSourceTypeAvailable(_ sourceType: ImagePicker.SourceType) -> Bool {
        guard let sourceType = UIImagePickerController.SourceType(rawValue: sourceType.rawValue) else { return false }
        return UIImagePickerController.isSourceTypeAvailable(sourceType)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    var sourceType: ImagePicker.SourceType = .photoLibrary
    var mediaTypes = [String]()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = UIImagePickerController.SourceType(rawValue: self.sourceType.rawValue) ?? .photoLibrary
        if !mediaTypes.isEmpty {
            picker.mediaTypes =  mediaTypes
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

