//
//  ViewController.swift
//  CardScanThreads
//
//  Created by Sam King on 2/18/21.
//
import CardScan
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appleOcrResult: UILabel!
    @IBOutlet weak var ddOcrResult: UILabel!
    @IBOutlet weak var finalOcrResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func crop(image: UIImage) -> CGImage? {
        let x = 0.0
        let width = Double(image.size.width)
        let height = width * 375.0 / 600.0
        let y = Double(image.size.height) * 0.5 - height * 0.5
        let rect = CGRect(x: x, y: y, width: width, height: height)
        return image.cgImage?.cropping(to: rect)
    }
    
    func ocrOn(image: UIImage) -> String {
        guard let croppedImage = crop(image: image) else { return "Error" }
        self.imageView.image = UIImage(cgImage: croppedImage)
        
        return "Not found"
    }
        
    @IBAction func runOcrPress() {
        let image = #imageLiteral(resourceName: "sams_bofa")
        ddOcrResult.text = nil
        appleOcrResult.text = nil
        finalOcrResult.text = nil
        
        finalOcrResult.text = ocrOn(image: image)
    }
    
}

