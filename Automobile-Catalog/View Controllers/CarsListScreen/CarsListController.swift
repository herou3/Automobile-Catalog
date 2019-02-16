//
//  CarsListController.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import UIKit
import SnapKit

class CarsListController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: CarsListViewModelProtocol?
    private let carCellReuseIdentifier = "cellId"
    private let tableView = UITableView()
    
    // MARK: - Init / Deinit
    init(viewModel: CarsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .darkslategray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Rules
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTablleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Configure car list
    private func configureTablleView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
        }
        tableView.backgroundColor = UIColor.lightslategray
        tableView.register(CarTableCell.self,
                           forCellReuseIdentifier: carCellReuseIdentifier)
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Internal actions
    @objc func addNewCarAction(_ sender: UIBarButtonItem) {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.showNewCarViewController()
    }
    
    func barButtonItem(buttonType: ItemButtonType) -> UIBarButtonItem {
        switch buttonType {
        case .add:
            return UIBarButtonItem(barButtonSystemItem: .add,
                                   target: self,
                                   action: #selector(addNewCarAction(_:)))
        default:
            return UIBarButtonItem()
        }
    }
}

// MARK: - UITableView DataSource
extension CarsListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: carCellReuseIdentifier,
                                                       for: indexPath)
            as? CarTableCell else { return UITableViewCell(style: .default,
                                                            reuseIdentifier: carCellReuseIdentifier) }
        guard let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath) else { return cell }
        cell.updateDataForCell(with: cellViewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constant.heightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.selectRow(atIndexPath: indexPath)
    }
}
