//
//  DateAddViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/21/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import EventKit


class DateAddViewController: UIViewController{
    //MARK: Private
    private func createEvent(for eventStore: EKEventStore, for startDate: Date){
        let calendar = eventStore.defaultCalendarForNewEvents
        
        
        let endDate = NSDate(timeInterval: 2*60*60, since: startDate)
        
        let event = EKEvent(eventStore: eventStore)
        event.calendar = calendar
        event.title = recipe.recipeName!
        event.startDate = startDate as Date
        event.endDate = endDate as Date
        
        
        do{
            try eventStore.save(event , span: .thisEvent)
            let alertController = UIAlertController(title: "Successfully Added to Calendar!", message: "Returning to Recipe now.",preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
        catch {
            let alertController = UIAlertController(title: "Couldnt Save to Calendar", message: "Please Try Again.",preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    //MARK: IBAction
    @IBAction func exportToCalendar(){
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized){
            eventStore.requestAccess(to: .event, completion: {granted, error in
                self.createEvent(for: self.eventStore, for: self.datePicker.date)
                
            })
        }
        else{
            createEvent(for: eventStore, for: datePicker.date)
            
        }
        
        if delegate != nil{
            delegate.didSubmitDate(self)
        }
    }
    
    
    //MARK: Delegate
    weak var delegate: DateAddViewControllerDelegate!
    
    //MARK: Properties
    let eventStore: EKEventStore = EKEventStore()
    var recipe: Recipe! = nil
    
    //MARK: IBOutlet
    @IBOutlet private weak var datePicker: UIDatePicker!
}
