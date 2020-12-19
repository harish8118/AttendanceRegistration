//
//  loginVC.h
//  studentRegistery
//
//  Created by macmini on 1/24/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface loginVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *facultyTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UILabel *facultyErr;
@property (weak, nonatomic) IBOutlet UILabel *passwordErr;
@property (weak, nonatomic) IBOutlet UIButton *submitBttn;

- (IBAction)submitAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
