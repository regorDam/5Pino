//
//  ViewController.swift
//  El5Pino
//
//  Created by Black Castle on 2/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getBonsai_json()
        index = -1
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //getBonsai_json()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //TABLE VIEW
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bonsais.count;
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:VCMyCustomCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as VCMyCustomCell
        
        cell.setCell(bonsais[indexPath.row].getName(), specie: bonsais[indexPath.row].getSpecie(), img: bonsais[indexPath.row].getImage()!)
        
        
        return cell
    }
    
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        index = indexPath.row
        self.performSegueWithIdentifier("goto_addBonsai", sender: nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            logs.append("bonsai deleted with name: \(bonsais[indexPath.row].name)")
            deleteRow(indexPath.row)
           // self.getBonsai_json()
        }
    }
    
    // JSON EXAMPLE products practica android
    func getBonsai_json(){
        //
        bonsais =  [CBonsai]()
        let urlAsString = "http://\(server!)/5Pino/getBonsais.php"
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
            var productsTag:[NSDictionary] = jsonResult["bonsais"] as [NSDictionary]
            
            for bonsai in productsTag{
                var id = bonsai["id"] as NSString
                var name = bonsai["name"] as NSString
                var specie = bonsai["species"] as NSString
                //products = products + name + " "
                bonsais.append(CBonsai(id: id, name: name, species: specie))
                println(name)
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView!.reloadData()
                
            })
        })
        //
        jsonQuery.resume()
    }
    
    func deleteRow(index: Int){
        var url: NSURL = NSURL(string: "http://\(server!)/5Pino/deleteBonsaiByID.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        
        var bodyData = "id=\(bonsais[index].id)"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println(response)
                if let HTTPResponse = response as? NSHTTPURLResponse {
                    let statusCode = HTTPResponse.statusCode
                    
                    if statusCode == 200 {
                        //
                        print("remove OK")
                        self.getBonsai_json()

                    }
                }
        }
        
    }

}

