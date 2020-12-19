//
//  previousEntryDetails.h
//  studentRegistery
//
//  Created by macmini on 1/18/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "periodCell.h"
#import "prevusHeaderView.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"

@interface previousEntryDetails : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *prvsVW1;
@property (strong, nonatomic) IBOutlet UICollectionView *prvsVW2;
@property (strong, nonatomic) IBOutlet UILabel *semLbl;
@property (strong, nonatomic) IBOutlet UILabel *brnchLbl;



- (IBAction)homeAct:(UIBarButtonItem *)sender;


@end
