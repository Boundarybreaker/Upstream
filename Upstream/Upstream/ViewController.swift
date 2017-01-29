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
        dialog.allowedFileTypes = ["mp4", "mov"];
        
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
class DragAndDrop: NSView {
    
    var filePath: String?
    let expectedExt = ["mp4", "mov"]
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.gray.cgColor
        register (forDraggedTypes: [NSFilenamesPboardType, NSURLPboardType])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func draggingEntered(_ sender : NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.blue .cgColor
            return .copy
        } else {
            return NSDragOperation()
        }
    }
    
    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as? NSArray,
            let path = board[0] as? String
            else {return false}
        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt{
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as? NSArray,
            let path = pasteboard[0] as? String
            else {return false}
        
        self.filePath = path
        Swift.print("FilePath: \(filePath)")
        
        return true
    }
}


