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
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    fileprivate var cities: [String] = ["Seoul", "London", "Chicago"]
    fileprivate var data: [String: [String: String]] = [
        "Seoul": [
            "lat": "37.532600",
            "lon": "127.024612"
        ],
        "London": [
            "lat": "51.509865",
            "lon": "-0.118092"
        ],
        "Chicago": [
            "lat": "41.881832",
            "lon": "-87.623177"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setViewLayout()
        
        let london = self.cities[1]
        ApiClient.default.getFiveDaysWeather(country: london) {
            
        }
    }
}



// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherListCell = tableView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.cities[section]
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

