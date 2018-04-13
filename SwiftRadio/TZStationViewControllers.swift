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

    var pull = {
        return UIRefreshControl()
    }()

    override func viewDidLoad() {

        // setup tableview
        tableview.backgroundColor = UIColor.black
        tableview.separatorStyle = .none

        makePull()
    }

    func makePull() {
        pull.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [.foregroundColor: UIColor.white])
        pull.backgroundColor = UIColor.black
        pull.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableview.addSubview(self.pull)
    }

    @objc
    func pullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pull.endRefreshing()
        }
    }

}

//MARK: - TableViewDataSource
extension TZStationViewControllers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TZStationCellIdentifier", for: indexPath)
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.2)
        return cell
    }

}
