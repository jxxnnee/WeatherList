//
//  ViewController.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/10.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    fileprivate var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(WeatherListCell.self)
        tableView.backgroundColor = .black
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setViewLayout()
    }
}



// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherListCell = tableView.dequeueReusableCell(for: indexPath)
        
        
        return cell
    }
}


// MARK: Layout
extension ViewController {
    fileprivate func setViewLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

