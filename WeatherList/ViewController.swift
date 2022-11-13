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
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    fileprivate var cities: [String] = ["Seoul", "London", "Chicago"]
    fileprivate var data: [String: [List]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let dispatchQueue = DispatchQueue(label: "io.WeatherList.ApiTask.bg")
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        
        for city in self.cities {
            dispatchQueue.async(group: group) {
                ApiClient.default.getFiveDaysWeather(country: city) { [weak self] res in
                    switch res {
                    case .success(let data):
                        print(city)
                        
                        /// 현재 부터 5일 후 까지
                        for value in 0 ... 5 {
                            
                            /// 현재 날짜에 더해서 몇일 후의 날짜를 가져온다.
                            let today = Date()
                            guard let date = Calendar.current.date(byAdding: .day, value: value, to: today) else { continue }
                            
                            /// 날씨 리스트에 해당 날짜의 첫번째 아이템을 가져온다.
                            /// 각 아이템이 세시간 단위이기 때문에 모든 아이템을 사용 할 필요가 없다.
                            guard let weather = data.list.first(where: { $0.date.toDate().day == date.day }) else { continue }
                            
                            /// Dictionary에 이미 해당 도시에 대한 List가 존재할 경우
                            /// 해당 List에 더해서 도시에 대한 List를 Update 해준다.
                            if let item = self?.data[city] {
                                var temp = item
                                temp.append(weather)
                                
                                self?.data[city] = temp
                            }
                            /// 해당 도시에 대한 List가 존재하지 않는 경우
                            /// 새로운 List를 만들어서 추가해준다.
                            else {
                                self?.data[city] = [weather]
                            }
                        }
                    case .failure(let err):
                        print("Error: ", err)
                    }
                    
                    semaphore.signal()
                }
                
                semaphore.wait()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.setViewLayout()
        }
    }
}



// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let city = self.cities[0]
        let count = self.data[city]?.count ?? 0
        
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherListCell = tableView.dequeueReusableCell(for: indexPath)
        
        let city = self.cities[indexPath.section]
        guard let itemList = self.data[city] else { return cell }
        let item = itemList[indexPath.row]
        let weather = item.weather[0]
        
        cell.today = item.date
        cell.icon = weather.icon
        cell.weather = weather.main
        cell.min = item.main.min
        cell.max = item.main.max
        
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

