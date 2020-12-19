//
//  editAttendanceVC.h
//  studentRegistery
//
//  Created by macmini on 2/4/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "periodCell.h"
#import "prevusHeaderView.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"

NS_ASSUME_NONNULL_BEGIN

@interface editAttendanceVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *attendanceVW;

- (IBAction)homeAct:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END
