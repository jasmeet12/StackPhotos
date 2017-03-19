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
    @IBOutlet weak var photosView:UIView!
    
    var photos:Array = [Dictionary<String ,Any>]()
    var photsDict:Dictionary =  Dictionary<String , Any>()
    var currentAngle:Int = 0
    var imagePicker = UIImagePickerController()
    
    var isVerticalDirection:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    func getPhotoViewSize(image:UIImage,size:CGSize)->CGSize{
    
        var width = image.size.width
        var height = image.size.height
        
        
        
        let photoHeight = size.height - 250
        let photoWidth = size.width - 30
        if(width > height){
        
        
            let aspectRatio = width/height
            
            width = photoWidth
            height = photoWidth / aspectRatio
            
    
            
        }else{
        
            let aspectRatio = height/width
            //height =  (photoHeight * aspectRatio  > photoHeight) ? photoHeight : photoWidth * aspectRatio
            height = photoHeight
            width = photoHeight / aspectRatio

        
        }
        
            

       
        let size = CGSize(width: width,height: height)
        return size
        
        
    }
    
    
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
    
    
    
    var view = UIImageView()
    
  
    

            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
               let size = getPhotoViewSize(image: image, size: CGSize(width:self.photosView.frame.size.width,height:self.photosView.frame.size.height))
                
                let x = CGFloat((self.photosView.frame.size.width - size.width)/2)
                let y = CGFloat((self.photosView.frame.size.height - size.height)/2)

                view = UIImageView(frame: CGRect(x:x,y:y,width:size.width,height:size.height))

            view.image = image.resizedImage(newSize: view.frame.size)
                

        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
             
                
                let size = getPhotoViewSize(image: image, size: CGSize(width:self.photosView.frame.size.width,height:self.photosView.frame.size.height))
                
                let x = CGFloat((self.photosView.frame.size.width - size.width)/2)
                let y = CGFloat((self.photosView.frame.size.height - size.height)/2)
                view = UIImageView(frame: CGRect(x:x,y:y,width:size.width,height:size.height))

            view.image = image.resizedImage(newSize: view.frame.size)
                    } else{
            print("Something went wrong")
        }
    
    
    addSwipeGesture(view:view)
    addPanGesture(view:view)
     view.layer.masksToBounds = true
    view.layer.cornerRadius = 15.0
   
    
    self.photsDict["Photo"] = view
    self.photsDict["Angle"] = 0
    self.photos.append(photsDict)
    self.photosView.addSubview(view)
    
    self.updateUI()
    
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    func updateUI(){
        currentAngle = 0
        if(photos.count > 1){
        for var i in 1 ..< photos.count{
            
            let imageView = photos[photos.count-i-1]["Photo"] as! UIImageView
            
            var angle = 0
            
            if (i%3 == 0)
            {
                
                angle = imageView.frame.size.width > imageView.frame.size.height  ? 90 : 0
                
                
            
            }
            else if (i%2 == 0){
            
                angle = currentAngle + 350
            }
            else{
            
                angle = currentAngle + 5
            }
            
            
            currentAngle = angle
            
            
                
            let radians = atan2f(Float(Double(imageView.transform.b)), Float(Double(imageView.transform.a)));
            let degrees = radians * Float(180 / M_PI);
            photos[photos.count-i-1]["Angle"] = angle
            imageView.rotate(angle: CGFloat(360-degrees-Float(angle)))
            
        }
        }
        
        
        
        
    }

    
    func addPanGesture(view:UIImageView){
    
        
         let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRecognizer)
    }
    
   
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        else if gestureRecognizer.state == .ended{
        
            let x = CGFloat((gestureRecognizer.view!.superview!.frame.size.width )/2)
            let y = CGFloat((gestureRecognizer.view!.superview!.frame.size.height )/2)

//            let x = CGFloat(50) + gestureRecognizer.view!.frame.size.width/2
//            let y = CGFloat(250/2) + gestureRecognizer.view!.frame.size.height/2
                       UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                         // gestureRecognizer.view!.alpha = 0
                        gestureRecognizer.view!.superview?.sendSubview(toBack: gestureRecognizer.view!)
                         gestureRecognizer.view!.center =  CGPoint(x: x, y:y)
                       }, completion: { _ in
                        
                        self.photos.insert(self.photos.last!, at: 0)
                        self.photos.remove(at: self.photos.count-1)
                        let imageView = self.photos.last!["Photo"] as! UIImageView
                        let angle = 360 - abs((self.photos.last!["Angle"] as! Int))
                    
                        let radians = atan2f(Float(Double(imageView.transform.b)), Float(Double(imageView.transform.a)));
                        let degrees = radians * Float(180 / M_PI);
                        
                            self.updateUI()
                       
                        imageView.rotate(angle: CGFloat(360 - degrees) )
                        self.photos[self.photos.count-1]["Angle"] = 0
                       
                       
                       })
            
            
            //gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)

        
        }
    }
    
    func addSwipeGesture(view:UIImageView){
    
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(sender:)))
        let rightSwipeGesture = UISwipeGestureRecognizer(target:self,action: #selector(swipeRight(sender:)))
    
    
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.left
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.right
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(leftSwipeGesture)
        view.addGestureRecognizer(rightSwipeGesture)
        
    }

    

    func swipeLeft(sender:UIImageView){
    
    
        print("SwipedLeft")
        
        
//           UIView.animate(withDuration: 0.5, delay: 0.3, options: [.repeat, .curveEaseOut, .autoreverse], animations: {
//                sender.x =
//            }, completion: nil)
        
    }
    
    
    func swipeRight(sender:UIImageView){
    
     print("SwipedRight")
    }
    
    @IBAction func deletePhoto(sender:UIButton){
    
    
    }
}


extension UIImageView {
    
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
      let   angle = angle < 0 ? 360 - angle : angle
        let radians = angle / 180.0 * CGFloat(M_PI)
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
}

extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width:size.width/resizeFactor,height:size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
}



