//
//  GenerateThumbnailForURL.swift
//  QLWindowsExecutable
//
//  Created by Robbert Brandsma on 29-06-15.
//  Copyright © 2015 Robbert Brandsma. All rights reserved.
//

import Foundation
import CoreServices
import QuickLook
import Cocoa

// Thanks to http://stackoverflow.com/questions/26971240/how-do-i-run-an-terminal-command-in-a-swift-script-e-g-xcodebuild
func shell(args: String...) -> Int32 {
    let task = NSTask()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func extractWindowsIcon(file: NSURL) -> NSImage? {
    let destinationPath = NSTemporaryDirectory().stringByAppendingPathComponent("\(NSUUID().UUIDString).ico")
    let sourcePath = file.path!
    let status = shell("/usr/local/bin/wrestool", "-x", "-t", "14", sourcePath, "-o", destinationPath)
    
    let fm = NSFileManager.defaultManager()
    if status != 0 || !fm.fileExistsAtPath(destinationPath) { return nil }

    
    
    let image = NSImage(contentsOfFile: destinationPath)
//    let image = NSData(contentsOfFile: destinationPath)
    try! NSFileManager.defaultManager().removeItemAtPath(destinationPath)
    return image
}

@objc class ThumbnailGenerator {
    
    class func generateThumbnailForURL(thisInterface: UnsafePointer<Void>, thumbnail: QLThumbnailRequest, url: NSURL, contentTypeUTI: String, options: NSDictionary, maxSize: CGSize) -> OSStatus {
        
        guard let image = extractWindowsIcon(url) else { return 1 }
        let imgRep = image.representations[0] as! NSBitmapImageRep
        let imageData = imgRep.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [String : AnyObject]())
        
        QLThumbnailRequestSetImageWithData(thumbnail, imageData, nil);
        
//        
//        // Hand memory over to ARC
//        var cgContext = _cgContext.takeRetainedValue()
//        _cgContext.release()
//        
//        let context = NSGraphicsContext(graphicsPort: &cgContext, flipped: true)
//        NSGraphicsContext.setCurrentContext(context)
//        image.drawInRect(NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
//        
//        QLThumbnailRequestFlushContext(thumbnail, cgContext)
        
        return noErr
    }
}