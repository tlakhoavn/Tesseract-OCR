//
//  LoveInASnapView.swift
//  LoveInASnap
//
//  Created by Khoa Tran on 28/11/2021.
//

import SwiftUI

struct LoveInASnapView: View {
    @ObservedObject var viewModel: LoveInASnapViewModel
    
    @State private var showLoading = false
    
    @State private var showChooseImageSheet = false
    
    @State private var showingImagePicker = false
    @State private var showingImagePickerSourceType = ImagePicker.SourceType.photoLibrary
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack() {
            Color(rgb: 0x9A223C)
                .ignoresSafeArea()
            VStack() {
                Text("Snap/upload a clear picture of your poem then edit below. Tap outside of the text box once your sweet nothings are complete.")
                    .font(AppConstants.font1(withSize: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                ZStack(alignment: .leading) {
                    Color.white
                    ScrollView {
                        Text(showLoading ? "" : viewModel.recognizedText)
                            .font(AppConstants.font2(withSize: 16))
                            .frame(maxWidth: .infinity)
                            //                        .textSelection(.enabled)
                            .padding()
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 300, maxHeight: 400, alignment: .topLeading)
                
                Button("Snap/Upload Image") {
                    showChooseImageSheet = true
                }
                .actionSheet(isPresented: $showChooseImageSheet) { actionSheetBody }
                .font(AppConstants.font1(withSize: 22))
                .foregroundColor(Color(rgb: 0x94BEFF))
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .disabled(showLoading)
                Spacer()
            }
            .padding(.horizontal, 25)
        }
        .background(Color.red)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear() {
            // do nothing here
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: showingImagePickerSourceType)
        }
        .activityIndicatorify(showLoading: $showLoading)
    }
    
    var actionSheetBody: ActionSheet {
        var buttons = [ActionSheet.Button]()
        
        
        if ImagePicker.isSourceTypeAvailable(.camera) {
            let cameraButton = ActionSheet.Button.default(Text("Take Photo")) {
                showingImagePickerSourceType = .camera
                showChooseImageSheet = false
                showLoading = true
                showingImagePicker = true
            }
            buttons.append(cameraButton)
        }
        
        let libraryButton = ActionSheet.Button.default(Text("Choose Existing")) {
            showingImagePickerSourceType = .photoLibrary
            showChooseImageSheet = false
            showLoading = true
            showingImagePicker = true
        }
        buttons.append(libraryButton)
        
        let cancelButton = ActionSheet.Button.cancel(Text("Cancel")) {
            showChooseImageSheet = false
        }
        buttons.append(cancelButton)
        
        return ActionSheet(title: Text("Snap/Upload Image"), message: nil, buttons: buttons)
    }
    
    func loadImage() {
        guard let image = inputImage else {
            showLoading = false
            return
        }
        viewModel.recognizeImage(image) {
            showLoading = false
        }
    }
    
    struct AppConstants {
        static func font1(withSize size: CGFloat) -> Font {
            Font.custom("Bradley Hand Bold", size: size)
        }
        static func font2(withSize size: CGFloat) -> Font {
            Font.custom("Noteworthy", size: size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoveInASnapView(viewModel: LoveInASnapViewModel())
    }
}

extension Color {
    init(rgb: Int, opacity: Double = 1) {
        self.init(
            red: Double((rgb >> 16) & 0xFF)/255,
            green: Double((rgb >> 8) & 0xFF)/255,
            blue: Double(rgb & 0xFF)/255,
            opacity: opacity
        )
    }
}
