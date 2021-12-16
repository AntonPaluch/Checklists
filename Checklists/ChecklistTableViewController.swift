//
//  ChecklistTableViewController.swift
//  Checklists
//
//  Created by Pandos on 20.11.2021.
//

import UIKit

class ChecklistTableViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem()
          item1.text = "Walk the dog"
          items.append(item1)

          let item2 = ChecklistItem()
          item2.text = "Brush my teeth"
          item2.checked = true
          items.append(item2)

          let item3 = ChecklistItem()
          item3.text = "Learn iOS development"
          item3.checked = true
          items.append(item3)

          let item4 = ChecklistItem()
          item4.text = "Soccer practice"
          items.append(item4)

          let item5 = ChecklistItem()
          item5.text = "Eat ice cream"
          items.append(item5)
        
        tableView.rowHeight = 50
        
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    // MARK: - Table view data source

    //Количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
//        Cоздаем константу которая равна объекту массива ChecklistItem по индексу, соответствующему номеру строки
//        Когда у вас есть этот объект, вы можете просто просмотреть его текст и проверенные свойства и сделать все, что вам нужно.
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            //метод toggle возвращает противоположное булевое значение
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)        }
            tableView.deselectRow(at: indexPath, animated: true)
          }
        
//        func configureCheckmark( for cell: UITableViewCell,at indexPath: IndexPath) {
//            let item = items[indexPath.row]
//            if item.checked {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
//        }
    // перепишем функцию на работу на прямую с элементами ChecklistItem
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked {
           cell.accessoryType = .checkmark
           } else {
           cell.accessoryType = .none
        }
    }
    
    //Функция добавления текста в лейбл ячейки по tag = 1000
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    //Метод удаления ячеек
    
    override func tableView( _ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath ) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
// MARK: - Add Item ViewController Delegates
    
    func addItemViewControllerDidCancel(_ controller: AddItemVC) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemVC, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
//  MARK: - Actions
    
    
    @IBAction func addItem() {
        let newRowIndex = items.count
        //создаем экземпляр класса и добавляем его в модель данных - массив items
        let item = ChecklistItem()
        item.text = "I am a new row"
        item.checked = true
        items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

    }
    

}
