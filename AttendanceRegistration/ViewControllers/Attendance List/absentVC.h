//
//  absentVC.h
//  studentRegistery
//
//  Created by macmini on 1/31/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prevusHeaderView.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"

NS_ASSUME_NONNULL_BEGIN

@interface absentVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *yearLbl;
@property (strong, nonatomic) IBOutlet UILabel *branchLbl;
@property (strong, nonatomic) IBOutlet UILabel *sctcnLbl;
@property (strong, nonatomic) IBOutlet UILabel *perdLbl;
@property (strong, nonatomic) IBOutlet UICollectionView *abscntVW;
@property (strong, nonatomic) IBOutlet UIButton *submitbttn;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sectnSeg;

@property (weak, nonatomic) IBOutlet UIImageView *absntImg;
@property (weak, nonatomic) IBOutlet UIImageView *prsntImg;
@property (weak, nonatomic) IBOutlet UIButton *absntBttn;
@property (weak, nonatomic) IBOutlet UIButton *presntbttn;


- (IBAction)submitAction:(UIButton *)sender;
- (IBAction)secSegmntAct:(id)sender;
- (IBAction)absentAct:(UIButton *)sender;
- (IBAction)presentAct:(UIButton *)sender;
- (IBAction)homeAct:(UIBarButtonItem *)sender;


@end

NS_ASSUME_NONNULL_END
