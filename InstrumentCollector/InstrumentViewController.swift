//
//  InstrumentViewController.swift
//  InstrumentCollector
//
//  Created by Mitch Guzman on 3/11/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var instrumentImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: Any) {
    }
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        instrumentImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let instrument = Instruments(context: context)
        
        instrument.title = titleTextField.text
        instrument.image = UIImagePNGRepresentation(instrumentImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
}
