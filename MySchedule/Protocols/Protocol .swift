//
//  Protocol .swift
//  MySchedule
//
//  Created by Maksim  on 09.06.2022.
//

import Foundation

protocol PressReadyTaskButtonProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}

protocol SwitchRepeatProtocol: AnyObject {
    func switchRepeat(value: Bool)
}
