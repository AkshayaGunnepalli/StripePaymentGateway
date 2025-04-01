//
//  StripePayment.swift
//  StripeSwiftPackage
//
//  Created by Akshaya Gunnepalli on 01/04/25.
//
/// https://github.com/stripe/stripe-ios - ios stripePackage Url

import UIKit
import Stripe
import StripePaymentSheet

class StripePayment: UIViewController {
    static let shared = StripePayment()
    var paymentSheet: PaymentSheet?
    private var callBack: ((_ error: CommonError?,_ result:PaymentSheetResult?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func initiate(from viewController: UIViewController?, callback: @escaping(_ error: Error?,PaymentSheetResult?) -> Void) {
        
        let publishableKey = "YOUR_PUBLISHABLE_KEY"
        let returnURl = "YOUR_URL"
        let clintSecrete = "YOUR_INTENT_CLIENT_SECRET"
        
        if publishableKey  != "" {
            STPAPIClient.shared.publishableKey = publishableKey
            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()
            configuration.returnURL = returnURl
            configuration.allowsDelayedPaymentMethods = true
            configuration.merchantDisplayName = "Demo"
            self.paymentSheet = PaymentSheet(paymentIntentClientSecret:clintSecrete, configuration: configuration)
            // MARK: Start the checkout process
            if let vc = viewController {
                paymentSheet?.present(from: vc) { paymentResult in
                    switch paymentResult {
                    case .completed:
                        callback(nil, paymentResult)
                    case .canceled:
                        callback(nil, nil)
                    case .failed(error: let error):
                        callback(error, nil)
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            print("Need PublishableKey")
        }
    }
}
struct CommonError: ErrorProtocol {
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
protocol  ErrorProtocol: LocalizedError  {
    var title: String? { get }
    var code: Int { get }
}
