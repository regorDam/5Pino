//
//  VCMyCustomCell.swift
//  El5Pino
//
//  Created by Black Castle on 12/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

class VCMyCustomCell: UITableViewCell {
    

    @IBOutlet weak var txtSpecie: UILabel!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var imageBonsai: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(name: String, specie : String, img  :UIImage){
        txtName.text = name
        txtSpecie.text = specie
        imageBonsai.image = img
        
    }
}
