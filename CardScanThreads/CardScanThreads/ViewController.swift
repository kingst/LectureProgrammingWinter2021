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
    
    let mlQueue = DispatchQueue(label: "ml queue")
    
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
        DispatchQueue.main.async {
            self.imageView.image = UIImage(cgImage: croppedImage)
        }
        
        var appleOcrPrediction: CreditCardOcrPrediction?
        
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .userInitiated).async {
            let appleOcr = CardScan.AppleCreditCardOcr(dispatchQueueLabel: "apple ocr")
            let result = appleOcr.recognizeCard(in: croppedImage, roiRectangle: CGRect(x: 0, y: 0, width: croppedImage.width, height: croppedImage.height))
            appleOcrPrediction = result
            semaphore.signal()
        }
        
        var ddOcrPrediction: CreditCardOcrPrediction?
        
        DispatchQueue.global(qos: .userInitiated).async {
            let ddOcr = CardScan.SSDCreditCardOcr(dispatchQueueLabel: "dd ocr")
            let result = ddOcr.recognizeCard(in: croppedImage, roiRectangle: CGRect(x: 0, y: 0, width: croppedImage.width, height: croppedImage.height))
            ddOcrPrediction = result
            semaphore.signal()
        }
        
        semaphore.wait()
        semaphore.wait()
        
        DispatchQueue.main.async {
            self.appleOcrResult.text = appleOcrPrediction?.number ?? "Not found"
            self.ddOcrResult.text = ddOcrPrediction?.number ?? "Not found"
        }
            
        return ddOcrPrediction?.number ?? appleOcrPrediction?.number ?? "Not found"
    }
    
    func runInTheBackground(image: UIImage, completion: @escaping ((String) -> Void)) {
        mlQueue.async {
            let result = self.ocrOn(image: image)
            DispatchQueue.main.async { completion(result) }
        }
    }
    
    @IBAction func runOcrPress() {
        let image = #imageLiteral(resourceName: "sams_bofa")
        ddOcrResult.text = nil
        appleOcrResult.text = nil
        finalOcrResult.text = nil
        
        //finalOcrResult.text = ocrOn(image: image)
        runInTheBackground(image: image) { result in
            self.finalOcrResult.text = result
        }
    }
    
}

