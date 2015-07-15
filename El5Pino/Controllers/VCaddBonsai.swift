//
//  VCaddBonsai.swift
//  El5Pino
//
//  Created by Black Castle on 3/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit
import MobileCoreServices


class VCaddBonsai: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var btnOp: UIBarButtonItem!
    @IBOutlet weak var barTitle: UINavigationItem!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var spinner: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtStyle: UITextField!
    @IBOutlet weak var txtPlantDate: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtSource: UITextField!
    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtPot: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWidth: UITextField!
    
    
    
    var containerView: UIView!
    var newMedia: Bool?
    var mySpecie:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //spinner.sizeThatFits(CGSize(width: 10, height: 10))
        setUpAdd()
        if(index != -1){
            println("HERE")
            barTitle.title = "Edit bonsai"
            btnOp.title = "Edit"
            txtName.text = bonsais[index].name
            spinner.selectRow(getSpecies(bonsais[index].getSpecie()), inComponent: 0, animated: true)
        }
        
    }
    
    func getSpecies(name: String)->Int{
        var value = find(list, name)
        if(value == nil){
            list.append(name)
            return getSpecies(name)
        }else{
            return value!
        }
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            scrollView.hidden = false
            setUpAdd()
            break
        case 1:
            scrollView.hidden = true
            
            break
        default:
            break
        }
    }
    
    func setUpAdd(){
        let aSelector : Selector = "start:"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        mySpecie = list[0]
        
        // Set up the container view to hold your custom view hierarchy
        //let containerSize = CGSizeMake(640.0, 640.0)
        let containerSize = CGSizeMake(0, self.view.frame.height * 1.7)
        
        containerView = UIView(frame: CGRect(origin: CGPointMake(0.0, 0.0), size:containerSize))
        scrollView.addSubview(containerView)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scale
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func start (recognizer: UITapGestureRecognizer){
        print(" PHOTO ")
        useCamera()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
    
    
    //PICKER SPECIES
    func numberOfComponentsInPickerView(pickerView: UIPickerView)-> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView{
        var label:UILabel = UILabel(frame: CGRectMake(0, 0, pickerView.frame.size.width, 44))
        label.font = UIFont(name:"AppleSDGothicNeo-Thin", size: 20)
        label.text = list[row]
        return label
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        return list[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mySpecie = list[row]
    }
    
    
    @IBAction func cancelToBonsaiViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTapped(sender: UIButton){

        if (countElements(txtName.text) > 0){
            switch (btnOp.title!){
                case "add" :
                    newBonsai()
                    break
                case "Edit" :
                    editBonsai()
                break
                default:
                    break
                
            }
        }
        else {
            let alertController = UIAlertController(title: "El5Pino", message:
                "The name is required", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,
                handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    func useCamera() {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()

                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.mediaTypes = [kUTTypeImage as NSString]
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
                newMedia = true
        }
    }
    
    func newBonsai(){
        
        //bonsais.append(CBonsai(name: txtName.text, species: mySpecie))
        jsonInsert()
        
    }
    
    func jsonInsert(){
        var url: NSURL = NSURL(string: "http://\(server!)/5Pino/createBonsai.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        
        let params:[String:Any] = [
            "name" : txtName.text,
            "species" : mySpecie,
            //"photo" : ""
        ]
        
        var bodyData = "name=\(txtName.text)&species=\(mySpecie)"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        //request.HTTPBody = params.
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println(response)
                if let HTTPResponse = response as? NSHTTPURLResponse {
                    let statusCode = HTTPResponse.statusCode
                    
                    if statusCode == 200 {
                        let date = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
                        let hour = components.hour
                        let minutes = components.minute
                        logs.append("new bonsai with name:\(self.txtName.text) at: \(hour):\(minutes) ")
                        let alertController = UIAlertController(title: "El5Pino", message:
                            "Added new bonsai! called: \(self.txtName.text) and family: \(self.mySpecie))", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,
                            handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
        }
        
    }
    
    
    func editBonsai(){
        jsonEdit()
    }
    
    func jsonEdit(){
        var url: NSURL = NSURL(string: "http://\(server!)/5Pino/updateBonsaiByID.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        
        let params:[String:Any] = [
            "name" : txtName.text,
            "species" : mySpecie,
            "id" : bonsais[index].id
            //"photo" : ""
        ]
        
        var bodyData = "name=\(txtName.text)&species=\(mySpecie)&id=\(bonsais[index].id)"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        //request.HTTPBody = params.
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println(response)
                if let HTTPResponse = response as? NSHTTPURLResponse {
                    let statusCode = HTTPResponse.statusCode
                    
                    if statusCode == 200 {
                        let date = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
                        let hour = components.hour
                        let minutes = components.minute
                        logs.append("new bonsai with name:\(self.txtName.text) at: \(hour):\(minutes) ")
                        let alertController = UIAlertController(title: "El5Pino", message:
                            "Added new bonsai! called: \(self.txtName.text) and family: \(self.mySpecie))", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,
                            handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
        }
        
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
