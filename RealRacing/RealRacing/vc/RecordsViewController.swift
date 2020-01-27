//
//  RecordsViewController.swift
//  RealRacing
//
//  Created by Родион Ковалевский on 11/21/19.
//  Copyright © 2019 Родион Ковалевский. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let swipeBack = UISwipeGestureRecognizer(target: self, action: #selector(backSwipe(_:)))
        swipeBack.direction = .right
        self.view.addGestureRecognizer(swipeBack)

    }
    

        @IBAction func backSwipe(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RecordsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = StorageManager.shared.getRecordsArray(){
            return array.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
                   return UITableViewCell()
               }
               if let array = StorageManager.shared.getRecordsArray() {
                   let record = array[indexPath.row]
                   cell.setupCell(cell: cell, record: record)
               }
               return cell
    }
    
    
}
