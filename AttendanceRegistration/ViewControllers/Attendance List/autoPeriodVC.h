//
//  autoPeriodVC.h
//  studentRegistery
//
//  Created by macmini on 1/23/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"
#import "editAttendanceVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface autoPeriodVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *profName;
@property (weak, nonatomic) IBOutlet UILabel *subjName;
@property (weak, nonatomic) IBOutlet UICollectionView *periodVW;
@property (weak, nonatomic) IBOutlet UIButton *nextBttn;
@property (weak, nonatomic) IBOutlet UIButton *prevsBttn;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *schedleAlrt;

- (IBAction)nextAct:(UIButton *)sender;
- (IBAction)previousAct:(UIButton *)sender;
- (IBAction)manualAct:(UIBarButtonItem *)sender;


@end

NS_ASSUME_NONNULL_END
