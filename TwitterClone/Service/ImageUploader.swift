//
//  ImageUploader.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 28.01.23.
//

import Firebase
import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void)
    {
        guard let imageData =  image.jpegData(compressionQuality: 0.5) else {return}
        
        let filename = NSUUID().uuidString // get a random string
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Failed to upload error .. \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else {return }
                completion(imageUrl)
            }
        }
    }
}

