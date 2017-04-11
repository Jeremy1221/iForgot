//
//  ViewController.swift
//  iForgot
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit

class ClockViewController: UITableViewController {

    var dataArray = [Clock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
//        let clock = Clock.init(time: "test", interval: 60, location: Point.init(x: 1, y: 1), radius: 10, repeatType: .once)
//        let clockData = NSKeyedArchiver.archivedData(withRootObject: clock)
//        UserDefaults.standard.set(clockData, forKey: "userClockData")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clockCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
        }
    }
}

