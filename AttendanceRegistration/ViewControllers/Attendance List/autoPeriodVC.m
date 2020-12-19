//
//  autoPeriodVC.m
//  studentRegistery
//
//  Created by macmini on 1/23/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "autoPeriodVC.h"
#import "periodCell.h"
#import "absentVC.h"
#import "previousEntryList.h"
#import "AppDelegate.h"
#import "RootVC.h"


@interface autoPeriodVC (){
    NSMutableArray * prdArr;
    AppDelegate *app;
    NSArray * timeArr,*yearArr,*brnchArr;
    NSString * facultyId;
    NSMutableArray * resultData;
}

@end

@implementation autoPeriodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * temp = [[NSUserDefaults standardUserDefaults]valueForKey:@"CollegeName"];
    NSArray * arr = [temp componentsSeparatedByString:@","];
    NSString * str = [arr objectAtIndex:0];
    NSLog(@"%@",str);
    
    self.navigationItem.title = str;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:80.0/255.0 green:117.0/255.0 blue:217.0/255.0 alpha:1.0]];
    
    prdArr = [NSMutableArray new];
    timeArr = [NSArray new];
    yearArr = [NSArray new];
    brnchArr = [NSArray new];
    
    
    _profName.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"FacultyName"];
    //_subjName.text = [NSString stringWithFormat:@"Department: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Department"]] ;
    
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.subjName.text];
//    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(9, self.subjName.text.length-9)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(10, self.subjName.text.length-10)];
//    self.subjName.attributedText=attrString;
    
    NSDateFormatter * dateFrmt = [NSDateFormatter new];
    [dateFrmt setDateFormat:@"dd-MMM-YYYY,cccc"];
    self.dateLbl.text = [NSString stringWithFormat:@"Date:- %@",[dateFrmt stringFromDate:[NSDate date]]];
    NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:self.dateLbl.text];
    [attrString1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, self.dateLbl.text.length-6)];
    self.dateLbl.attributedText=attrString1;
    
    timeArr = @[@"09:00 AM - 10:00 AM",@"10:00 AM - 11:00 AM ",@"11:00 AM - 12:00 PM",@"12:00 PM  -1:00 PM",@"2:00 PM - 3:00 PM",@"3:00 PM - 4:00 PM"];
    yearArr = @[@"I SEM",@"II SEM",@"III SEM",@"IV SEM",@"V SEM",@"VI SEM",@"VII SEM",@"VIII SEM"];
    brnchArr = @[@"IT",@"CSE",@"ECE",@"EEE",@"MECH",@"Dept G1"];
    
    _nextBttn.layer.cornerRadius = _nextBttn.frame.size.height/8;
    _nextBttn.layer.masksToBounds = YES;
    _nextBttn.layer.borderWidth = 1;
    
    _prevsBttn.layer.cornerRadius = _prevsBttn.frame.size.height/8;
    _prevsBttn.layer.masksToBounds = YES;
    _prevsBttn.layer.borderWidth = 1;
    
    
    
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    resultData = [NSMutableArray new];
    facultyId = [[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"];
    NSDateFormatter * dateFrmt = [NSDateFormatter new];
    [dateFrmt setDateFormat:@"dd/MM/YYYY"];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@&Date=%@",getFacultySchedule,facultyId,[dateFrmt stringFromDate:[NSDate date]]];
    
    NSLog(@"Req:%@",req);
    
    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSMutableArray*rsult = (NSMutableArray* )responseObject;
        NSLog(@"Faculty Data:%@",rsult);
        
        if (rsult.count>0) {
            NSDateFormatter * dateFrmt = [NSDateFormatter new];
            [dateFrmt setDateFormat:@"cccc"];
            NSString * today = [dateFrmt stringFromDate:[NSDate date]];
            NSLog(@"Today is:%@",today);
            
            for (int i=0; i<rsult.count; i++) {
                if([today isEqualToString:[[rsult objectAtIndex:i]objectForKey:@"day"]]){
                    [self->resultData addObject:[rsult objectAtIndex:i]];
                    [self->prdArr addObject:[NSString stringWithFormat:@"0"]];
                    
                }
            }
            
            [self.periodVW reloadData];
        }else{
            self.schedleAlrt.hidden = NO;
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        [self checkForNetwork];
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self->resultData.count>0) {
        self.schedleAlrt.hidden = YES;
        return  self->resultData.count;
    }else{
        self.schedleAlrt.hidden = NO;
        return 0;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * prd = [UICollectionViewCell new];
    
    NSString * stat = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"attandenceTakenStatus"]];
//    periodGrey
    
    if ([stat isEqualToString:@"1"]) {
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"periodGrey" forIndexPath:indexPath];
        vcl.prdName.text = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        vcl.layer.cornerRadius = vcl.frame.size.height/8;
        vcl.layer.masksToBounds = YES;
        vcl.layer.borderWidth = 2;
        prd = vcl;
        
    }else if ([[prdArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"period3" forIndexPath:indexPath];
        vcl.prdName.text = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        vcl.layer.cornerRadius = vcl.frame.size.height/8;
        vcl.layer.masksToBounds = YES;
        vcl.layer.borderWidth = 2;
        prd = vcl;
        
    }else{
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"period4" forIndexPath:indexPath];
        vcl.prdName.text = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        vcl.layer.cornerRadius = vcl.frame.size.height/8;
        vcl.layer.masksToBounds = YES;
        vcl.layer.borderWidth = 2;
        prd = vcl;
        
    }
    
    return prd;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * stat = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"attandenceTakenStatus"]];
    //    periodGrey
    
    if ([stat isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"] forKey:@"editRowID"];
        editAttendanceVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"editAttendanceVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([[prdArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        
        
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"hh a"];
        //[dateFrmt setDateFormat:@"hh:mm a"];
        
        NSString * str = [dateFrmt stringFromDate:[NSDate date]];
        NSLog(@"Present time:%@",str);
        NSDate * prsntTime = [dateFrmt dateFromString:str];
        NSLog(@"Present time:%@",prsntTime);
        
        NSString * timr = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
        NSArray* arr = [timr componentsSeparatedByString:@"-"];
        timr = [arr objectAtIndex:0];
        NSLog(@"Selected time:%@",timr);
        
        NSDate * slctTime = [dateFrmt dateFromString:timr];
        NSLog(@"Selected time%@",slctTime);
        
        NSComparisonResult result;
    
        //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
        
        result = [prsntTime compare:slctTime];
       
        
        if(result==NSOrderedSame){
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"rollName"] forKey:@"year"];
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"programName"] forKey:@"branch"];
            //            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"DepName"] forKey:@"branch"];
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"] forKey:@"time"];
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"] forKey:@"TRowid"];
            
            for (int i=0; i<prdArr.count; i++) {
                if (i==indexPath.row) {
                    
                    [prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
                    
                }else{
                    [prdArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
                    
                }
            }
            [self.periodVW reloadData];
            
            absentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"absentVC"];
            [self.navigationController pushViewController:vc animated:YES];
    
            
        }else if(result==NSOrderedAscending){
            UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are you sure to take up class at early than schedule time." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"rollName"] forKey:@"year"];
                [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"programName"] forKey:@"branch"];
                //            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"DepName"] forKey:@"branch"];
                [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"] forKey:@"time"];
                [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"] forKey:@"TRowid"];
                
                for (int i=0; i<self->prdArr.count; i++) {
                    if (i==indexPath.row) {
                        [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"] forKey:@"time"];
                        [self->prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
                        
                    }else{
                        [self->prdArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
                        
                    }
                }
                [self.periodVW reloadData];
                absentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"absentVC"];
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            UIAlertAction * no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];
            [alrt addAction:no];
            [alrt addAction:yes];
            [self presentViewController:alrt animated:YES completion:nil];
            
        }else if(result==NSOrderedDescending){
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"rollName"] forKey:@"year"];
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"programName"] forKey:@"branch"];
//            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"DepName"] forKey:@"branch"];
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"] forKey:@"time"];
            [[NSUserDefaults standardUserDefaults]setValue:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"] forKey:@"TRowid"];
            
            for (int i=0; i<prdArr.count; i++) {
                if (i==indexPath.row) {
                    
                    [prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
                    
                }else{
                    [prdArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
                    
                }
            }
            [self.periodVW reloadData];
            absentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"absentVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        [prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"0"]];
        [self.periodVW reloadData];
        
    }
}


- (IBAction)nextAct:(UIButton *)sender {
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

- (IBAction)previousAct:(UIButton *)sender {
    previousEntryList * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"previousEntryList"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)manualAct:(UIBarButtonItem *)sender {
    RootVC * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC"];
    self->app.window.rootViewController = rt;
    
}

- (void)checkForNetwork
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    if (myStatus==NotReachable) {
        UIAlertController*alert1=[UIAlertController alertControllerWithTitle:@"Network" message:@"There's no internet connection at all." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
    }else{
        UIAlertController*alert1=[UIAlertController alertControllerWithTitle:@"Message" message:@"There was a problem with server.So please try again after some time." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
}


@end
