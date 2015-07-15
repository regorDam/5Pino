//
//  VCViewPhoto.swift
//  El5Pino
//
//  Created by Black Castle on 19/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCViewPhoto: UIViewController {
    
    @IBAction func TappedCancel(sender: UIBarButtonItem) {
        println("Cancel")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func TappedExport(sender: UIBarButtonItem) {
        println("Export")
    }
    @IBAction func TappedTrash(sender: UIBarButtonItem) {
        println("Trash")
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        imageView.image = bonsais[indexImage!].getImage()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }

}
