//
//  prevusHeaderView.h
//  studentRegistery
//
//  Created by macmini on 1/22/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface prevusHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *headerLbl;
@property (weak, nonatomic) IBOutlet UILabel *presentLBL;
@property (weak, nonatomic) IBOutlet UILabel *absentLbl;

@end

NS_ASSUME_NONNULL_END
