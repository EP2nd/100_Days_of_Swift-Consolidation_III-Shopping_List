import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAddition))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetList))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        toolbarItems = [spacer, share]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func promptForAddition() {
        let alertController = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] action in
            
            guard let item = alertController?.textFields?[0].text else { return }
            self?.addItem(item)
        }
        
        alertController.addAction(submitAction)
        
        present(alertController, animated: true)
    }
    
    @objc func addItem(_ item: String) {
        
        shoppingList.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }
    
    @objc func resetList() {
        
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let list = shoppingList.joined(separator: "\n")
        
        let viewController = UIActivityViewController(activityItems: [list], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
}

