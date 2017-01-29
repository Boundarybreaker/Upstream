//
//  ViewController.swift
//  Upstream
//
//  Created by Meredith Espinosa on 1/28/17.
//  Copyright © 2017 Meredith Espinosa. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var FilenameField: NSTextField!
    
    @IBAction func browseFile(sender: AnyObject) {
        let dialog = NSOpenPanel();
        
        dialog.title = "Choose a video to upload";
        dialog.showsResizeIndicator = true;
        dialog.showsHiddenFiles = false;
        dialog.canChooseDirectories = true;
        dialog.canCreateDirectories = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes = ["mp4"];
        
        if(dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url
            
            if(result != nil){
                let path = result!.path
                FilenameField.stringValue = path
            }
        } else {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

