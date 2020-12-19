//
//  periodVC.m
//  studentRegistery
//
//  Created by macmini on 1/5/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "periodVC.h"
#import "periodCell.h"
#import "absentVC.h"

@interface periodVC (){
    NSMutableArray * prdArr;
    NSArray * timeArr;
}

@end

@implementation periodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    prdArr = [NSMutableArray new];
    timeArr = [NSArray new];
    
    timeArr = @[@"9:00-10:00 AM",@"10:00-11:00 AM",@"11:00-12:00 AM",@"12:00-1:00 PM",@"2:00-3:00 PM",@"3:00-4:00 PM"];
    
    _nextBttn.layer.cornerRadius = _nextBttn.frame.size.height/8;
    _nextBttn.layer.masksToBounds = YES;
    _nextBttn.layer.borderWidth = 1;
    
    for (int i=0; i<6; i++) {
        [prdArr addObject:[NSString stringWithFormat:@"0"]];
    }
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * prd = [UICollectionViewCell new];
    
    if ([[prdArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"period" forIndexPath:indexPath];
        vcl.prdName.text = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:indexPath.row]];
    
        vcl.layer.cornerRadius = vcl.frame.size.height/8;
        vcl.layer.masksToBounds = YES;
        vcl.layer.borderWidth = 2;
        prd = vcl;
        
    }else{
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"period2" forIndexPath:indexPath];
        vcl.prdName.text = [NSString stringWithFormat:@"%@",[timeArr objectAtIndex:indexPath.row]];
        
        vcl.layer.cornerRadius = vcl.frame.size.height/8;
        vcl.layer.masksToBounds = YES;
        vcl.layer.borderWidth = 2;
        prd = vcl;
        
    }
    
    return prd;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[prdArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        
        for (int i=0; i<prdArr.count; i++) {
            if (i==indexPath.row) {
                [[NSUserDefaults standardUserDefaults]setValue:[timeArr objectAtIndex:indexPath.row] forKey:@"time"];
                [prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
                
            }else{
                [prdArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
                
            }
        }
        [self.periodClctnVW reloadData];
        
    }else{
        [prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"0"]];
        [self.periodClctnVW reloadData];
        
    }
}

- (IBAction)nextAction:(UIButton *)sender {
    if ([prdArr containsObject:@"1"]) {
        absentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"absentVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please select class time to proceed." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alrt addAction:ok];
        [self presentViewController:alrt animated:YES completion:nil];
    }
    
    
}
@end
