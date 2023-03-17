	//
//  ViewController.swift
//  instagrid-final
//
//  Created by Attemani Nassim on 27/02/2023.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var bottomRight: UIButton!
    @IBOutlet var topRight: UIButton!
    @IBOutlet var topLeft: UIButton!
    @IBOutlet var bottomLeft: UIButton!
    @IBOutlet var imageToShare: UIStackView!
    var buttonTapped = UIButton()
    
    @IBOutlet var displayOptions: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragImageView(_:)))
        imageToShare.addGestureRecognizer(panGestureRecognizer)
        
        
    }
    
    @IBAction func displayOne(_ sender: UIButton) {
        topRight.isHidden = false
        topLeft.isHidden = true
        bottomRight.isHidden = false
        bottomLeft.isHidden = false
        resetDisplayOptionsBtn()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
    }
    @IBAction func displayThree(_ sender: UIButton) {
        topRight.isHidden = false
        topLeft.isHidden = false
        bottomRight.isHidden = false
        bottomLeft.isHidden = true
        resetDisplayOptionsBtn()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
    }
    
    @IBAction func displayTwo(_ sender: UIButton) {
        topRight.isHidden = false
        topLeft.isHidden = false
        bottomRight.isHidden = false
        bottomLeft.isHidden = false
        resetDisplayOptionsBtn()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
    }
    func resetDisplayOptionsBtn() {
        for button in displayOptions {
               button.setImage(nil, for: .normal)
          }
    }
    @objc func dragImageView(_ sender:UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformImageToShareView(gesture: sender)
        case .cancelled, .ended:
            shareImg(gesture: sender)
        default:
            break
        }
    }
    func transformImageToShareView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: imageToShare)
        
        imageToShare.transform = CGAffineTransform(translationX: 0, y: translation.y)
    }
    func shareImg(gesture: UIPanGestureRecognizer) {
        if (gesture.translation(in: imageToShare).y < 0) {
            let renderer = UIGraphicsImageRenderer(size: imageToShare.bounds.size)
            let image = renderer.image { ctx in
                imageToShare.drawHierarchy(in: imageToShare.bounds, afterScreenUpdates: true)
            }
            
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        } else {
            print("not shared")
        }
        
    }
    
    @IBAction func addImgButton(_ sender: UIButton) {
        buttonTapped = sender
        openGallery()
    }
    
    func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]
        buttonTapped.setBackgroundImage(image as? UIImage, for: .normal)
        buttonTapped.setImage(nil, for: .normal)
        
//        buttonTapped.imageView?.contentMode = .scaleAspectFit
        
        picker.dismiss(animated: true, completion: nil)
    }
}

