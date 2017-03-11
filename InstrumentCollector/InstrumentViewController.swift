//
//  InstrumentViewController.swift
//  InstrumentCollector
//
//  Created by Mitch Guzman on 3/11/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var instrumentImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var instrument : Instruments? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if instrument != nil {
//            print("we have an instrument")
            instrumentImageView.image = UIImage(data: instrument?.image as! Data)
            titleTextField.text = instrument?.title
            
            addUpdateButton.setTitle("Update", for: .normal)
            
        } else {
//            print("we have no instrument")
            deleteButton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
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
        
        if instrument != nil {
            instrument!.title = titleTextField.text
            instrument!.image = UIImagePNGRepresentation(instrumentImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let instrument1 = Instruments(context: context)
            
            instrument1.title = titleTextField.text
            instrument1.image = UIImagePNGRepresentation(instrumentImageView.image!) as NSData?
        }
        
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(instrument!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
