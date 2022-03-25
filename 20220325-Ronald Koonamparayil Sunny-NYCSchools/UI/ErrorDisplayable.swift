//
//  ErrorDisplayable.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//
//

import UIKit

protocol ErrorDisplayable {
    func handleError(_ error: Error)
}

extension ErrorDisplayable where Self: UIViewController {
    func handleError(_ error: Error) {
        if let err = error as? URLError, err.code == .notConnectedToInternet {
            let alert = UIAlertController(title: "No internet connection", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(action)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
    }
}
