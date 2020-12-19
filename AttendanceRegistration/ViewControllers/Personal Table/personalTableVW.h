//
//  personalTableVW.h
//  studentRegistery
//
//  Created by macmini on 2/8/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"


NS_ASSUME_NONNULL_BEGIN

@interface personalTableVW : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *personalTbl;

@end

NS_ASSUME_NONNULL_END
