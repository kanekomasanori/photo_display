//
//  PhotoCollectionViewController.swift
//  PhotoDisplay
//
//  Created by Masanori.KANEKO on 2015/08/03.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit
import Photos

let reuseIdentifier = "photoCell"

protocol PhotoCollectionViewDelegate{
    func seelctedImage(image: UIImage)
}

class PhotoCollectionViewController: UICollectionViewController {
    var photoAssets = [PHAsset]()
    var delegate: PhotoCollectionViewDelegate! = nil
    
    internal func displayPhotos() {
        photoAssets = []
        var assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
            self.photoAssets.append(asset as! PHAsset)
        }
        collectionView?.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.photoAssets.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> PhotoCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
    
        let printManager:PHImageManager = PHImageManager()
        printManager.requestImageForAsset(photoAssets[indexPath.row], targetSize: CGSize(width: 100, height: 100), contentMode: .AspectFill, options: nil) {
            image, info in
            
            cell.photoImageView?.image = image
        }
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .CenteredVertically)
        var collectionViewCell:PhotoCollectionViewCell? = collectionView.cellForItemAtIndexPath(indexPath) as? PhotoCollectionViewCell
        var selectedPhotoImageView:UIImageView? = collectionViewCell?.photoImageView
        var selectedPhotoImage:UIImage? = selectedPhotoImageView?.image
        delegate.seelctedImage(selectedPhotoImage!)
        return true
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
