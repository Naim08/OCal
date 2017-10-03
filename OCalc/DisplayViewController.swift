//
//  DisplayViewController.swift
//  OCalc
//
//  Created by Md Miah on 6/25/16.
//  Copyright © 2016 OCalcTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DisplayViewController: UIViewController {
    @IBOutlet weak var moleculeName: UILabel!
    
    @IBOutlet weak var imageName: UIImageView!
    
    @IBOutlet weak var averageMass: UILabel!
    
    @IBOutlet weak var molecularMass: UILabel!
    
    @IBOutlet weak var MonoMass: UILabel!
    var test: NSDictionary?
    var imageView: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let url = NSURL(string: "http://labs.puneeth.org/ocalc/getfile")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
                                                                     completionHandler: { (dataOrNil, response, error) in
                                                                        if let data = dataOrNil {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:[]) as? NSDictionary {
                                                                                //print("response: \(responseDictionary)")
                                                                                self.test = responseDictionary as? NSDictionary
                                                                                print(responseDictionary);
                                                                            
                                                                                
                                                                                    let test1 = self.test!["monoisotopic_mass"] as! String
                                                                                let test2 = self.test!["average_mass"] as! String
                                                                                let test3 = self.test!["molecular_mass"] as! String
                                                                                let test4 = self.test!["molecular_formula"] as! String
                                                                                let test5 = self.test!["image_url"] as! String
                                                                                
                                                                                 self.MonoMass.text = test1
                                                                                self.molecularMass.text = test3

                                                                                self.averageMass.text = test2

                                                                                self.imageName.setImageWithURL(NSURL(string: test5)!)

                                                                                self.moleculeName.text = test4

                                                                            }
                                                                        }
        })
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
/*
    @IBOutlet weak var carousel: iCarousel!
    var items: [Int] = []
    override func awakeFromNib()
    {
        super.awakeFromNib()
        for i in 0...99
        {
            items.append(i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .CoverFlow2
        }
        // Do any additional setup after loading the view.

    Alamofire.request(.GET, "http://labs.puneeth.org/ocalc/getfile", parameters: ["foo": "bar"])
    .responseJSON { response in
    print(response.request)  // original URL request
    print(response.response) // URL response
    print(response.data)     // server data
    print(response.result)   // result of response serialization
    
    if let JSON = response.result.value {
    print("JSON: \(JSON)")
    }
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return items.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var label: UILabel
        var itemView: UIImageView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:200, height:200))
            itemView.image = UIImage(named: "page.png")
            itemView.contentMode = .Center
            
            label = UILabel(frame:itemView.bounds)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = label.font.fontWithSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as! UIImageView;
            label = itemView.viewWithTag(1) as! UILabel!
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        //label.text = "\(items[index])"
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
*/