//
//  VCWebService.swift
//  El5Pino
//
//  Created by Black Castle on 4/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCWebService: UIViewController {

    @IBOutlet weak var lblProducts: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var txtField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonTest()
    }
    
    @IBAction func showProductsTapped(sender: UIButton) {
    
        jsonProducts()
        
    }
    
    @IBAction func addSpecieTapped(sender: UIButton) {
        list.append(txtField.text)
        logs.append("New Specie Added \(txtField.text)")
    }
    
    

    // JSON EXAMPLE products practica android
    func jsonProducts(){
        //
        let urlAsString = "http://\(IP!)/wsdam/pdo_productsRead.php"
        let url = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        //
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            
            //
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            var successTag = jsonResult["success"] as? Double
            var productsTag:[NSDictionary] = jsonResult["products"] as [NSDictionary]
            
            for product in productsTag{
                var name = product["name"] as NSString
                products = products + name + " "
                
            }
            
            let jsonProducts = productsTag[0]
            let jsonName: String! = jsonProducts["name"] as NSString
            println(products)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.lblProducts.text = products
                
            })
        })
        //
        jsonQuery.resume()
    }
    
    //Example simple json
    func jsonTest(){
        //
        
        let urlAsString = "http://date.jsontest.com"
        let url = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        //
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            
            //
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            //
            let jsonDate: String! = jsonResult["date"] as NSString
            let jsonTime: String! = jsonResult["time"] as NSString
            println(jsonDate)
            dispatch_async(dispatch_get_main_queue(), {
                self.lblDate.text = jsonDate
                self.lblTime.text = jsonTime
            })
        })
        //
        jsonQuery.resume()
    }
}
