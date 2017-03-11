//
//  ViewController.swift
//  InstrumentCollector
//
//  Created by Mitch Guzman on 3/11/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var instrumentslist : [Instruments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try instrumentslist = context.fetch(Instruments.fetchRequest())
            print(instrumentslist)
            tableView.reloadData()
        } catch {
            print("OOPS WE HAVE AN ERROR")
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instrumentslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let instrument = instrumentslist[indexPath.row]
        cell.textLabel?.text = instrument.title
        cell.imageView?.image = UIImage(data: instrument.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instrument = instrumentslist[indexPath.row]
        performSegue(withIdentifier: "instrumentSegue", sender: instrument)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! InstrumentViewController
        nextVC.instrument = sender as? Instruments
    }
    
}

