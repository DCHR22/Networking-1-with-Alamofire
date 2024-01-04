//
//  TitleViewController.swift
//  Networking #1 with Alamofire
//
//  Created by Camilo L-Shide on 02/01/24.
//

import UIKit


class TitleViewController : UITableViewController {

    var titleMO = TitleManager()
    var titleSelection = "" // This titleSelection is equal to the sender parameter from the performSegue Method.
    var dataSource: [TitleData1] = [TitleData1]() // This data source is super important since it is indeed what we will be using to populate the table view cells.
    

    override func viewDidLoad() {

        super.viewDidLoad()
        self.titleMO.fetchTitle(titleSelection: titleSelection, delegate: self) // On this one we initiate the service.
    }
    
    
    
}

extension TitleViewController : ServiceDelegate { // Here is where we implement the ServiceDelegate methods.
    
    func onSuccess(data: [TitleData1]) {
        
        self.dataSource = data // At this point the children/TitleData1 array obtained by decoding the data from the JSON is now the datasource. That array will both help us to implement the TableView Delegate Methods.
        
        DispatchQueue.main.async { // We do send this to the main queue since this updates the UI and that process is somehow waiting a clousure result to be completed. By doing this we avoid the bottering frozen UI effect.
            
            self.tableView.reloadData() // This recreates the table, every time this is called the actual table is updated thus the TableView delegate methods are called.
        }
        
    }
    
    func onError(error: String) {
        
        let alert = UIAlertController(title: "Something went wrong!", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
    
}

extension TitleViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count // This is the lengt of the Children array obtained in the JSON.
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        
        let item = self.dataSource[indexPath.row]  //In this line we simply get a hold of the TitleData1/Children object found on the array by using the indexPath.row property.
        
        print("title: " + item.data.title) // This is just to confirm in the console that the call is actually working.
        
        cell.textLabel?.text = item.data.title // In this line we do dive deeper into each object in the children array by getting hold of its data1 property and the title property of the Main1 struct.
        
        
        return cell
        
    }
}

