//
//  AddItemVC.swift
//  Checklists
//
//  Created by Pandos on 02.12.2021.
//

import UIKit

class AddItemVC: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

    }

// MARK: - Table View Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    
    
    
// MARK: - Actions

  @IBAction func cancel () {
    navigationController?.popViewController(animated: true)
  }

  @IBAction func done() {
    print("Contents of the text field: \(textField.text!)")
    navigationController?.popViewController(animated: true)
  }
}
