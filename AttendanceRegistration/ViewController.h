//
//  ViewController.h
//  studentRegistery
//
//  Created by macmini on 1/5/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"

@interface ViewController : UIViewController<UITextFieldDelegate,BSKeyboardControlsDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *profName;
@property (strong, nonatomic) IBOutlet UILabel *sbjctName;
@property (strong, nonatomic) IBOutlet UITextField *yearTF;
@property (strong, nonatomic) IBOutlet UITextField *branchTF;
@property (strong, nonatomic) IBOutlet UITextField *sectionTF;
@property (strong, nonatomic) IBOutlet UIButton *nextBttn;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (strong, nonatomic) IBOutlet UILabel *yearErr;
@property (strong, nonatomic) IBOutlet UILabel *brnchErr;
@property (strong, nonatomic) IBOutlet UILabel *sctnErr;
@property (strong, nonatomic) IBOutlet UIImageView *imgDrp;
@property (strong, nonatomic) IBOutlet UIButton *prvusList;


- (IBAction)nextAction:(UIButton *)sender;
- (IBAction)addGrpAct:(UIBarButtonItem *)sender;
- (IBAction)prevousAct:(UIButton *)sender;


@end

