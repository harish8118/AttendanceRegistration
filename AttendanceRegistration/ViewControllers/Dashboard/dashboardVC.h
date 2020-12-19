//
//  dashboardVC.h
//  studentRegistery
//
//  Created by macmini on 2/8/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "autoPeriodVC.h"
#import "absentVC.h"
#import "previousEntryList.h"
#import "schdleTableVW.h"
#import "personalTableVW.h"
#import "ALRadialMenu.h"
#import "settingsVC.h"
#import "AFNetworking.h"
#import "PECropViewController.h"
#import "searchStudentVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface dashboardVC : UIViewController<ALRadialMenuDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate, PECropViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *profName;
@property (weak, nonatomic) IBOutlet UILabel *deptName;
@property (weak, nonatomic) IBOutlet UIButton *menuBttn;


@property (strong, nonatomic) ALRadialMenu *radialMenu;
- (IBAction)menuAct:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
