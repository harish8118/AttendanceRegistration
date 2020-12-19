//
//  loginVC.m
//  studentRegistery
//
//  Created by macmini on 1/24/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "loginVC.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "API.h"
#import "AppDelegate.h"
#import "RootVC2.h"

@interface loginVC (){
    AppDelegate *app;
}

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _facultyTF.layer.cornerRadius = _facultyTF.frame.size.height/8;
    _facultyTF.layer.masksToBounds = YES;
    _facultyTF.layer.borderWidth = 1;
    _facultyTF.layer.borderColor = [UIColor colorWithRed:80.0/255.0 green:117.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    
    _passwordTF.layer.cornerRadius = _passwordTF.frame.size.height/8;
    _passwordTF.layer.masksToBounds = YES;
    _passwordTF.layer.borderWidth = 1;
    _passwordTF.layer.borderColor = [UIColor colorWithRed:80.0/255.0 green:117.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    
    _submitBttn.layer.cornerRadius = _submitBttn.frame.size.height/8;
    _submitBttn.layer.masksToBounds = YES;
    
    UIToolbar *tolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [tolBar setTintColor:[UIColor blueColor]];
    UIBarButtonItem *don=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(resign)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [tolBar setItems:[NSArray arrayWithObjects:space,don, nil]];
    [_facultyTF setInputAccessoryView:tolBar];
    [_passwordTF setInputAccessoryView:tolBar];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
}



- (IBAction)submitAct:(UIButton *)sender {
    _facultyErr.hidden = YES;
    _passwordErr.hidden = YES;
    
    if(_facultyTF.text.length==0){
        [_facultyTF becomeFirstResponder];
        _facultyErr.hidden = NO;
        
    }else if(_passwordTF.text.length==0){
        [_passwordTF becomeFirstResponder];
        _passwordErr.hidden = NO;
        
    }else{
        [SVProgressHUD showWithStatus:@"Please Wait"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
            
            AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
            [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
            
            AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            manager1.requestSerializer = serializer;
            
            NSString*req1 =[NSString stringWithFormat:loginAPI];
            
            NSDictionary *encrptData = [NSDictionary dictionaryWithObjects:@[_facultyTF.text,_passwordTF.text] forKeys:@[@"mobileno",@"password"]];
            NSLog(@"%@",encrptData);
        
            [manager1 POST:[req1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:encrptData progress:nil success:^(NSURLSessionTask *task, id responseObject) {

            NSDictionary*rslt = (NSDictionary* )responseObject;
            NSLog(@"Faculty Detail:%@",rslt);
            
            if ([rslt objectForKey:@"FacultyId"] != [NSNull null] ) {
                
                [[NSUserDefaults standardUserDefaults]setValue:[rslt objectForKey:@"empId"] forKey:@"facultyId"];
                [[NSUserDefaults standardUserDefaults]setValue:[rslt objectForKey:@"empName"] forKey:@"FacultyName"];
                //[[NSUserDefaults standardUserDefaults]setValue:[rslt objectForKey:@"course"] forKey:@"Department"];
                //[[NSUserDefaults standardUserDefaults]setValue:[rslt objectForKey:@"courseid"] forKey:@"DepartmentID"];
                
                [[NSUserDefaults standardUserDefaults]setValue:[rslt objectForKey:@"collName"] forKey:@"CollegeName"];
                
                [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"loginStatus"];
                [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"entryState"];
                [SVProgressHUD dismiss];
                RootVC2 * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC2"];
                self->app.window.rootViewController = rt;
                
            }else{
                [SVProgressHUD dismiss];
                UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please enter valid credentials to get login." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alrt addAction:ok];
                [self presentViewController:alrt animated:YES completion:nil];
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
            [self checkForNetwork];
        }];
    }
    
}

-(void)resign{
    [_facultyTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
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
