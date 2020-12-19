//
//  settingsVC.h
//  studentRegistery
//
//  Created by macmini on 2/9/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface settingsVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *settingTable;

- (IBAction)absentAct:(UISwitch *)sender;
- (IBAction)presentAct:(UISwitch *)sender;

@end

NS_ASSUME_NONNULL_END
