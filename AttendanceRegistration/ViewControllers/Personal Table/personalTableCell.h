//
//  personalTableCell.h
//  studentRegistery
//
//  Created by macmini on 2/8/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface personalTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *settingSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
