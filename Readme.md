## StackPhotos

An iOS class that create the stack of photos one over another. When user flick the photo it animate and send it to back to pile.

## Demo

PhotoStack is my attempt to create this user interface.

![alt tag](https://media.giphy.com/media/Ln7JXDJUGlcS4/giphy.gif
)
## Installation

Download the source code and copy PhotoView.swift to your project.

## API Reference

Create PhotoView Object by calling PhotoView.init method and pass the frame.

    let photosView = PhotoView.init(frame: CGRect(x:(self.view.frame.size.width-300)/2,y:(self.view.frame.size.height-        300)/2,width:300,height:300))

 ### Method to Initialise the photoview with Images

     photosView.initWithPhotos(images: images as! [UIImage])
  
 ### Method to insert photo to PhotoView
 
    photosView.insertPhoto(image: image)

 ### Method to remove top Photo

    photosView.removePhotoFromTop()

 ### Optional Properties to customise the PhotoView

   
  **Property to Set the Rotation Angle of photos default in -5.0 to 5.0**
      
      photosView.rotaionAngle = 5.0
      
  **Property to Set the speed of Flick by default is 5.0**
      
      photosView.speedofFlick = 5.0
      
  **Property to Restrict Vertical Move by default it is true**
      
      photosView.allowVerticalMove = true
      
  **Property to Restrict Horizontal Move by default it is true**
      
      photosView.allowHorizontalMove = true
      
  **Property to Set the Corner Radius of PhotoView By Default it is 15.0**
      
      photosView.cornerRadius = 15.0
