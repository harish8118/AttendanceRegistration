//
//  personalTableVW.m
//  studentRegistery
//
//  Created by macmini on 2/8/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "personalTableVW.h"
#import "personalTableCell.h"
#import "personalHead.h"

@interface personalTableVW (){
    NSMutableArray *fcltySmmry,*monArr,*tueArr,*wedArr,*thrArr,*friArr,*satArr;
    int hight;
}

@end

@implementation personalTableVW

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    fcltySmmry = [NSMutableArray new];
    monArr = [NSMutableArray new];
    tueArr = [NSMutableArray new];
    wedArr = [NSMutableArray new];
    thrArr = [NSMutableArray new];
    friArr = [NSMutableArray new];
    satArr = [NSMutableArray new];
    
    NSString* facultyId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"]];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@",getScheduleTable,facultyId];
    NSLog(@"url:%@",req);
    
    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSMutableArray * rslt = (NSMutableArray* )responseObject;
        NSLog(@"Data:%@",rslt);
        
        for (int p=0; p<rslt.count; p++) {
            NSString * fct = [NSString stringWithFormat:@"%@",[[rslt objectAtIndex:p]objectForKey:@"empid"]];
            if ([fct isEqualToString:facultyId]) {
                [self->fcltySmmry addObject:[rslt objectAtIndex:p]];
            }

        }
        
        NSLog(@"Faculty Data:%@",self->fcltySmmry);
        if (self->fcltySmmry.count>0) {
            for (int i=0; i<self->fcltySmmry.count; i++) {
                NSString * stat = [NSString stringWithFormat:@"%@",[[self->fcltySmmry objectAtIndex:i]objectForKey:@"day"]];
                
                if ([stat isEqualToString:@"Monday"]) {
                    [self->monArr addObject:[self->fcltySmmry objectAtIndex:i]];
                    
                }else if ([stat isEqualToString:@"Tuesday"]){
                    [self->tueArr addObject:[self->fcltySmmry objectAtIndex:i]];
                    
                }else if ([stat isEqualToString:@"Wednesday"]){
                    [self->wedArr addObject:[self->fcltySmmry objectAtIndex:i]];
                    
                }else if ([stat isEqualToString:@"Thursday"]){
                    [self->thrArr addObject:[self->fcltySmmry objectAtIndex:i]];
                    
                }else if ([stat isEqualToString:@"Friday"]){
                    [self->friArr addObject:[self->fcltySmmry objectAtIndex:i]];
                    
                }else if ([stat isEqualToString:@"Saturday"]){
                    [self->satArr addObject:[self->fcltySmmry objectAtIndex:i]];
                    
                }
            }
            [self.personalTbl reloadData];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        [self checkForNetwork];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self->fcltySmmry.count>0) {
        return 6;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (fcltySmmry.count>0) {
        if (section==0) {
            return monArr.count;
            
        }else if (section==1) {
            return tueArr.count;
            
        }else if (section==2) {
            return wedArr.count;
            
        }else if (section==3) {
            return thrArr.count;
            
        }else if (section==4) {
            return friArr.count;
            
        }else if (section==5) {
            return satArr.count;
            
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell new];
    
    if (indexPath.section==0) {
        personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
        vcl.subjectName.text = [NSString stringWithFormat:@"%@-%@",[[monArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[monArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
        vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[monArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        hight = [self textHeight:[NSString stringWithFormat:@"%@-%@",[[monArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[monArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
        vcl.timeLabel.layer.borderWidth = 1;
        vcl.subjectName.layer.borderWidth = 1;
        
        cell = vcl;
        
    }else if (indexPath.section==1) {
        personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
        vcl.subjectName.text = [NSString stringWithFormat:@"%@-%@",[[tueArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[tueArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
        vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[tueArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        hight = [self textHeight:[NSString stringWithFormat:@"%@-%@",[[tueArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[tueArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
        vcl.timeLabel.layer.borderWidth = 1;
        vcl.subjectName.layer.borderWidth = 1;
        cell = vcl;
        
    }else if (indexPath.section==2) {
        personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
        vcl.subjectName.text = [NSString stringWithFormat:@"%@-%@",[[wedArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[wedArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
        vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[wedArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        hight = [self textHeight:[NSString stringWithFormat:@"%@-%@",[[wedArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[wedArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
        vcl.timeLabel.layer.borderWidth = 1;
        vcl.subjectName.layer.borderWidth = 1;
        cell = vcl;
        
    }else if (indexPath.section==3) {
        personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
        vcl.subjectName.text = [NSString stringWithFormat:@"%@-%@",[[thrArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[thrArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
        vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[thrArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        hight = [self textHeight:[NSString stringWithFormat:@"%@-%@",[[thrArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[thrArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
        vcl.timeLabel.layer.borderWidth = 1;
        vcl.subjectName.layer.borderWidth = 1;
        cell = vcl;
        
    }else if (indexPath.section==4) {
        personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
        vcl.subjectName.text = [NSString stringWithFormat:@"%@-%@",[[friArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[friArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
        vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[friArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        hight = [self textHeight:[NSString stringWithFormat:@"%@-%@",[[friArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[friArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
        vcl.timeLabel.layer.borderWidth = 1;
        vcl.subjectName.layer.borderWidth = 1;
        cell = vcl;
        
    }else if (indexPath.section==5) {
        personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
        vcl.subjectName.text = [NSString stringWithFormat:@"%@-%@",[[satArr objectAtIndex:indexPath.row]objectForKey:@"rollName"],[[satArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
        vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[satArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
        
        hight = [self textHeight:[NSString stringWithFormat:@"%@",[[satArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
        vcl.timeLabel.layer.borderWidth = 1;
        vcl.subjectName.layer.borderWidth = 1;
        cell = vcl;
        
    }
    
    return cell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView*vw=[UIView new];
    
    NSArray*cellarry=[[NSBundle mainBundle]loadNibNamed:@"tableHead" owner:self options:nil];
    personalHead*call=[cellarry objectAtIndex:0];
    if (section==0) {
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"cccc"];
        if ([[dateFrmt stringFromDate:[NSDate date]]isEqualToString:@"Monday"]) {
            call.dayLabel.text=[NSString stringWithFormat:@"  MONDAY"];
            call.dayLabel.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0];
        }else{
            call.dayLabel.text=[NSString stringWithFormat:@"  MONDAY"];
        }
        
    }else if (section==1){
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"cccc"];
        if ([[dateFrmt stringFromDate:[NSDate date]]isEqualToString:@"Tuesday"]) {
            call.dayLabel.text=[NSString stringWithFormat:@"  TUESDAY"];
            call.dayLabel.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0];
        }else{
        call.dayLabel.text=[NSString stringWithFormat:@"  TUESDAY"];
        
        }
    }else if (section==2){
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"cccc"];
        if ([[dateFrmt stringFromDate:[NSDate date]]isEqualToString:@"Wednesday"]) {
            call.dayLabel.text=[NSString stringWithFormat:@"  WEDNESDAY"];
            call.dayLabel.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0];
        }else{
        call.dayLabel.text=[NSString stringWithFormat:@"  WEDNESDAY"];
        
        }
    }else if (section==3){
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"cccc"];
        if ([[dateFrmt stringFromDate:[NSDate date]]isEqualToString:@"Thursday"]) {
            call.dayLabel.text=[NSString stringWithFormat:@"  THURSDAY"];
            call.dayLabel.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0];
        }else{
        call.dayLabel.text=[NSString stringWithFormat:@"  THURSDAY"];
        
        }
    }else if (section==4){
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"cccc"];
        if ([[dateFrmt stringFromDate:[NSDate date]]isEqualToString:@"Friday"]) {
            call.dayLabel.text=[NSString stringWithFormat:@"  FRIDAY"];
            call.dayLabel.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0];
        }else{
        call.dayLabel.text=[NSString stringWithFormat:@"  FRIDAY"];
        
        }
    }else if (section==5){
        NSDateFormatter * dateFrmt = [NSDateFormatter new];
        [dateFrmt setDateFormat:@"cccc"];
        if ([[dateFrmt stringFromDate:[NSDate date]]isEqualToString:@"Saturday"]) {
            call.dayLabel.text=[NSString stringWithFormat:@"  SATURDAY"];
            call.dayLabel.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:123.0/255.0 blue:62.0/255.0 alpha:1.0];
        }else{
        call.dayLabel.text=[NSString stringWithFormat:@"  SATURDAY"];
        
        }
    }
    
//    call.layer.cornerRadius = 5.0;
//    call.layer.masksToBounds = YES;
    vw=call;
    
    return vw;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (fcltySmmry.count>0) {
        return hight+20;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 85;
}

- (CGFloat)textHeight:(NSString *)text{
    CGFloat maxWidth = self.view.bounds.size.width;
    // set Max width for your control here. (i have used 200)
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth/2, CGFLOAT_MAX)                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)                                  attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:16]}
                                     context:nil];
    CGFloat textHeight = rect.size.height;
    return textHeight;
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
