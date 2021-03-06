//
//  ViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/05/22.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    // TODO: Level 2 - Refactor this class!!
    // TODO: Level 4 - On all screens rename newViewController for the going to another screen methods
    // TODO: Level 4 - Think do we really need all of those params here? Just occupy a lot of space
    
    @IBOutlet weak var rentPriceHeaderLabel: UILabel!
    @IBOutlet weak var firstOptionRentLabel: UILabel!
    @IBOutlet weak var secondOptionRentLabel: UILabel!
    @IBOutlet weak var thirdOptionRentLabel: UILabel!
    @IBOutlet weak var firstOptionRentPriceLabel: UILabel!
    @IBOutlet weak var secondOptionRentPriceLabel: UILabel!
    @IBOutlet weak var thirdOptionRentPriceLabel: UILabel!
    @IBOutlet weak var buyPriceHeaderLabel: UILabel!
    @IBOutlet weak var firstOptionBuyLabel: UILabel!
    @IBOutlet weak var firstOptionBuyPriceLabel: UILabel!
    
    @IBOutlet weak var rentButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var checkLocationsButton: UIButton!
    @IBOutlet weak var informationButton: InformationButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfAppWasClosedDuringRentalMode()
    }
    
    private func checkIfAppWasClosedDuringRentalMode() {
        let informationAboutLastSession = GlobalDataStorage.shared.informationAboutLastSession
        if informationAboutLastSession?.hasRentStarted == true {
            openMapScreen()
        }
    }
    
    private func openMapScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mapMode = UmbrellaUtil.MapMode.rentalMode
        
        let userCredentials = GlobalDataStorage.shared.userCredentials
        let orderId = GlobalDataStorage.shared.informationAboutLastSession?.orderId
        // TODO: Level 3 - Think should we pass orderId and code or not? I think we don't need, but need to be checked
        let orderInformation = OrderInformation(userId: userCredentials?.userId, orderId: orderId, code: nil)
        newViewController.orderInformation = orderInformation
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    private func openPaymentScreen(_ operationType: UmbrellaUtil.OperationType) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PaymentScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentScreenViewController") as! PaymentScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.operationType = operationType
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func rentUmbrella(_ sender: Any) {
        openPaymentScreen(UmbrellaUtil.OperationType.rentUmbrella)
    }
    
    @IBAction func buyUmbrella(_ sender: Any) {
        openPaymentScreen(UmbrellaUtil.OperationType.buyUmbrella)
    }
    
    
    @IBAction func checkLocations(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mapMode = UmbrellaUtil.MapMode.locationsMode
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func initInterface() {
        // TODO: Level 4 -  Exctract all constant string to the separate file
        // TODO: Level 3 - Check if all versions of iPhone follow the design
        
        // MARK: Init labels
        
        rentPriceHeaderLabel.text = "Rental Rate:"
        firstOptionRentLabel.text = "Less than an hour"
        firstOptionRentPriceLabel.text = "50 rub"
        secondOptionRentLabel.text = "Less than a day"
        secondOptionRentPriceLabel.text = "100 rub"
        thirdOptionRentLabel.text = "More than a day"
        thirdOptionRentPriceLabel.text = "300 rub"
        buyPriceHeaderLabel.text = "Buy Rate:"
        firstOptionBuyLabel.text = "Buy an umbrella"
        firstOptionBuyPriceLabel.text = "300 rub"
        
        // MARK: Init buttons
        rentButton.setTitle("Rent an Umbrella", for: .normal)
        buyButton.setTitle("Buy an Umbrella", for: .normal)
        
        checkLocationsButton.setTitle("Check Locations on the Map", for: .normal)
    }

    @IBAction func openInformation(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "InformationScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InformationScreenViewController") as! InformationScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}

