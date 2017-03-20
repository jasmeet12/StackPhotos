//
//  PhotoView.swift
//  stackPhotos
//
//  Created by Jasmeet Kaur on 19/03/17.
//  Copyright © 2017 Jasmeet Kaur. All rights reserved.
//

import UIKit

class PhotoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static var cornerRadius:CGFloat = 20.0
    static var rotaionAngle:CGFloat = 10.0

    static var isBorderShow:Bool = false
    
    var photos:[UIImageView]=[]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertPhoto(image:UIImage){
    
    var view = UIImageView()
        let size = getPhotoViewSize(image: image, size: CGSize(width:self.frame.size.width,height:self.frame.size.height))
        
        let x = CGFloat((self.frame.size.width - size.width)/2)
        let y = CGFloat((self.frame.size.height - size.height)/2)
        
        view = UIImageView(frame: CGRect(x:x,y:y,width:size.width,height:size.height))
        view.image = image
        
        addPanGesture(view:view)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15.0
        
        
      
        self.photos.append(view)
        self.addSubview(view)
        
        self.updateUI()
    }
    
    func updateUI(){
         var currentAngle = 0
        if(photos.count > 1){
            for var i in 1 ..< photos.count{
                
                let imageView = photos[photos.count-i-1]
                
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
            
            let translation = gestureRecognizer.translation(in: self)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self)
        }
        else if gestureRecognizer.state == .ended{
            
            let x = CGFloat((gestureRecognizer.view!.superview!.frame.size.width )/2)
            let y = CGFloat((gestureRecognizer.view!.superview!.frame.size.height )/2)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                // gestureRecognizer.view!.alpha = 0
                gestureRecognizer.view!.superview?.sendSubview(toBack: gestureRecognizer.view!)
                gestureRecognizer.view!.center =  CGPoint(x: x, y:y)
            }, completion: { _ in
                
                self.photos.insert(self.photos.last!, at: 0)
                self.photos.remove(at: self.photos.count-1)
                let imageView = self.photos.last!
                
                
                let radians = atan2f(Float(Double(imageView.transform.b)), Float(Double(imageView.transform.a)));
                let degrees = radians * Float(180 / M_PI);
                
                self.updateUI()
                
                imageView.rotate(angle: CGFloat(360 - degrees) )
                
                
                
            })
            
            
           
            
            
        }
    }

    
    
    func removePhoto(){
    
    
    
    }
    
  func  initWithPhotos(images:[UIImage]){
    
    
    for view in self.subviews{
    
    view.removeFromSuperview()
        
    }
    
    for image in images{
    
    self.insertPhoto(image: image)
    }
        
        
    }
    
    func getPhotoViewSize(image:UIImage,size:CGSize)->CGSize{
        
        var width = image.size.width
        var height = image.size.height
        
        
        
        let photoHeight = size.height
        let photoWidth = size.width 
        if(width > height){
            
            
            let aspectRatio = width/height
            
            width = photoWidth
            height = photoWidth / aspectRatio
            
            
            
        }else{
            
            let aspectRatio = height/width
            
            height = photoHeight
            width = photoHeight / aspectRatio
            
            
        }
        
        
        
        
        let size = CGSize(width: width,height: height)
        return size
        
        
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