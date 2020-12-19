//
//  searchStudentVC.m
//  studentRegistery
//
//  Created by macmini on 3/1/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "searchStudentVC.h"
#import "personalTableCell.h"
#import "personalHead.h"

@interface searchStudentVC (){
    NSString *facultyId;
    NSMutableArray *rsltArr;
    int hight;
}

@end

@implementation searchStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    rsltArr = [NSMutableArray new];
    
    self.hallTcktTF.layer.cornerRadius = self.hallTcktTF.frame.size.height/8;
    self.hallTcktTF.layer.masksToBounds = YES;
    self.hallTcktTF.layer.borderWidth = 1;
    self.hallTcktTF.layer.borderColor = [UIColor colorWithRed:80.0/255.0 green:117.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    
    UIToolbar *tolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [tolBar setTintColor:[UIColor blueColor]];
    UIBarButtonItem *don=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(resign)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [tolBar setItems:[NSArray arrayWithObjects:space,don, nil]];
    [self.hallTcktTF setInputAccessoryView:tolBar];
    [self.hallTcktTF becomeFirstResponder];
    
    
    
}



- (IBAction)searchAct:(UIButton *)sender {
    if(_hallTcktTF.text.length>0){
        [_hallTcktTF resignFirstResponder];
        
        [SVProgressHUD showWithStatus:@"Please Wait"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
        
        facultyId = [[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"];
        
        AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        NSString*req=[NSString stringWithFormat:@"%@%@&EmpID=%@",getStudentSearchResult,self.hallTcktTF.text,facultyId];
        
        [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            self->rsltArr = (NSMutableArray* )responseObject;
            NSLog(@"Faculty Detail:%@",self->rsltArr);
            
            if (self->rsltArr.count>0) {
                self.hallTcktLbl.text = [NSString stringWithFormat:@"Ht.No:- %@",[[self->rsltArr objectAtIndex:0]objectForKey:@"htno"]];
                
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.hallTcktLbl.text];
                [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(7, self.hallTcktLbl.text.length-7)];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0/255.0 green:58.0/255.0 blue:93.0/255.0 alpha:1.0] range:NSMakeRange(7, self.hallTcktLbl.text.length-7)];
                self.hallTcktLbl.attributedText=attrString;
                
                self.studentName.text = [NSString stringWithFormat:@"Name:- %@",[[self->rsltArr objectAtIndex:0]objectForKey:@"sName"]];
                
                NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:self.studentName.text];
                [attrString1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(6, self.studentName.text.length-6)];
                [attrString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0/255.0 green:58.0/255.0 blue:93.0/255.0 alpha:1.0] range:NSMakeRange(6, self.studentName.text.length-6)];
                self.studentName.attributedText=attrString1;
                
                [self.searchRsltTbl reloadData];
                self.searchRsltVW.hidden = NO;
            }else{
                self.searchRsltVW.hidden = YES;
            }
            
            [SVProgressHUD dismiss];
            
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            [self checkForNetwork];
        }];
    }else{
        UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Warning" message:@"*Please enter the hallticket number." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.hallTcktTF becomeFirstResponder];
        }];
        [alrt addAction:ok];
        [self presentViewController:alrt animated:YES completion:nil];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (rsltArr.count>0) {
        return rsltArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    personalTableCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"personalSchedule" forIndexPath:indexPath];
    vcl.subjectName.text = [NSString stringWithFormat:@"%@",[[rsltArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]];
    vcl.timeLabel.text = [NSString stringWithFormat:@"%@",[[rsltArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
    vcl.dateLabel.text = [NSString stringWithFormat:@"%@",[[rsltArr objectAtIndex:indexPath.row]objectForKey:@"date"]];
   
    hight = [self textHeight:[NSString stringWithFormat:@"%@",[[rsltArr objectAtIndex:indexPath.row]objectForKey:@"subjectName"]]];
//    vcl.timeLabel.layer.borderWidth = 1;
//    vcl.subjectName.layer.borderWidth = 1;
    vcl.layer.cornerRadius = vcl.frame.size.width/40;
    vcl.layer.masksToBounds = YES;
   
   return  vcl;
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (rsltArr.count>0) {
        return hight+40;
    }
    return 40;
}

- (CGFloat)textHeight:(NSString *)text{
    CGFloat maxWidth = self.view.bounds.size.width;
    // set Max width for your control here. (i have used 200)
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth/2, CGFLOAT_MAX)                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)                                  attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:16]}
                                     context:nil];
    CGFloat textHeight = rect.size.height;
    return textHeight;
}

-(void)resign{
    [self.hallTcktTF resignFirstResponder];
   
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
