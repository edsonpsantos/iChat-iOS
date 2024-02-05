//
//  ImagePickerView.swift
//  iChat
//
//  Created by EDSON SANTOS on 01/02/2024.
//

import Foundation
import SwiftUI


struct ImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
      
      let imagePicker = UIImagePickerController()
      imagePicker.allowsEditing = false
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = context.coordinator
      
      return imagePicker
    }
    
    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
      
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      
      var parent: ImagePickerView
      
      init(_ parent: ImagePickerView) {
        self.parent = parent
      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
          parent.selectedImage = image
        }
        
        parent.presentationMode.wrappedValue.dismiss()
      }
    }
}
