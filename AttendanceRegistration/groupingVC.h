//
//  groupingVC.h
//  studentRegistery
//
//  Created by macmini on 1/7/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface groupingVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *sectnOptn;
@property (strong, nonatomic) IBOutlet UIImageView *dprtOptn;
@property (strong, nonatomic) IBOutlet UIView *sectnVW;
@property (strong, nonatomic) IBOutlet UITextField *secGrpNameTF;
@property (strong, nonatomic) IBOutlet UILabel *secGrpErr;
@property (strong, nonatomic) IBOutlet UITextField *secDprtTF;
@property (strong, nonatomic) IBOutlet UILabel *secDprtErr;
@property (strong, nonatomic) IBOutlet UITableView *secTbl;
@property (strong, nonatomic) IBOutlet UIButton *secGnrtBttn;
@property (strong, nonatomic) IBOutlet UILabel *secSctnLbl;


@property (strong, nonatomic) IBOutlet UIView *deprtVW;
@property (strong, nonatomic) IBOutlet UITextField *dprtGrpNameTF;
@property (strong, nonatomic) IBOutlet UILabel *dprtGrpErr;
@property (strong, nonatomic) IBOutlet UITableView *dprtDprtmntTbl;
@property (strong, nonatomic) IBOutlet UILabel *dprtDprtErr;
@property (strong, nonatomic) IBOutlet UITableView *dprtSecTbl;
@property (strong, nonatomic) IBOutlet UIButton *dprtGnrtBttn;
@property (strong, nonatomic) IBOutlet UILabel *dprtSectnErr;










- (IBAction)dprtGnrtGrpAct:(UIButton *)sender;
- (IBAction)secGenrtGrpAct:(UIButton *)sender;
- (IBAction)secOptnAct:(UIButton *)sender;
- (IBAction)deprtOptnAct:(UIButton *)sender;

@end
