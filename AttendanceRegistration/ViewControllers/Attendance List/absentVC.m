//
//  absentVC.m
//  studentRegistery
//
//  Created by macmini on 1/31/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "absentVC.h"
#import "periodCell.h"
#import "RootVC2.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"

@interface absentVC (){
    AppDelegate *app;
    NSMutableArray * abscntArr;
    NSMutableArray * resultData,*sentData;
}

@end

@implementation absentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
        
    _yearLbl.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"year"]];
    
//    NSString * str2  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"branch"]];
//    if ([str2 isEqualToString:@"Dept G1"]) {
//        _branchLbl.text = @"CSE,IT";
//        _sectnSeg.hidden = NO;
//
//        [_sectnSeg setTitle:@"CSE-Sec A" forSegmentAtIndex:0];
//        [_sectnSeg setTitle:@"CSE-Sec B" forSegmentAtIndex:1];
//        [_sectnSeg insertSegmentWithTitle:@"IT-Sec A" atIndex:2 animated:YES];
    
        
//    }else{
       // _branchLbl.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Department"]];
        _sectnSeg.hidden = YES;
//    }
    
//    NSString * str  =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"section"]];
//    if ([str isEqualToString:@"Section G1"] || [str isEqualToString:@">>"]) {
//        _sctcnLbl.text = @">>";
//        _sectnSeg.hidden = NO;
//
//    }else{
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"dd/MM/YYYY"];
        _sctcnLbl.text = [NSString stringWithFormat:@"%@",[dateFrmt stringFromDate:[NSDate date]]];
        _sectnSeg.hidden = YES;
//    }
    
    _perdLbl.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"time"]];
    
    _yearLbl.layer.cornerRadius = _yearLbl.frame.size.height/15;
    _yearLbl.layer.masksToBounds = YES;
    _yearLbl.layer.borderWidth = 1;
    
    _branchLbl.layer.cornerRadius = _branchLbl.frame.size.height/15;
    _branchLbl.layer.masksToBounds = YES;
    _branchLbl.layer.borderWidth = 1;
    
    _sctcnLbl.layer.cornerRadius = _sctcnLbl.frame.size.height/15;
    _sctcnLbl.layer.masksToBounds = YES;
    _sctcnLbl.layer.borderWidth = 1;
    
    _perdLbl.layer.cornerRadius = _perdLbl.frame.size.height/15;
    _perdLbl.layer.masksToBounds = YES;
    _perdLbl.layer.borderWidth = 1;
    
    _submitbttn.layer.cornerRadius = _submitbttn.frame.size.height/8;
    _submitbttn.layer.masksToBounds = YES;
    _submitbttn.layer.borderWidth = 1;
    
    
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
 
    
        
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    resultData = [NSMutableArray new];
    abscntArr = [NSMutableArray new];
    sentData = [NSMutableArray new];
    NSString*rowId = [[NSUserDefaults standardUserDefaults]valueForKey:@"TRowid"];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];

    
        
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",getAttendanceData,rowId]]                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy                                                      timeoutInterval:10.0];
//    [request setHTTPMethod:@"GET"];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"%@", error);
//            [SVProgressHUD dismiss];
//            [self checkForNetwork];
//        } else {
//            //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//            NSLog(@"%@", data);
//
//            self->resultData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];;
//            NSLog(@"Schedule Data:%@",self->resultData);
//
//            if (self->resultData.count>0) {
//                NSDateFormatter * dateFrmt = [NSDateFormatter new];
//                [dateFrmt setDateFormat:@"dd/MM/YYYY"];
//                NSString * dat = [dateFrmt stringFromDate:[NSDate date]];
//                NSString * fct = [[[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"]  stringValue];
//                NSLog(@"%@",fct);
//
//                if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"entryState"]isEqualToString:@"0"]) {
//                    for (int i=0; i<self->resultData.count; i++) {
//                        NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:i]objectForKey:@"tRowid"],[[self->resultData objectAtIndex:i]objectForKey:@"htNo"],@"1",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
//                        [self->sentData addObject:encrptData];
//                        [self->abscntArr addObject:[NSString stringWithFormat:@"0"]];
//                                                                }
//                    dispatch_async(dispatch_get_main_queue(), ^(void){
//                        [self.abscntVW reloadData];
//
//                        });
//                    }else{
//                        for (int i=0; i<self->resultData.count; i++) {
//                            NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:i]objectForKey:@"tRowid"],[[self->resultData objectAtIndex:i]objectForKey:@"htNo"],@"0",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
//                            [self->sentData addObject:encrptData];
//                            [self->abscntArr addObject:[NSString stringWithFormat:@"1"]];
//                        }
//
//                        dispatch_async(dispatch_get_main_queue(), ^(void){
//                        [self.abscntVW reloadData];
//
//                        });
//                    }
//
//                }
//
//                        [SVProgressHUD dismiss];
//                    }
//                }];
//    [dataTask resume];
    
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@",getAttendanceData,rowId];

    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, NSMutableArray* responseObject) {


        NSLog(@"Schedule Data:%@",responseObject);
        self->resultData = (NSMutableArray* )responseObject;
        NSLog(@"Schedule Data:%@",self->resultData);
        if (self->resultData.count>0) {
            NSDateFormatter * dateFrmt = [NSDateFormatter new];
            [dateFrmt setDateFormat:@"dd/MM/YYYY"];
            NSString * dat = [dateFrmt stringFromDate:[NSDate date]];
            NSString * fct = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"]];
            NSLog(@"%@",fct);

            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"entryState"]isEqualToString:@"0"]) {
                for (int i=0; i<self->resultData.count; i++) {
                    
                    NSDictionary* encrptData = @{ @"tRowid": [[self->resultData objectAtIndex:i]objectForKey:@"tRowid"], @"htno": [NSString stringWithFormat:@"%@" ,[[self->resultData objectAtIndex:i]objectForKey:@"htNo"]], @"empId": fct, @"status": @1, @"date": dat };
                    
                    [self->sentData addObject:encrptData];
                    NSLog(@"%@",encrptData);
                    [self->abscntArr addObject:[NSString stringWithFormat:@"0"]];
                }
                [self.abscntVW reloadData];

            }else{
                for (int i=0; i<self->resultData.count; i++) {
                    NSDictionary* encrptData = @{ @"tRowid": [[self->resultData objectAtIndex:i]objectForKey:@"tRowid"], @"htno": [NSString stringWithFormat:@"%@" ,[[self->resultData objectAtIndex:i]objectForKey:@"htNo"]], @"empId": fct, @"status": @0, @"date": dat };
                    
                    //NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:i]objectForKey:@"tRowid"],[NSString stringWithFormat:@"%@ " ,[[self->resultData objectAtIndex:i]objectForKey:@"htNo"]],@"0",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
                    [self->sentData addObject:encrptData];
                    [self->abscntArr addObject:[NSString stringWithFormat:@"1"]];
                }
                [self.abscntVW reloadData];
            }

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

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * prd = [UICollectionViewCell new];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"entryState"]isEqualToString:@"0"]) {
        
    if ([[abscntArr objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"abscent2" forIndexPath:indexPath];
        NSString * str = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"];
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
        periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"abscent" forIndexPath:indexPath];
        
        NSString * str = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"];
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
        
    }else {
        if ([[abscntArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"abscent3" forIndexPath:indexPath];
            NSString * str = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"];
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
            periodCell * vcl = [collectionView dequeueReusableCellWithReuseIdentifier:@"abscent" forIndexPath:indexPath];
            
            NSString * str = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"];
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
    }
        
    
    return prd;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDateFormatter * dateFrmt = [NSDateFormatter new];
    [dateFrmt setDateFormat:@"dd/MM/YYYY"];
    NSString * dat = [dateFrmt stringFromDate:[NSDate date]];
    NSString * fct = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"]];
    
    
    if ([[abscntArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        NSDictionary* encrptData = @{ @"tRowid": [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"], @"htno": [NSString stringWithFormat:@"%@" ,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"]], @"empId": fct, @"status": @0, @"date": dat };
        
        //NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"],[NSString stringWithFormat:@"%@ " ,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"]],@"0",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
        
        [sentData replaceObjectAtIndex:indexPath.row withObject:encrptData];
        [abscntArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
        [self.abscntVW reloadData];
        [self.navigationController.view makeToast:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"sName"]
                                         duration:1.0
                                         position:CSToastPositionTop];
        
    }else{
        NSDictionary* encrptData = @{ @"tRowid": [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"], @"htno": [NSString stringWithFormat:@"%@" ,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"]], @"empId": fct, @"status": @1, @"date": dat };
        
        //NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"tRowid"],[NSString stringWithFormat:@"%@ " ,[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"htNo"]],@"1",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
        
        [sentData replaceObjectAtIndex:indexPath.row withObject:encrptData];
        [abscntArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"0"]];
        [self.abscntVW reloadData];
        [self.navigationController.view makeToast:[[self->resultData objectAtIndex:indexPath.row]objectForKey:@"sName"]
                                         duration:1.0
                                         position:CSToastPositionTop];
    }
}

- (IBAction)submitAction:(UIButton *)sender {
    NSLog(@"Submitted Data:-%@",sentData);
    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"CONFIRMATION" message:@"Are you sure to submit attendance." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
        
//        NSDictionary *headers = @{ @"content-type": @"application/json" };
//
//
//        NSData *postData = [NSJSONSerialization dataWithJSONObject:self->sentData options:0 error:nil];
//
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:submitAPI] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
//        [request setHTTPMethod:@"POST"];
//        [request setAllHTTPHeaderFields:headers];
//        [request setHTTPBody:postData];
//
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response, NSError *error) {
//                                                if (error) {
//                                                    NSLog(@"%@", error);
//                                                } else {
//                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//                                                    NSLog(@"%@", httpResponse);
//                                                }
//                                            }];
//[dataTask resume];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];

    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager1.requestSerializer = serializer;

    NSString*req1 =[NSString stringWithFormat:submitAPI];
    //NSData *postData = [NSJSONSerialization dataWithJSONObject:self->sentData options:0 error:nil];
    NSLog(@"Data: %@", self->sentData);

        [manager1 POST:[req1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:self->sentData progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        NSString*  result = (NSString *)responseObject;
        BOOL sucss = [result boolValue];

        if (sucss == YES) {
            [SVProgressHUD dismiss];

                [self showAlert];

        }else{
            [SVProgressHUD dismiss];
//            UIAlertController*alert1=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Please try again later." preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
//            [alert1 addAction:ok];
//            [self presentViewController:alert1 animated:YES completion:nil];
        }


    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self checkForNetwork];
        [SVProgressHUD dismiss];
    }];
    
    }];
    UIAlertAction * cancl = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];
    [alrt addAction:cancl];
    [alrt addAction:ok];
    [self presentViewController:alrt animated:YES completion:nil];
    
}

-(void)showAlert{
    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Success" message:@"Data successfully submitted." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RootVC2 * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC2"];
        self->app.window.rootViewController = rt;
        
    }];
    [alrt addAction:ok];
    [self presentViewController:alrt animated:YES completion:nil];
}

- (IBAction)secSegmntAct:(id)sender {
    if (_sectnSeg.selectedSegmentIndex==0) {
        
        abscntArr = [NSMutableArray new];
        for (int i=0; i<60; i++) {
            [abscntArr addObject:[NSString stringWithFormat:@"0"]];
        }
        
        [self.abscntVW reloadData];
        
    }else if (_sectnSeg.selectedSegmentIndex==1){
        
        abscntArr = [NSMutableArray new];
        for (int i=0; i<80; i++) {
            [abscntArr addObject:[NSString stringWithFormat:@"0"]];
        }
        
        [self.abscntVW reloadData];
    }else{
        
        abscntArr = [NSMutableArray new];
        for (int i=0; i<40; i++) {
            [abscntArr addObject:[NSString stringWithFormat:@"0"]];
        }
        
        [self.abscntVW reloadData];
    }
}

- (IBAction)absentAct:(UIButton *)sender {
    if (self.absntBttn.tag==0) {
        abscntArr = [NSMutableArray new];
        sentData = [NSMutableArray new];
        
        _absntImg.image = [UIImage imageNamed:@"dotClse"];
        _prsntImg.image = [UIImage imageNamed:@"dotOpn"];
        
        self.absntBttn.tag = 1;
        self.presntbttn.tag = 0;
        
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"dd/MM/YYYY"];
        NSString * dat = [dateFrmt stringFromDate:[NSDate date]];
        NSString * fct = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"]];
        
        for (int i=0; i<self->resultData.count; i++) {
            NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:i]objectForKey:@"tRowid"],[NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:i]objectForKey:@"htNo"]],@"1",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
            [self->sentData addObject:encrptData];
            [self->abscntArr addObject:[NSString stringWithFormat:@"0"]];
        }
        [self.abscntVW reloadData];
    }
    
    
}

- (IBAction)presentAct:(UIButton *)sender {
    if (self.presntbttn.tag==0) {
        abscntArr = [NSMutableArray new];
        sentData = [NSMutableArray new];
        
        _prsntImg.image = [UIImage imageNamed:@"dotClse"];
        _absntImg.image = [UIImage imageNamed:@"dotOpn"];
        self.presntbttn.tag = 1;
        self.absntBttn.tag = 0;
        
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"dd/MM/YYYY"];
        NSString * dat = [dateFrmt stringFromDate:[NSDate date]];
        NSString * fct = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"]];
        
        for (int i=0; i<self->resultData.count; i++) {
            NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[[[self->resultData objectAtIndex:i]objectForKey:@"tRowid"],[NSString stringWithFormat:@"%@",[[self->resultData objectAtIndex:i]objectForKey:@"htNo"]],@"1",dat,fct] forKeys:@[@"tRowid",@"htno",@"status",@"date",@"empId"]];
            [self->sentData addObject:encrptData];
            [self->abscntArr addObject:[NSString stringWithFormat:@"1"]];
        }
        [self.abscntVW reloadData];
    }
}

- (IBAction)homeAct:(UIBarButtonItem *)sender {
    RootVC2 * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC2"];
    self->app.window.rootViewController = rt;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        prevusHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"absentHead" forIndexPath:indexPath];
        if (indexPath.section==0 ) {
            headerView.headerLbl.text = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"subjectName"];
            NSInteger occurrences = [[abscntArr indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {return [obj isEqual:@"0"];}] count];
            
            headerView.presentLBL.text = [NSString stringWithFormat:@"Present: %ld",(long)occurrences];
            headerView.absentLbl.text = [NSString stringWithFormat:@"Absent: %ld",self->resultData.count-(long)occurrences];
            
//        }else if (indexPath.section==0 && self.presntbttn.tag==1) {
//            headerView.headerLbl.text = [[self->resultData objectAtIndex:indexPath.row]objectForKey:@"SubjectName"];
//            NSInteger occurrences = [[abscntArr indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {return [obj isEqual:@"1"];}] count];
//            
//            headerView.presentLBL.text = [NSString stringWithFormat:@"Present: %ld",(long)occurrences];
//            headerView.absentLbl.text = [NSString stringWithFormat:@"Absent: %ld",self->resultData.count-(long)occurrences];
            
        }else {
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

@end
