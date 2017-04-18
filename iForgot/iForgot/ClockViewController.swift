//
//  ViewController.swift
//  iForgot
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import MapKit

class ClockViewController: UITableViewController, CLLocationManagerDelegate {

    var dataArray = [Clock]()
    var locationManager: CLLocationManager?
    var tag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "clockCell")
//        startStandardUpdates()
//        let clock = Clock.init(time: "test", interval: 60, location: Point.init(x: 1, y: 1), radius: 10, repeatType: .once)
//        let clockData = NSKeyedArchiver.archivedData(withRootObject: clock)
//        UserDefaults.standard.set(clockData, forKey: "userClockData")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clockCell", for: indexPath)
//        cell.accessoryType = .disclosureIndicator
//        cell.tintColor = UIColor().seperateLineColor
        let clockSwitch = cell.contentView.viewWithTag(3) as! UISwitch
        UIView.animate(withDuration: 0.5) { 
            clockSwitch.isHidden = tableView.isEditing
        }
        return cell
    }
    
    //MARK: - UITableViewDatasource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clockDetail = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "clockEdit") as! ClockEditViewController
        self.navigationController?.pushViewController(clockDetail, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
        }
    }
    
    func startStandardUpdates() {
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        locationManager?.delegate = self                                    //代理
        locationManager?.activityType = .otherNavigation                    //活动类型
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer     //精确度
        locationManager?.pausesLocationUpdatesAutomatically = true          //自动停止定位服务
        locationManager?.allowsBackgroundLocationUpdates = true             //
//        self.locationManager?.distanceFilter = 100                          //当距离变化超过这个数值时才会调用didUpdateLocations方法
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.requestAlwaysAuthorization()             //请求后台定位权限
            self.locationManager?.startUpdatingLocation()                       //开始定位
//            self.locationManager?.startMonitoringVisits()                       //start monitoring for visits
//            self.locationManager?.startMonitoringSignificantLocationChanges()   //start signnificant-change location updates
//            self.locationManager?.allowDeferredLocationUpdates(untilTraveled: 100, timeout: 100) //100m or 100sec call didUpdateLocations
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations:%@", locations)
//        print(locations.last?.altitude ?? 0)                //高度
//        print(locations.last?.coordinate ?? 0)              //经纬度
        
        sendLocalNotification()
        let delayTime = DispatchTime.now() + .seconds(4)
        DispatchQueue.main.asyncAfter(deadline: delayTime) { 
//            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError%s", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        print("didFinishDeferredUpdatesWithError:%@", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("didVisit:%@", visit)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        }
    }
    
    //MARK: - Region Monitoring Method
    func registerRegion(overlay: MKCircle, and identifier: String) {
        var radius = overlay.radius
        if radius > (locationManager?.maximumRegionMonitoringDistance)! {
            radius = (locationManager?.maximumRegionMonitoringDistance)!
        }
        
        let geoRegion = CLCircularRegion.init(center: overlay.coordinate, radius: radius, identifier: identifier)
        //121.381782,31.181282
        locationManager?.startMonitoring(for: geoRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didenterregion")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didexitregion")
    }
    
    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.body = "body"
        content.title = "title"
        content.launchImageName = "imageName"
        content.subtitle = "subtitle"
        content.sound = UNNotificationSound.default()
        tag += 1
        content.categoryIdentifier = "someCategory\(tag)"
        if let imageUrl = Bundle.main.path(forResource: "timg", ofType: "jpeg") {
            do {
                let attahment = try? UNNotificationAttachment.init(identifier: "imageAttachment", url: URL.init(fileURLWithPath: imageUrl), options: nil)
                content.attachments = [attahment!]
            } catch {
                
            }
            
            
//            let attachment = try? UNNotificationAttachment.init(identifier: "imageAttachment", url: imageUrl, options: nil) {
//                
//            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest.init(identifier: "message", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("sendLocalNotification")
    }
    
    @IBAction func editClock(_ sender: UIBarButtonItem) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        sender.title = self.tableView.isEditing ? "Done" : "Edit"
        
        let delayTime = DispatchTime.now() + 0.2//.seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addClock(_ sender: UIBarButtonItem) {
        
    }
}

