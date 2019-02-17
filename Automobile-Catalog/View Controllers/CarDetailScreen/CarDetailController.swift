//
//  CarDetailController.swift
//  Automobile-Catalog
//
//  Created by Pavel Kurilov on 15.02.2019.
//  Copyright © 2019 Pavel Kurilov. All rights reserved.
//

import SnapKit

class CarDetailController: UIViewController {
    
    // MARK: - Properties
    private var carDetailViewModel: CarDetailViewModel?
    private let cellInfoId = "cellInfoId"
    private let cellSubModelId = "cellSubModelId"
    private let cellDeleteId = "cellDeleteId"
    private let dataTableView: UITableView = UITableView()
    
    // MARK: - Init / deinit
    init(viewModel: CarDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.bindTo(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCarDetailController()
        self.bindToCarDetailViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.carDetailViewModel?.updateSubModel(subModel: carDetailViewModel?.subModelType)
        self.dataTableView.reloadData()
    }
    
    // MARK: - Configure car detail controller
    private func addDataTableView() {
        self.view.addSubview(dataTableView)
        dataTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(Constant.marginLeftAndRightValue)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
        }
        dataTableView.dataSource = self
        dataTableView.estimatedRowHeight = 50
        dataTableView.backgroundColor = .lightslategray
        dataTableView.tableFooterView = UIView()
        dataTableView.separatorStyle = .none
        dataTableView.register(CarDetailInfoCell.self, forCellReuseIdentifier: cellInfoId)
        dataTableView.register(CarDetailSubModelCell.self, forCellReuseIdentifier: cellSubModelId)
        dataTableView.register(CarDetailDeleteCell.self, forCellReuseIdentifier: cellDeleteId)
    }
    
    private func addKeyboardEvents() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    private func configureCarDetailController() {
        addDataTableView()
        addKeyboardEvents()
        hideKeyboardOutsideTap()
    }
    
    // MARK: - Connfigure gesture
    private func hideKeyboardOutsideTap() {
        let hideKeyboardGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                 action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    // MARK: - Bind to viewModel
    private func bindTo(_ viewModel: CarDetailViewModel) {
        self.carDetailViewModel = viewModel
        carDetailViewModel?.onDidRequestOfDeleteBlock = { [unowned self] in
            self.defaultAlert(with: "Delete",
                              message: "Do you want to delete this car?",
                              action: {
                                self.carDetailViewModel?.getRequestDelete()
            })
        }
    }
    
    // MARK: - Return barButtonItem
    func barButtonItem(buttonType: ItemButtonType) -> UIBarButtonItem {
        switch buttonType {
        case .back:
            return UIBarButtonItem(title: "<",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        default:
            return UIBarButtonItem(title: "Save",
                                   style: .done,
                                   target: self,
                                   action: #selector(saveObject))
        }
    }
    
    // MARK: - Methods tap on the return
    private func bindToCarDetailViewModel() {
        carDetailViewModel?.onDidRequestTapBlock = { [] value in
            let indexPathNextCell = IndexPath(row: value,
                                              section: 0)
            guard let carDetailInfoCell = self.dataTableView.cellForRow(at: indexPathNextCell) as? CarDetailInfoCell else {
                return
            }
            carDetailInfoCell.inputTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - Internal methods
    @objc private func saveObject() {
        carDetailViewModel?.saveCar()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        dataTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
    }
    
    @objc private func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        dataTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if #available(iOS 11.0, *) {
            dataTableView.contentInset = .zero
        } else {
            dataTableView.contentInset = UIEdgeInsets(top: Constant.insertFromSize, left: 0, bottom: 0, right: 0)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - get different cells
    func getDetailInfoCell(with viewModel: CarDetailTableCellViewModelProtocol,
                           and indexPath: IndexPath,
                           in tableView: UITableView) -> UITableViewCell {
        guard let detailInfoCellViewModel = viewModel as? CarDetailInfoCellViewModel else {
            return UITableViewCell()
        }
        guard let detailInfoCell = tableView.dequeueReusableCell(withIdentifier: cellInfoId, for: indexPath)
            as? CarDetailInfoCell else { return UITableViewCell(style: .default, reuseIdentifier: cellInfoId) }
        detailInfoCell.configure(with: detailInfoCellViewModel)
        detailInfoCell.changeTextBlock = { [] text in
            detailInfoCellViewModel.configure(with: text)
        }
        return detailInfoCell
    }
    
    func getSubModelCell(with viewModel: CarDetailTableCellViewModelProtocol,
                         and indexPath: IndexPath,
                         in tableView: UITableView) -> UITableViewCell {
        guard let subModelViewModel = viewModel as? CarDetailSubModelCellViewModel else {
            return UITableViewCell()
        }
        guard let detailSubModelCell = tableView.dequeueReusableCell(withIdentifier: cellSubModelId, for: indexPath)
            as? CarDetailSubModelCell else { return UITableViewCell(style: .default, reuseIdentifier: cellSubModelId) }
        detailSubModelCell.configure(with: subModelViewModel)
        detailSubModelCell.changeSubModelBlock = { [] in
            subModelViewModel.requestShowSubModel()
        }
        return detailSubModelCell
    }
    
    func getDeleteCell(with viewModel: CarDetailTableCellViewModelProtocol,
                       and indexPath: IndexPath,
                       in tableView: UITableView) -> UITableViewCell {
        guard let carDetailDeleteCell = tableView.dequeueReusableCell(withIdentifier: cellDeleteId, for: indexPath)
            as? CarDetailDeleteCell else { return UITableViewCell(style: .default, reuseIdentifier: cellDeleteId)}
        let deleteCellViewModel = viewModel as? CarDetailDeleteCellViewModel
        carDetailDeleteCell.deleteRequestBlock = { [] in
            deleteCellViewModel?.deleteAction()
        }
        return carDetailDeleteCell
    }
}

// MARK: - Extension table data source
extension CarDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carDetailViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailCellVM = carDetailViewModel?.detailTableCellViewModel(forIndexPath: indexPath) ??
            CarDetailInfoCellViewModel(value: carDetailViewModel?.makeCompany, cellType: .makeCompany)
        
        switch indexPath.row {
        case CellType.makeCompanyCell.rawValue, CellType.modelTypeCell.rawValue,
             CellType.yearProductionCell.rawValue, CellType.classTypeCell.rawValue:
            return self.getDetailInfoCell(with: detailCellVM, and: indexPath, in: tableView)
            
        case CellType.subModelCell.rawValue:
            return self.getSubModelCell(with: detailCellVM, and: indexPath, in: tableView)
            
        default:
            return self.getDeleteCell(with: detailCellVM, and: indexPath, in: tableView)
        }
    }
}
