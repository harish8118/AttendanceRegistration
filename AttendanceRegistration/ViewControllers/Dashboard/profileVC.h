//
//  profileVC.h
//  AttendanceRegistration
//
//  Created by macmini on 9/4/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M13ProgressViewStripedBar.h"
#import "M13ProgressViewBar.h"
#import "AppDelegate.h"
#import "PECropViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface profileVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate, PECropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *prflpic;
//@property (weak, nonatomic) IBOutlet M13ProgressViewStripedBar *totalBar;
//@property (weak, nonatomic) IBOutlet M13ProgressViewStripedBar *attendBar;
//@property (weak, nonatomic) IBOutlet M13ProgressViewStripedBar *failedBar;


@property (weak, nonatomic) IBOutlet M13ProgressViewBar *totalBar;
@property (weak, nonatomic) IBOutlet M13ProgressViewBar *attendBar;
@property (weak, nonatomic) IBOutlet M13ProgressViewBar *absentBar;

- (IBAction)photoAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
