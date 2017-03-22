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
    var imagePicker = UIImagePickerController()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configPhotoView()
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configPhotoView(){
    
        //Init PhotoView With Frame using PhotoView.init
        
        photosView = PhotoView.init(frame: CGRect(x:(self.view.frame.size.width-300)/2,y:(self.view.frame.size.height-300)/2,width:300,height:300))
        
        //Add PhotoView to the view controller view using addSubview
        self.view.addSubview(photosView)
        
        //Create Array of Images
        let images = [UIImage(named:"Photo0"),UIImage(named:"Photo1") ,UIImage(named:"Photo2") ,UIImage(named:"Photo3")  ,UIImage(named:"Photo4"),UIImage(named:"Photo5"),UIImage(named:"Photo6")]
        
        // use initWithPhotos if you want to initialize with array of images.
        photosView.initWithPhotos(images: images as! [UIImage])

        
        // <.....Optional Properties to set .....>
        // can set corder radius of photos default is 15.0
        photosView.cornerRadius = 15.0
        
        // cam set rotaion angle of photos default in -5.0 to 5.0
        photosView.rotaionAngle = 5.0
        
        //can set spped of flick defult is 5.0
        photosView.speedofFlick = 5.0
    
        // can restrict Vertical Move by setting allVeriticalMove property
        photosView.allowVerticalMove = true
        
        // can restrict Vertical Move by setting allHorizontalMove property
        photosView.allowHorizontalMove = true
        
        //<...... Optional Properties End .....>
        
    
    }
    
    
    @IBAction func deletePhoto(sender:UIButton){
        
        photosView.removePhotoFromTop()
    
    
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
            
                // use intertPhoto method to insert image to the stack.
                photosView.insertPhoto(image: image)

                

        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
             
                // use intertPhoto method to insert image to the stack.
                photosView.insertPhoto(image: image)

                    } else{
            print("Something went wrong")
        }
    
        self.dismiss(animated: true, completion: nil)
    }


}




