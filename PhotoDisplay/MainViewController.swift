//
//  ViewController.swift
//  PhotoDisplay
//
//  Created by Masanori.KANEKO on 2015/08/01.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PhotoCollectionViewDelegate {
    @IBOutlet var labelDisplayStatus:UILabel!
    @IBOutlet var photoCollectionViewController:PhotoCollectionViewController!
    var secondScreenWindow: UIWindow?
    var secondScreenView: UIView?
    var secondScreenImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionViewController.displayPhotos()
        // Do any additional setup after loading the view, typically from a nib.
        self.secondScreenView = getSecondScreenView()
        displayStatusUpdate()
        
        photoCollectionViewController.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "secondDisplayConnect:", name: UIScreenDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "secondDisplayDisConnect:", name: UIScreenDidDisconnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "secondDisplayScreenModeDisChange:", name: UIScreenModeDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSecondScreenView() -> UIView? {
        var screens:NSArray = UIScreen.screens()
        if screens.count > 1 {
            var secondScreen:UIScreen = screens.objectAtIndex(1) as! UIScreen
            var maxScreenMode:UIScreenMode?
            var maxSize:CGSize?
            for currentScreenMode in secondScreen.availableModes {
                if(currentScreenMode.size.width > maxSize?.width) {
                    maxSize = currentScreenMode.size
                    maxScreenMode = currentScreenMode as? UIScreenMode
                }
            }
            secondScreen.currentMode = maxScreenMode
            secondScreenWindow = UIWindow()
            secondScreenWindow!.screen = secondScreen
            var secondScreenView:UIView = UIView(frame: CGRectMake(0, 0, maxSize!.width, maxSize!.height))
            secondScreenImageView = UIImageView(frame: CGRectMake(0, 0, maxSize!.width, maxSize!.height))
            secondScreenImageView!.contentMode = UIViewContentMode.Center
            secondScreenView.addSubview(secondScreenImageView!)

            secondScreenWindow!.addSubview(secondScreenView)
            secondScreenWindow!.makeKeyAndVisible()
            return secondScreenView
        } else {
            return nil;
        }
    }
    
    func secondDisplayConnect(notification: NSNotification?) ->Void {
        self.secondScreenView = getSecondScreenView()
        displayStatusUpdate()
    }

    func secondDisplayDisConnect(notification: NSNotification?) ->Void {
        self.secondScreenView = nil
        displayStatusUpdate()
    }

    func secondDisplayScreenModeDisChange(notification: NSNotification?) ->Void {
        NSLog("secondDisplayScreenModeDisChange")
    }
    
    func displayStatusUpdate() ->Void {
        if(self.secondScreenView == nil) {
            labelDisplayStatus.text = "未接続"
        } else {
            labelDisplayStatus.text = "接続済み"
        }
    }
    
    func seelctedImage(image: UIImage) ->Void {
        secondScreenImageView?.image = image
    }
}

