//
//  TZStationViewControllers.swift
//  SwiftRadio
//
//  Created by tom on 2018/4/11.
//  Copyright © 2018年 matthewfecher.com. All rights reserved.
//

import UIKit

class TZStationViewControllers: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    var stations = [RadioStation]() {
        didSet {
            guard stations != oldValue else {
                return
            }
            tableview.reloadData()
        }
    }

    var pull = {
        return UIRefreshControl()
    }()

    override func viewDidLoad() {

        // setup tableview
        tableview.backgroundColor = UIColor.black
        tableview.separatorStyle = .none

        // getData
        getData()

        makePull()
    }

    func getData() {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true;

        TZDataManager.getDataFromJson { (data) in

            defer {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.pull.endRefreshing()
                })
            }

            guard let data = data, let json = try? JSONDecoder().decode([String: [RadioStation]].self, from: data), let result = json["station"] else {
                return
            }
            self.stations = result
        }
    }

    func makePull() {
        pull.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [.foregroundColor: UIColor.white])
        pull.backgroundColor = UIColor.black
        pull.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableview.addSubview(self.pull)
    }

    @objc
    func pullToRefresh() {
        getData()
    }

}

//MARK: - TableViewDataSource
extension TZStationViewControllers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TZStationCellIdentifier", for: indexPath) as! TZStationTableViewCell
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.2)
        cell.configurationCell(station: stations[indexPath.row])
        return cell
    }

}
