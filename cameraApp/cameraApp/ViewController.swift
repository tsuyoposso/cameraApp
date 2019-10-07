//
//  ViewController.swift
//  cameraApp
//
//  Created by 長坂豪士 on 2019/10/06.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
            case .authorized:
                print("許可されています。")
            case .denied:
                print("拒否された")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
                
            }
            
        }
    }

    @IBAction func openCamera(_ sender: Any) {
        
        let sourceType = UIImagePickerController.SourceType.camera
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // 変数化
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated:true, completion: nil)
            
        } else {
            print("エラー")
        }
    }
    

    // 撮影画面をキャンセルする方法
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // picker -> 出ている画面のこと
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 内容はカメラと同じで、引用先がcamera -> photoLibrary
    @IBAction func openAlbum(_ sender: Any) {
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // 変数化
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated:true, completion: nil)
            
        } else {
            print("エラー")
        }
        
        
    }
    
    // 撮影が完了したとき、もしくはアルバムから画像が選択されたときに呼ばれる箇所
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            backImageView.image = pickedImage
            
            // 写真の保存
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            // 表示画面の削除
            picker.dismiss(animated: true, completion: nil)
        }
    }
    

    // シェアするための機能
    @IBAction func share(_ sender: Any) {
        
        let text = "#tamariba"
        let image = backImageView.image?.jpegData(compressionQuality: 0.2)
        let items = [text, image] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        // これなにかわからん
        present(activityVC, animated: true, completion: nil)
    }
    
    
}

