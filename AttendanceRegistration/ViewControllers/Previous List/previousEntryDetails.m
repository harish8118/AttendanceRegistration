//
//  previousEntryDetails.m
//  studentRegistery
//
//  Created by macmini on 1/18/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "previousEntryDetails.h"
#import "RootVC2.h"
#import "AppDelegate.h"


@interface previousEntryDetails (){
    AppDelegate *app;
    NSMutableArray * prdArr;
    NSArray * timeArr;
    NSString * facultyId,*trowId,*daySlct;
    NSMutableArray * resultData,* attendanceData;
    NSMutableArray * abscntArr;
    NSArray * yearArr,*brnchArr;
}

@end

@implementation previousEntryDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timeArr = [NSArray new];
    self->yearArr = [NSMutableArray new];
    self->brnchArr = [NSMutableArray new];
    
    [self.navigationController setTitle:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"daySelect"]]];
    
    timeArr = @[@"9:00 AM-10:00 AM",@"10:00 AM-11:00 AM",@"11:00 AM-12:00 PM",@"12:00 PM-1:00 PM",@"2:00 PM-3:00 PM",@"3:00 PM-4:00 PM"];
    yearArr = @[@"I SEM",@"II SEM",@"III SEM",@"IV SEM",@"V SEM",@"VI SEM",@"VII SEM",@"VIII SEM"];
    brnchArr = @[@"IT",@"CSE",@"ECE",@"EEE",@"MECH",@"Dept G1"];
    
    _semLbl.layer.cornerRadius = _semLbl.frame.size.height/8;
    _semLbl.layer.masksToBounds = YES;
    _semLbl.layer.borderWidth = 1;
    
    _brnchLbl.layer.cornerRadius = _brnchLbl.frame.size.height/8;
    _brnchLbl.layer.masksToBounds = YES;
    _brnchLbl.layer.borderWidth = 1;
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    [self.prvsVW1 reloadData];
//    [self.prvsVW2 reloadData];
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    prdArr = [NSMutableArray new];
//    abscntArr = [NSMutableArray new];
//
//    for (int i=0; i<6; i++) {
//        if (i==0) {
//            [prdArr addObject:[NSString stringWithFormat:@"1"]];
//        }else{
//        [prdArr addObject:[NSString stringWithFormat:@"0"]];
//        }
//    }
//
//    for (int i=0; i<60; i++) {
//        if (i==14 || i==58 || i==36) {
//            [abscntArr addObject:[NSString stringWithFormat:@"1"]];
//        }else{
//        [abscntArr addObject:[NSString stringWithFormat:@"0"]];
//        }
//    }
//
//}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    resultData = [NSMutableArray new];
    prdArr = [NSMutableArray new];
    facultyId = [[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"];
    
    NSDateFormatter * dateFrmt = [NSDateFormatter new];
    [dateFrmt setDateFormat:@"dd/MM/YYYY"];
    NSDate *slctdat = [[NSUserDefaults standardUserDefaults]valueForKey:@"daySelect"];
    daySlct = [dateFrmt stringFromDate:slctdat];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@&Date=%@",getFacultySchedule,facultyId,daySlct];
    
    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSMutableArray*rsult = (NSMutableArray* )responseObject;
        NSLog(@"Faculty Data:%@",rsult);
        
        if (rsult.count>0) {
            NSDateFormatter * dateFrmt2 = [NSDateFormatter new];
            [dateFrmt2 setDateFormat:@"cccc"];
            NSString * today = [dateFrmt2 stringFromDate:slctdat];
            NSLog(@"Today is:%@",today);
            
            for (int i=0; i<rsult.count; i++) {
                if([today isEqualToString:[[rsult objectAtIndex:i]objectForKey:@"day"]]){
                    [self->resultData addObject:[rsult objectAtIndex:i]];
                    [self->prdArr addObject:[NSString stringWithFormat:@"0"]];
                    
                }
            }
            
            [self.prvsVW1 reloadData];
        }else{
           // self.schedleAlrt.hidden = NO;
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        [self checkForNetwork];
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView==self.prvsVW1){
        if (self->resultData.count>0) {
            return self->resultData.count;
        }
        return 0;
        
    }else if (collectionView==self.prvsVW2) {
        if (self->attendanceData.count>0) {
            return self->attendanceData.count;
        }else{
            return 0;
        }
        
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView==self.prvsVW1){
        return 1;
        
    }else if (collectionView==self.prvsVW2) {
        return 1;
    }
    
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * prd = [UICollectionViewCell new];

     if (collectionView==self.prvsVW1){
         NSString * stat = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"attandenceTakenStatus"]];
         
         if ([stat isEqualToString:@"0"]) {
             periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previousGrey" forIndexPath:indexPath];
             vcl.prdName.text = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
             
             vcl.layer.cornerRadius = vcl.frame.size.height/8;
             vcl.layer.masksToBounds = YES;
             vcl.layer.borderWidth = 2;
             prd = vcl;
             
         }else if ([[prdArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previous2" forIndexPath:indexPath];
            vcl.prdName.text = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
            
            vcl.layer.cornerRadius = vcl.frame.size.height/8;
            vcl.layer.masksToBounds = YES;
            vcl.layer.borderWidth = 2;
            prd = vcl;
            
        }else{
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previous" forIndexPath:indexPath];
            vcl.prdName.text = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"time"]];
            
            vcl.layer.cornerRadius = vcl.frame.size.height/8;
            vcl.layer.masksToBounds = YES;
            vcl.layer.borderWidth = 2;
            prd = vcl;
            
        }
        
    }else if (collectionView==self.prvsVW2) {
        NSString * stat = [NSString stringWithFormat:@"%@",[[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"status"]];
        
        if ([stat isEqualToString:@"1"]) {
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previous3" forIndexPath:indexPath];
            
            NSString * str = [[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"htno"];
            str = [str stringByReplacingCharactersInRange:NSMakeRange(0, str.length-3) withString:@""];
            str = [NSString stringWithFormat:@"%@-%@",str,[[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"year"]];
            NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:str];
            [attrString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length-3, 3)];
            
            vcl.abscntNmbr.attributedText = attrString1;
            
            
            vcl.layer.cornerRadius = vcl.frame.size.height/8;
            vcl.layer.masksToBounds = YES;
            vcl.layer.borderWidth = 2;
            vcl.layer.borderColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0].CGColor;
            prd = vcl;
            
        }else{
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previous4" forIndexPath:indexPath];
            
            NSString * str = [[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"htno"];
            str = [str stringByReplacingCharactersInRange:NSMakeRange(0, str.length-3) withString:@""];
            str = [NSString stringWithFormat:@"%@-%@",str,[[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"year"]];
            NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:str];
            [attrString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length-3, 3)];
            
            vcl.abscntNmbr.attributedText = attrString1;
            
            vcl.layer.cornerRadius = vcl.frame.size.height/8;
            vcl.layer.masksToBounds = YES;
            vcl.layer.borderColor = [UIColor redColor].CGColor;
            vcl.layer.borderWidth = 2;
            prd = vcl;
        }
        
    }
    
    return prd;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    attendanceData = [NSMutableArray new];
    abscntArr = [NSMutableArray new];
    
    trowId = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"]];
    
    for (int i=0; i<self->prdArr.count; i++) {
        if (i==indexPath.row) {
            
            [self->prdArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
            
        }else{
            [self->prdArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
            
        }
    }
    
    [self.prvsVW1 reloadData];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];

    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@&Date=%@",getPrevsAttendanceData,trowId,daySlct];

    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        self->attendanceData = (NSMutableArray* )responseObject;
        NSLog(@"Schedule Data:%@",self->attendanceData);
        
        if (self->attendanceData.count>0) {
            self.semLbl.text  = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:0]objectForKey:@"rollName"]];
            
            self.brnchLbl.text  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Department"]];
            
            
            self.semLbl.hidden= NO;
            self.brnchLbl.hidden = NO;
            self.prvsVW2.hidden = NO;
            
            for (int i=0; i<self->attendanceData.count; i++) {
                NSString * stat = [NSString stringWithFormat:@"%@",[[self->attendanceData objectAtIndex:i]objectForKey:@"status"]];
                
                if ([stat isEqualToString:@"1"]) {
                    [self->abscntArr addObject:[NSString stringWithFormat:@"1"]];
                }else{
                    [self->abscntArr addObject:[NSString stringWithFormat:@"0"]];
                }
            }
            [self.prvsVW2 reloadData];
            [SVProgressHUD dismiss];
        }
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        [self checkForNetwork];
    }];
        
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (collectionView==self.prvsVW2) {
        if (kind == UICollectionElementKindSectionHeader) {
            prevusHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"prevusHeaderView" forIndexPath:indexPath];
            if (indexPath.section==0) {
                headerView.headerLbl.text = [[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"subjectName"];
                NSInteger occurrences = [[abscntArr indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {return [obj isEqual:@"0"];}] count];
                
                headerView.presentLBL.text = [NSString stringWithFormat:@"Present: %ld",self->abscntArr.count-(long)occurrences];
                headerView.absentLbl.text = [NSString stringWithFormat:@"Absent: %ld",(long)occurrences];
                
            }else{
                headerView.headerLbl.text = [[self->attendanceData objectAtIndex:indexPath.row]objectForKey:@"subjectName"];
            }
            
            headerView.layer.cornerRadius = headerView.frame.size.height/8;
            headerView.layer.masksToBounds = YES;
            headerView.layer.borderWidth = 2;
            
            reusableview = headerView;
        }
    }
    
    return reusableview;
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

- (IBAction)homeAct:(UIBarButtonItem *)sender {
    RootVC2 * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC2"];
    self->app.window.rootViewController = rt;
}

@end

