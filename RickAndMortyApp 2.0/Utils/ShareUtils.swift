//
//  ShareUtils.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/4/23.
//

import UIKit

// Helps with sharing links
struct ShareUtils {
    
    
    /// Creates an activity view controller with a given url and presents it.
    /// - Parameters:
    ///   - navigationController: used to present the activity view contrller
    ///   - url: url to show 
    static func shareLink(navigationController: UINavigationController, link url: String) {
        // Setting description
        let firstActivityItem = "Check this out.."
        
        // Setting url
        let secondActivityItem : NSURL = NSURL(string: url)!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        navigationController.present(activityViewController, animated: true, completion: nil)
    }
}
