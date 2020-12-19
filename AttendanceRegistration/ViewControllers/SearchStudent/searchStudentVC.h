//
//  searchStudentVC.h
//  studentRegistery
//
//  Created by macmini on 3/1/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"


NS_ASSUME_NONNULL_BEGIN

@interface searchStudentVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *hallTcktTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBttn;


@property (weak, nonatomic) IBOutlet UIView *searchRsltVW;
@property (weak, nonatomic) IBOutlet UILabel *hallTcktLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentName;
@property (weak, nonatomic) IBOutlet UITableView *searchRsltTbl;

- (IBAction)searchAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
