//
//  VCAlbum.swift
//  El5Pino
//
//  Created by Black Castle on 19/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import UIKit

let reuseIdentifier = "PhotoCell"
var indexImage: Int?

class VCAlbum: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bonsais.count
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionImageCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CollectionImageCell
        //Modify cell
        
        cell.imageView.image = bonsais[indexPath.row].getImage()
        //cell.backgroundColor = UIColor.redColor()
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        indexImage = indexPath.row
    }
    
    @IBAction func btnCancel(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }

}

class CollectionImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
}
