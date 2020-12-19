//
//  periodVC.h
//  studentRegistery
//
//  Created by macmini on 1/5/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface periodVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *profName;
@property (strong, nonatomic) IBOutlet UILabel *sbjctName;
@property (strong, nonatomic) IBOutlet UICollectionView *periodClctnVW;
@property (strong, nonatomic) IBOutlet UIButton *nextBttn;



- (IBAction)nextAction:(UIButton *)sender;



@end
