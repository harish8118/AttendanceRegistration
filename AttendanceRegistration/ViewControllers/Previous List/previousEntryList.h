//
//  previousEntryList.h
//  studentRegistery
//
//  Created by macmini on 1/18/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDFDatePickerView.h"

@interface previousEntryList : UIViewController

@property (strong, nonatomic) NSCalendar *calendar;

- (IBAction)todayAct:(UIBarButtonItem *)sender;


@end
