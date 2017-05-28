//
//  ViewController.swift
//  mewook
//
//  Created by Бекболат Куанышев on 09.03.17.
//  Copyright © 2017 Bekbolat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var z : String
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var list = [structerOfList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = CAGradientLayer().backgroundGradientColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.sectionHeaderHeight = 50
        /*
        var childList = [childOfList]()
        
        //var data = [structerOfList].self
        
        let jsonFile = Bundle.main.url(forResource: "data", withExtension: "json")
        let jsonData = try? Data(contentsOf: jsonFile!)
        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData! as Data!) as? [String : Any],
                let blogs = json["data"] as? [[String: Any]] {
                for blog in blogs {
                    childList.append(childOfList(time_from: blog["time_from"] as! [String], type: blog["type"] as! [String], time_to: blog["time_to"] as! [String]))
                    list.append(structerOfList(mainText: blog["when_date"] as! String, dayOfWeek: blog["day_of_week"] as! String, eachRow: childList))
                }
                
            }
        } catch {
            print ("error : \(error)")
        }
        */
        
        var childList = [childOfList]()
        childList.append(childOfList(time_from: "8:00", type: "Вызов врача", time_to: "9:00"))
        childList.append(childOfList(time_from: "9:00", type: "Вызов врача", time_to: "10:00"))
        childList.append(childOfList(time_from: "10:00", type: "Вызов врача", time_to: "11:00"))
        list.append(structerOfList(mainText: "16 Март", dayOfWeek:"Понедельник", eachRow: childList))
        
        childList.append(childOfList(time_from: "10:00", type: "Вызов врача", time_to: "11:00"))
        list.append(structerOfList(mainText: "17 Март", dayOfWeek:"Вторник"))
        childList.append(childOfList(time_from: "8:00", type: "Вызов врача", time_to: "9:00"))
        list.append(structerOfList(mainText: "16 Март",dayOfWeek:"Среда", eachRow: childList))
    }


    func espandable (sender:UITapGestureRecognizer) {
        let section = sender.view!.tag
        list[section].selected = !list[section].selected
        tableView.reloadData()
    }
}
extension CAGradientLayer {
    
    func backgroundGradientColor() -> CAGradientLayer {
        let topColor = UIColor(red: (88.0/255.0), green: (150.0/255.0), blue:(192.0/255.0), alpha: 0.15)
        let bottomColor = UIColor(red: (97.0/255.0), green: (31.0/255.0), blue:(163.0/255.0), alpha: 0.15)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        return gradientLayer
        
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let each = list[section].selected
        if each {
            if list[section].eachRow == nil {
                return 1
            }
            else{
                return list[section].eachRow!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let each = list[indexPath.section]
        if each.eachRow == nil {
            let no = tableView.dequeueReusableCell(withIdentifier: "no", for: indexPath)
            no.detailTextLabel?.text = "Заявок нет"
            no.detailTextLabel?.font = UIFont(name: "Rubic Light", size: 16.0)
            return no
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dynamicCell
            cell.startLabel.text = each.eachRow![indexPath.row].time_from
            cell.infoLabel.text = each.eachRow![indexPath.row].type
            cell.finishLabel.text = each.eachRow![indexPath.row].time_to
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let each = list[indexPath.section]
        if each.eachRow == nil {
            return 50
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UITableViewHeaderFooterView()
        
        v.backgroundView?.backgroundColor = UIColor.clear
        v.backgroundColor = UIColor.clear
        
        let insideView = UIView()

        insideView.backgroundColor = UIColor.clear
        insideView.frame = v.bounds
        insideView.layer.cornerRadius = 6
        insideView.clipsToBounds = true
        insideView.layer.borderColor = UIColor.init(red: 78.0/255.0, green: 22.0/255.0, blue: 134.0/255.0, alpha: 1.0).cgColor
        insideView.layer.borderWidth = 1
        /*
        insideView.layer.shadowOffset = CGSize(width: 0, height: 3)
        insideView.layer.shadowColor = UIColor.red.cgColor
        insideView.layer.shadowOpacity = 0.23
        insideView.layer.shadowRadius = 4
        */
        
        v.backgroundView = insideView
        v.tag = section
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(espandable))
        v.addGestureRecognizer(tapGesture)
        
        let leftLabel = UILabel()
        leftLabel.font = UIFont(name: "Rubic Light", size: 16.0)
        leftLabel.textColor = UIColor.init(red: 78.0/255.0, green: 22.0/255.0, blue: 134.0/255.0, alpha: 1.0)
        insideView.addSubview(leftLabel)
        constrain(leftLabel) { (leftLabel) in
            leftLabel.leading == leftLabel.superview!.superview!.leading + 15
            leftLabel.centerY == leftLabel.superview!.superview!.centerY
        }
        
        let rightLabel = UILabel()
        rightLabel.font = UIFont(name: "Rubic Light", size: 16.0)
        rightLabel.textColor = UIColor.init(red: 78.0/255.0, green: 22.0/255.0, blue: 134.0/255.0, alpha: 1.0)
        insideView.addSubview(rightLabel)
        constrain(rightLabel) { (rightLabel) in
            rightLabel.trailing == rightLabel.superview!.superview!.trailing - 15
            rightLabel.centerY == rightLabel.superview!.superview!.centerY
        }
        
        let each = list[section]
        let string = each.mainText
        if each.dayOfWeek == "Понедельник" {
            let boldText  = " (\(each.dayOfWeek))"
            let attributedString = NSMutableAttributedString(string : string)
            let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string : boldText, attributes : attrs)
            attributedString.append(boldString)
            leftLabel.attributedText = attributedString
        } else {
            leftLabel.text = each.mainText + " (\(each.dayOfWeek))"
        }
        if each.eachRow == nil {
            rightLabel.text = "0"
        } else {
            rightLabel.text = "\(each.eachRow!.count)"
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}








