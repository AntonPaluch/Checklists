//
//  AddItemVC.swift
//  Checklists
//
//  Created by Pandos on 02.12.2021.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(
    _ controller: AddItemVC)
  func addItemViewController(
    _ controller: AddItemVC,
    didFinishAdding item: ChecklistItem
  )
  func addItemViewController(
    _ controller: AddItemVC,
    didFinishEditing item: ChecklistItem
  )
}

class AddItemVC: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
            // variable shadowing
//            if let itemToEdit = itemToEdit {
//              title = "Edit Item"
//              textField.text = itemToEdit.text
//            }
        }

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        textField.becomeFirstResponder()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
        
// MARK: - Table View Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
// MARK: - Actions

  @IBAction func cancel () {
      delegate?.addItemViewControllerDidCancel(self)
  }

  @IBAction func done() {
      if let item = itemToEdit {
          item.text = textField.text!
          delegate?.addItemViewController(
            self,
            didFinishEditing: item)
      } else {
      let item = ChecklistItem()
      item.text = textField.text!
      delegate?.addItemViewController(self, didFinishAdding: item)
    }
  }
}

extension AddItemVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
         in: stringRange,
         with: string)
//        if newText.isEmpty {
//            doneBarButton.isEnabled = false
//        } else {
//            doneBarButton.isEnabled = true
//        }
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}
