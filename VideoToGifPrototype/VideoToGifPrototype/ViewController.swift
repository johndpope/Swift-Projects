//
//  ViewController.swift
//  VideoToGifPrototype
//
//  Created by Mohan Dhar on 1/11/16.
//  Copyright (c) 2016 Mohan Dhar. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary


class ViewController: UIViewController {
    var count = 0;
    var timer: NSTimer?;
    var array = [UIImage]();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func takeScreenshot() {
        UIGraphicsBeginImageContext(self.view.bounds.size);
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!);
        let screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        array.append(screenshot);
        
        ++count;
        print("\(count)\n", terminator: "");
        
    }
    
    @IBAction func take18ButtonPressed(sender: UIButton) {
        take18Screenshots();
    }
    
    @IBAction func screenshotButtonPressed(sender: UIButton) {
        takeScreenshot();
    }
    
    func take18Screenshots() {
        array = [ ];
        timer?.invalidate();
        count = 0;
        timer = NSTimer.scheduledTimerWithTimeInterval(0.03333333, target: self, selector: "takeScreenshot", userInfo: nil, repeats: true);
        timer?.fire();
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        timer?.invalidate();
        saveVidToLibrary();
        array = [ ];
    }
    
    
    func saveVidToLibrary() {
        let fileName = "temp.mp4";
        let width = 640;
        let height = 480;
        
        // Choose directory to save on
        let directoryOut = "/tmp/";
        let outFile = directoryOut + fileName;
        print("outFile: \(outFile)");
        let path = NSHomeDirectory().stringByAppendingString(outFile);
        print("path: \(path)");
        let vidTempURL = NSURL.fileURLWithPath("\(NSTemporaryDirectory())\(fileName))");
        print("vidTempURL: \(vidTempURL)");
        
        // AVAsset writer does not overwrite files for us, so remove destination file if it already exists
        let fileManager = NSFileManager.defaultManager();
        do {
            try fileManager.removeItemAtPath(vidTempURL.path!);
        } catch {}
        
        //let videoWriter = try? AVAssetWriter(URL: vidTempURL, fileType: AVFileTypeMPEG4);
        let videoWriter = try? AVAssetWriter(URL: NSURL(fileURLWithPath: path), fileType: AVFileTypeMPEG4);
        
        let videoSettings = [ AVVideoCodecKey : AVVideoCodecH264,
        AVVideoWidthKey : width, AVVideoHeightKey : height] as? [String : AnyObject];
        
        let writerInput = AVAssetWriterInput(mediaType: AVMediaTypeVideo, outputSettings: videoSettings);
        
        var adapter = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: nil);
        
        // Assert that the videoWriter can indeed take in the video input
        assert((videoWriter?.canAddInput(writerInput))!);
        videoWriter?.addInput(writerInput);
        
        // Start the session
        videoWriter?.startWriting();
        videoWriter?.startSessionAtSourceTime(kCMTimeZero);
        
        
        var buffer:CVPixelBufferRef?;
        var i = 0;
        while (true) {
            if (writerInput.readyForMoreMediaData) {
                let frameTime = CMTimeMake(33, 600);
                let lastTime = CMTimeMake(Int64(i * 50), 600);
                var presentTime = CMTimeAdd(lastTime, frameTime);
                
                if (i == 0) { presentTime = CMTimeMake(0, 600); }
                
                if (i >= array.count) {
                    buffer = nil;
                } else {
                    buffer = self.pixelBufferFromCGImage(array[i].CGImage!, height: height, width: width);
                }
                
                
                if let buffer = buffer {
                    
                    adapter.appendPixelBuffer(buffer, withPresentationTime: presentTime);
                    i++;
                    
                } else {
                    
                    writerInput.markAsFinished();
                    videoWriter?.finishWritingWithCompletionHandler({
                        
                        print("Finished writing.. check completion status\n");
                        if (videoWriter?.status != AVAssetWriterStatus.Failed && videoWriter?.status == AVAssetWriterStatus.Completed) {
                            print("Video writing succeeded");
                            var vidTempURL = NSURL.fileURLWithPath("\(path)")
                            print("vidTempURL: \(vidTempURL)");
                            self.saveToCameraRoll(vidTempURL);
                            
                        } else {
                            print("Video writing failed: \(videoWriter?.error)\n");
                        }
                    
                    
                    })
                    print("Done\n");
                    break;
                    
                }
            }
        }
    }
    
    func saveToCameraRoll(url: NSURL) {
        let library = ALAssetsLibrary();
        let completionBlock:ALAssetsLibraryWriteVideoCompletionBlock = {
            (newUrl, error) -> Void in
            if (error != nil) {
                print("Error writing with metadata to Photo Library: \(error)");
            } else {
                    print("Wrote image to photo library with metadata!!!\n\(newUrl)");
            }
        };
        
        library.writeVideoAtPathToSavedPhotosAlbum(url, completionBlock: completionBlock);

    }


    func pixelBufferFromCGImage(image: CGImageRef, height: Int, width: Int) -> CVPixelBufferRef {
        
        let options = NSDictionary(dictionary: [ kCVPixelBufferCGImageCompatibilityKey : true,
            kCVPixelBufferCGBitmapContextCompatibilityKey : true  ] ) as CFDictionaryRef;
        
        var pixelBuffer: CVPixelBufferRef?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, options,
            &pixelBuffer);
        
        assert(status == kCVReturnSuccess && pixelBuffer != nil);

        CVPixelBufferLockBaseAddress(pixelBuffer!, 0);
        let pixelData:UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddress(pixelBuffer!);
        assert(pixelData != nil);
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        let context = CGBitmapContextCreate(pixelData, width, height, 8, 4 * width, rgbColorSpace, CGImageAlphaInfo.NoneSkipFirst.rawValue);

        assert(context != nil);
        
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
        CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), image);
        

        CVPixelBufferUnlockBaseAddress(pixelBuffer!, 0);
        return pixelBuffer!;

    
    }
}

