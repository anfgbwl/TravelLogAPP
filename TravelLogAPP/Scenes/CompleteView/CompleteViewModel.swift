//
//  CompleteViewModel.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import Foundation
import UIKit

class CompleteViewModel {
    private let completeView = CompleteView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var completedList: [Task]?
    var tableViewReloadHandler: (() -> Void)?

    func fetchCompletedBucketList() {
        let request = Task.fetchRequest()

        let pred = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.predicate = pred

        do {
            completedList = try context.fetch(request)
            tableViewReloadHandler?()
        } catch {
            print("🚨 Error: Fetch Task")
        }
    }
}
