//
//  SystemCalendarManager.swift
//  Odin-YMS
//
//  Created by zlm on 2017/4/14.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import UIKit
import EventKit
public class SystemCalendarManager: NSObject {
    static public let getInstance = SystemCalendarManager()
    //测试
    public func addToCalendarClicked() {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) {(granted, error) in

            do {
                if((error) != nil) {
                    //添加错误
                } else if(!granted) {
                    //无访问日历权限
                } else {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = "测试"
                    event.location = "厦门"
                    //起止时间
                    let formatter = mm_DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let startTime = formatter.date(from: "2017-04-20 20:00") ?? Date()
                    let endTime = formatter.date(from: "2017-04-20 21:00") ?? Date()
                    print("startTime:\(startTime)")
                    //                    event.allDay = true
                    event.startDate = startTime
                    event.endDate = endTime
                    //在事件前多少秒开始事件提醒
                    let alarm = EKAlarm()
                    alarm.relativeOffset = -60.0
                    event.addAlarm(alarm)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    let result:()? = try eventStore.save(event, span: .thisEvent)
                    print("result:\(String(describing: result))")
                    if(result != nil) {
                        DispatchQueue.main.async {
                            MMAlertNoButtonView.show("已成功添加到日历")
                        }

                    }
                }
            } catch {
                print("error")
            }
        }

    }

}
