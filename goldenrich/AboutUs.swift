//
//  AboutUs.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class AboutUs: UITableViewController {
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    let aboutArray: [String] = [ "Siwa" ,
                           "While the history of Siwa Oasis goes back to several centuries B.C, one of the first local manuscripts mentions seven families and a total of 40 men, who lived there in 1203. It is said that the head of the seven families was an old man, who was an early riser with the habit of walking around the Oasis every dawn to meditate on the beauty of Siwa’s nature. On one of his walks he discovered a water well, which seemed different than other wells on the Oasis. It was deeper and its water tasted far better. He even claimed that this special water recovered his health and protected the health of his children. Several centuries later, the same special wat",
                           "Aman Siwa",
                           "Water \"Aman Siwa\" is quite far from all sources of pollution from sewage and industrial and agricultural production suffered by the natural water sources in the Valley and the Nile Delta in Egypt. Groundwater in the Siwa Oasis rolling from Lake Victoria of the Nile Manaabie directly. The purification and sterilization processes and automatic control packing down any human intervention in any of the stages of production, and the manufacturing environment surrounding the production process perfectly matched to the instructions and requirements of modern industry and using ozone gas in the sterilization process. High purification is the basis of the new production lines Italian-made in a factory \"Aman Siwa\". Beginning with the phase of manufacturing containers and sterilization, through the operations of processing of containers and packaging, and ending with the process of packaging and exit the product in its final form to our dearest clients, who we care about his safety and health by the production of high-tech machine at all stages ..Try it, you know it"
                           ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        if revealViewController() != nil{
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "ic_login_bg.jpg"))
        self.tableView.backgroundColor = UIColor.clear
        /*
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
        */
        //print((tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))! as UITableViewCell).textLabel?.text)
        //tableView.reloadData()
    }
   
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return aboutArray.count + 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as! AboutUsTableViewCell

        switch indexPath.row {
        case 0:
            cell.aboutUsLabel.text = " \n" + aboutArray[0]
            break
    
        case 1:
            cell.aboutUsLabel.text = " "
            cell.aboutUsLabel.font = UIFont(name: cell.aboutUsLabel.font.fontName, size: 12)
            break
        case 2:
            cell.aboutUsLabel.text = aboutArray[1]
            cell.aboutUsLabel.textColor = UIColor.black
            break
        case 3:
            cell.aboutUsLabel.text = " \n "
            break
            
        case 4:
            cell.aboutUsLabel.text = aboutArray[2]
            break
        case 5:
            cell.aboutUsLabel.text = " "
            cell.aboutUsLabel.font = UIFont(name: cell.aboutUsLabel.font.fontName, size: 12)

            break
        case 6:
            cell.aboutUsLabel.text = aboutArray[3]
            cell.aboutUsLabel.textColor = UIColor.black
            break
            
        default:
            break
        }
        
        return cell
    }

    
}
