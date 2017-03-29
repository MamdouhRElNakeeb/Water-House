//
//  Tracking.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/29/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class Tracking: UIViewController {

    @IBOutlet weak var trackingTableView: UITableView!
    
    var trackingData: Array<TrackingItem> = Array <TrackingItem>()
    
    var orderItem: OrderItem = OrderItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trackingTableView.rowHeight = 110
        
        if orderItem.orderStatus.isEmpty{
            orderItem.orderStatus = "تم الطلب"
        }
        
        trackingData.append(TrackingItem.init(dateMille: orderItem.date, status: orderItem.orderStatus))
        
        trackingTableView.reloadData()
    }

    @IBAction func backBtnOnClick(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }

}
extension Tracking : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return trackingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackingCell") as! TrackingTableViewCell
        
        let dateFormat: DateFormat  = DateFormat()
        
        cell.dateLabel.text = dateFormat.getDateStr(dateMilli: trackingData[indexPath.row].dateMille)
        cell.timeLabel.text = dateFormat.getTimeStr(dateMilli: trackingData[indexPath.row].dateMille)
        cell.statusLabel.text = trackingData[indexPath.row].status
        cell.tag = indexPath.row
        
        return cell
    }
    
}




















