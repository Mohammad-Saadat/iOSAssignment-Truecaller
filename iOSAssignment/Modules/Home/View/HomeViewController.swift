//
//  HomeViewController.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayError(viewModel: Home.ErrorModel.ViewModel)
    func showLoading()
    func hideLoading(viewModel: Home.Loading.ViewModel)
    func displayData(viewModel: Home.Data.ViewModel)
}

class HomeViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("HomeViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: HomeFactory) {
        super.init(nibName: HomeViewController.nibName, bundle: nil)
        self.factory = factory
        factory.setup(viewController: self)
        HomeLogger.logInit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: HomeFactory!
    
    // MARK: Public
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - Outlets
    @IBOutlet var textViews: [UITextView]!
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var runButton: UIButton!
}

// MARK: - View Controller

// MARK: Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        factory.setup(viewController: self)
        interactor?.fetchData()
    }
}

// MARK: - Methods

// MARK: Private
private extension HomeViewController {
}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {
    func displayError(viewModel: Home.ErrorModel.ViewModel) {
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        presentMessege(title: "Error",
                       message: viewModel.error.localizedDescription,
                       additionalActions: action,
                       preferredStyle: .alert)
    }
    
    func showLoading() {
        runButton.showLoading()
        containerViews.forEach { $0.showLoading() }
    }
    
    func hideLoading(viewModel: Home.Loading.ViewModel) {
        guard let containerView = containerViews.first( where: {$0.tag == viewModel.tag }) else { return }
        containerView.hideLoading()
        if viewModel.hideLoadingOnButton { runButton.hideLoading() }
    }
    
    func displayData(viewModel: Home.Data.ViewModel) {
        let textView = textViews.first { $0.tag == viewModel.tag }
        textView?.text = viewModel.text
    }
}

// MARK: - Actions
extension HomeViewController {
    @IBAction func runButtonTapped(_ sender: Any) {
        interactor?.fetchData()
    }
}
