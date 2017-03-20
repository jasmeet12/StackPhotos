//
//  ViewController.swift
//  stackPhotos
//
//  Created by Jasmeet Kaur on 09/03/17.
//  Copyright © 2017 Jasmeet Kaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var addButton:UIButton!
    @IBOutlet weak var deleteButton:UIButton!
    var photosView:PhotoView = PhotoView()
    
    var photos:Array = [Dictionary<String ,Any>]()
    var photsDict:Dictionary =  Dictionary<String , Any>()
    var currentAngle:Int = 0
    var imagePicker = UIImagePickerController()
    
    var isVerticalDirection:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosView = PhotoView.init(frame: CGRect(x:(self.view.frame.size.width-300)/2,y:(self.view.frame.size.height-300)/2,width:300,height:300))
        self.view.addSubview(photosView)
        let images = [UIImage(named:"Photo0"),UIImage(named:"Photo1") ,UIImage(named:"Photo2") ,UIImage(named:"Photo3")  ,UIImage(named:"Photo4"),UIImage(named:"Photo5"),UIImage(named:"Photo6")]
        

        photosView.initWithPhotos(images: images as! [UIImage])
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addPhoto(sender:UIButton){
    
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    

    
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
    
    
    
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
                photosView.insertPhoto(image: image)

            //view.image = image.resizedImage(newSize: view.frame.size)
                

        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
             
                
                photosView.insertPhoto(image: image)

                    } else{
            print("Something went wrong")
        }
    
        self.dismiss(animated: true, completion: nil)
    }


}




