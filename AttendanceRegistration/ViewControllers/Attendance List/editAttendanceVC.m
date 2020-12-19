//
//  editAttendanceVC.m
//  studentRegistery
//
//  Created by macmini on 2/4/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "editAttendanceVC.h"
#import "RootVC2.h"
#import "AppDelegate.h"

@interface editAttendanceVC (){
    
    AppDelegate *app;
    NSString * facultyId,*trowId,*daySlct;
    NSMutableArray * resultData;
    NSMutableArray * abscntArr;
    
}

@end

@implementation editAttendanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self getUpdateData];
    
}

-(void)getUpdateData{
    resultData = [NSMutableArray new];
    abscntArr = [NSMutableArray new];
    
    trowId = [[NSUserDefaults standardUserDefaults]valueForKey:@"editRowID"];
    
    NSDateFormatter * dateFrmt = [NSDateFormatter new];
    [dateFrmt setDateFormat:@"dd/MM/YYYY"];
    daySlct = [dateFrmt stringFromDate:[NSDate date]];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@&Date=%@",getPrevsAttendanceData,trowId,daySlct];
    
    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        self->resultData = (NSMutableArray* )responseObject;
        NSLog(@"Faculty Data:%@",self->resultData);
        
        if (self->resultData.count>0) {
            for (int i=0; i<self->resultData.count; i++) {
                NSString * stat = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:i]objectForKey:@"status"]];
                
                if ([stat isEqualToString:@"1"]) {
                    [self->abscntArr addObject:[NSString stringWithFormat:@"1"]];
                }else{
                    [self->abscntArr addObject:[NSString stringWithFormat:@"0"]];
                }
            }
            [self.attendanceVW reloadData];
            
            [SVProgressHUD dismiss];
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
        if (self->resultData.count>0) {
            return self->resultData.count;
        }
        return 0;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * prd = [UICollectionViewCell new];
    
        NSString * stat = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"status"]];
        
        if ([stat isEqualToString:@"1"]) {
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previous3" forIndexPath:indexPath];
            
            NSString * str = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htno"];
            str = [str stringByReplacingCharactersInRange:NSMakeRange(0, str.length-3) withString:@""];
            str = [NSString stringWithFormat:@"%@-%@",str,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"year"]];
            NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:str];
            [attrString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length-3, 3)];
            
            vcl.abscntNmbr.attributedText = attrString1;
            
            vcl.layer.cornerRadius = vcl.frame.size.height/8;
            vcl.layer.masksToBounds = YES;
            vcl.layer.borderWidth = 2;
            prd = vcl;
            
        }else{
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"previous4" forIndexPath:indexPath];
            
            NSString * str = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htno"];
            str = [str stringByReplacingCharactersInRange:NSMakeRange(0, str.length-3) withString:@""];
            str = [NSString stringWithFormat:@"%@-%@",str,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"year"]];
            NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:str];
            [attrString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length-3, 3)];
            
            vcl.abscntNmbr.attributedText = attrString1;
            
            vcl.layer.cornerRadius = vcl.frame.size.height/8;
            vcl.layer.masksToBounds = YES;
            vcl.layer.borderWidth = 2;
            prd = vcl;
        }
    
    return prd;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    facultyId = [[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"];
    
    NSString * stat = [NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"status"]];
    
    if ([stat isEqualToString:@"1"]) {
        UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"CONFIRMATION" message:@"Are you sure to submit absent to the person." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
          [SVProgressHUD showWithStatus:@"Please Wait"];
          [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
          [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
          [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
          [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];

          AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
          [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
            NSString*req=[NSString stringWithFormat:@"%@%@&ARowid=%@&Status=0",editAttendance,self->facultyId,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"aRowid"]];

          [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {

              NSString*  result = (NSString *)responseObject;
              BOOL sucss = [result boolValue];

              if (sucss == YES) {
                  [SVProgressHUD dismiss];
         
                  [self getUpdateData];
         
              }else{
                  [SVProgressHUD dismiss];
              }
          } failure:^(NSURLSessionTask *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              [SVProgressHUD dismiss];
              [self checkForNetwork];
          }];
    
        }];
        UIAlertAction * cancl = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];
        [alrt addAction:cancl];
        [alrt addAction:ok];
        [self presentViewController:alrt animated:YES completion:nil];
        
    }else{
     
        UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"CONFIRMATION" message:@"Are you sure to submit present to the person." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        [SVProgressHUD showWithStatus:@"Please Wait"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
        
        AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
            NSString*req=[NSString stringWithFormat:@"%@%@&ARowid=%@&Status=1",editAttendance,self->facultyId,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"aRowid"]];
        
        [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSString*  result = (NSString *)responseObject;
            BOOL sucss = [result boolValue];
            
            if (sucss == YES) {
                [SVProgressHUD dismiss];
                
                [self getUpdateData];
                
            }else{
                [SVProgressHUD dismiss];
            }
            
            } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            [self checkForNetwork];
        }];
            
        }];
        UIAlertAction * cancl = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];
        [alrt addAction:cancl];
        [alrt addAction:ok];
        [self presentViewController:alrt animated:YES completion:nil];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
        if (kind == UICollectionElementKindSectionHeader) {
            prevusHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"prevusHeaderView" forIndexPath:indexPath];
            if (indexPath.section==0) {
                headerView.headerLbl.text = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"subjectName"];
                NSInteger occurrences = [[abscntArr indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {return [obj isEqual:@"0"];}] count];
                
                headerView.presentLBL.text = [NSString stringWithFormat:@"Present: %ld",self->abscntArr.count-(long)occurrences];
                headerView.absentLbl.text = [NSString stringWithFormat:@"Absent: %ld",(long)occurrences];
                
            }else{
                headerView.headerLbl.text = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"subjectName"];
            }
            
            headerView.layer.cornerRadius = headerView.frame.size.height/8;
            headerView.layer.masksToBounds = YES;
            headerView.layer.borderWidth = 2;
            
            reusableview = headerView;
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
