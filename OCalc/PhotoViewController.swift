//
//  PhotoViewController.swift
//  OCalc
//
//  Created by Md Miah on 6/25/16.
//  Copyright © 2016 OCalcTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AFNetworking

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var allUrls: [String] = [];
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                print("sucesss")
                self.presentViewController(imagePicker, animated: true, completion: {})
            } else {
                print("Rear camera doesn't exist")
            }
        } else {
            print("Camera inaccessable")
        }

        // Do any additional setup after loading the view.
    }

  

    
    @IBAction func retakeImage(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                print("sucesss")
                self.presentViewController(imagePicker, animated: true, completion: {})
            } else {
                print("Rear camera doesn't exist")
            }
        } else {
            print("Camera inaccessable")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        // Get the image captured by the UIImagePickerController
      //  let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
       
        UIImageWriteToSavedPhotosAlbum(editedImage, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        imagePicker.dismissViewControllerAnimated(true, completion: {
            
            // Begin upload
                    })
        imageView.image = editedImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            
//let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
           // ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
          //  presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendImage(sender: AnyObject) {
        
        let manager = AFHTTPRequestOperationManager()
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)

        manager.POST( "http://labs.puneeth.org/ocalc/send-image", parameters: nil,
                      constructingBodyWithBlock: { (data: AFMultipartFormData!) in
                        data.appendPartWithFileData(imageData!, name: "file",fileName: "imageused.jpg", mimeType: "image/jpeg")
            },
                      success: { (operation, responseObject)  in
                        
            },
                      failure:  { (operation, error) in
                        print("Error: " + error.localizedDescription)
        })
        
        performSegueWithIdentifier("showResultsSegue", sender: imageView.image)
    }
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResultsSegue" {
            let _image = sender as! UIImage
            let displayViewController = segue.destinationViewController as! DisplayViewController
            displayViewController.imageView = _image
        }
      }
    

}
