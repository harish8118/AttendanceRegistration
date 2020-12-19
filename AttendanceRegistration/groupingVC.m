
//
//  groupingVC.m
//  studentRegistery
//
//  Created by macmini on 1/7/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "groupingVC.h"
#import "RootVC.h"
#import "AppDelegate.h"
#import "groupingCell.h"

@interface groupingVC (){
    AppDelegate *app;
    NSMutableArray * secSlctArr,*dprtDprtSlctArr,*dprtSecSlctArr;
    UIPickerView *picker;
    NSArray *brnchArr,*brnchArr2,*secArr;
}

@end

@implementation groupingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    _sectnVW.layer.cornerRadius = _sectnVW.frame.size.width/25;
    _sectnVW.layer.masksToBounds = YES;
    _sectnVW.layer.borderWidth = 1;
    
    _deprtVW.layer.cornerRadius = _deprtVW.frame.size.width/25;
    _deprtVW.layer.masksToBounds = YES;
    _deprtVW.layer.borderWidth = 1;
    
    _secGrpNameTF.layer.cornerRadius = _secGrpNameTF.frame.size.height/5;
    _secGrpNameTF.layer.masksToBounds = YES;
    _secGrpNameTF.layer.borderWidth = 1;
    
    _secDprtTF.layer.cornerRadius = _secDprtTF.frame.size.height/5;
    _secDprtTF.layer.masksToBounds = YES;
    _secDprtTF.layer.borderWidth = 1;
    
    _secGnrtBttn.layer.cornerRadius = _secGnrtBttn.frame.size.height/5;
    _secGnrtBttn.layer.masksToBounds = YES;
    
    _dprtGrpNameTF.layer.cornerRadius = _dprtGrpNameTF.frame.size.height/5;
    _dprtGrpNameTF.layer.masksToBounds = YES;
    _dprtGrpNameTF.layer.borderWidth = 1;
    
    _dprtGnrtBttn.layer.cornerRadius = _dprtGnrtBttn.frame.size.height/5;
    _dprtGnrtBttn.layer.masksToBounds = YES;
    
    picker=[UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    _secDprtTF.inputView=picker;
    
    brnchArr = @[@"--Select Department--",@"IT",@"CSE",@"ECE",@"EEE"];
    brnchArr2 = @[@"IT",@"CSE",@"ECE",@"EEE",@"MECH"];
    secArr = @[@"Section A",@"Section B"];
    
    secSlctArr = [NSMutableArray new];
    dprtDprtSlctArr = [NSMutableArray new];
    dprtSecSlctArr = [NSMutableArray new];
    
    for (int i=0; i<2; i++) {
        [secSlctArr addObject:[NSString stringWithFormat:@"0"]];
    }
    
    for (int i=0; i<5; i++) {
        [dprtDprtSlctArr addObject:[NSString stringWithFormat:@"0"]];
    }
    
    for (int i=0; i<2; i++) {
        [dprtSecSlctArr addObject:[NSString stringWithFormat:@"0"]];
    }
    
    UIToolbar *tolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [tolBar setTintColor:[UIColor blueColor]];
    UIBarButtonItem *don=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(resign)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [tolBar setItems:[NSArray arrayWithObjects:space,don, nil]];
    [_secGrpNameTF setInputAccessoryView:tolBar];
    [_secDprtTF setInputAccessoryView:tolBar];
    [_dprtGrpNameTF setInputAccessoryView:tolBar];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
   
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==picker) {
        return brnchArr.count;
        
    }
    return 0;
}


- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     if (pickerView==picker) {
        return [brnchArr objectAtIndex:row];
        
    }
    return [brnchArr objectAtIndex:row];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
        
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    // Fill the label text here
    if (pickerView==picker) {
        pickerLabel.text = [brnchArr objectAtIndex:row];
        
    }
    
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==picker && row>0) {
        _secDprtTF.text = [NSString stringWithFormat:@"%@",[brnchArr objectAtIndex:row]];
        _secDprtTF.tag = 1;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_secTbl) {
        return 2;
    }else if (tableView==_dprtDprtmntTbl){
        return 5;
    }else if (tableView==_dprtSecTbl){
        return 2;
    }
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * grp = [UITableViewCell new];
    
    if (tableView==_secTbl) {
        groupingCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"secSectn" forIndexPath:indexPath];
        
        if ([[secSlctArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            vcl.nameLbl3.text = [NSString stringWithFormat:@" %@",[secArr objectAtIndex:indexPath.row]];
            vcl.img3.image = [UIImage imageNamed:@"dotOpn"];
            
            grp = vcl;
            
        }else{
            vcl.nameLbl3.text = [NSString stringWithFormat:@" %@",[secArr objectAtIndex:indexPath.row]];
            vcl.img3.image = [UIImage imageNamed:@"dotClse"];
            
            grp = vcl;
        }
    }else if (tableView==_dprtSecTbl) {
        groupingCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"dprtsectn" forIndexPath:indexPath];
        
        if ([[dprtSecSlctArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            vcl.nameLbl2.text = [NSString stringWithFormat:@" %@",[secArr objectAtIndex:indexPath.row]];
            vcl.img2.image = [UIImage imageNamed:@"dotOpn"];
            
            grp = vcl;
            
        }else{
            vcl.nameLbl2.text = [NSString stringWithFormat:@" %@",[secArr objectAtIndex:indexPath.row]];
            vcl.img2.image = [UIImage imageNamed:@"dotClse"];
            
            grp = vcl;
        }
    }else if (tableView==_dprtDprtmntTbl) {
        groupingCell * vcl = [tableView dequeueReusableCellWithIdentifier:@"dprtDprtmnt" forIndexPath:indexPath];
        
        if ([[dprtDprtSlctArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            vcl.nameLbl.text = [NSString stringWithFormat:@" %@",[brnchArr2 objectAtIndex:indexPath.row]];
            vcl.img.image = [UIImage imageNamed:@"dotOpn"];
            
            grp = vcl;
            
        }else{
            vcl.nameLbl.text = [NSString stringWithFormat:@" %@",[brnchArr2 objectAtIndex:indexPath.row]];
            vcl.img.image = [UIImage imageNamed:@"dotClse"];
            
            grp = vcl;
        }
    }
    
    grp.layer.cornerRadius = grp.frame.size.height/8;
    grp.layer.masksToBounds = YES;
    grp.layer.borderWidth = 2;
    
    return grp;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_secTbl) {
        if ([[secSlctArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            [secSlctArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
            [self.secTbl reloadData];
        
        }else{
            [secSlctArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"0"]];
            [self.secTbl reloadData];
        
        }
        
    }else if (tableView==_dprtSecTbl) {
        if ([[dprtSecSlctArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            [dprtSecSlctArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
            [self.dprtSecTbl reloadData];
            
        }else{
            [dprtSecSlctArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"0"]];
            [self.dprtSecTbl reloadData];
            
        }
    }else if (tableView==_dprtDprtmntTbl) {
        if ([[dprtDprtSlctArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            [dprtDprtSlctArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"1"]];
            [self.dprtDprtmntTbl reloadData];
            
        }else{
            [dprtDprtSlctArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"0"]];
            [self.dprtDprtmntTbl reloadData];
            
        }
    }
}

- (IBAction)dprtGnrtGrpAct:(UIButton *)sender {
    _dprtGrpErr.hidden = YES;
    _dprtDprtErr.hidden = YES;
    _dprtSectnErr.hidden = YES;
    
    if(_dprtGrpNameTF.text.length==0){
        [_dprtGrpNameTF becomeFirstResponder];
        _dprtGrpErr.hidden = NO;
        
    }else if(![dprtDprtSlctArr containsObject:@"1"]){
        _dprtDprtErr.hidden = NO;
        
    }else if(![dprtSecSlctArr containsObject:@"1"]){
        _dprtSectnErr.hidden = NO;
        
    }else{
        
    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Success" message:@"Data successfully submitted." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RootVC * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC"];
        self->app.window.rootViewController = rt;
        
    }];
    [alrt addAction:ok];
    [self presentViewController:alrt animated:YES completion:nil];
        
    }
}

- (IBAction)secGenrtGrpAct:(UIButton *)sender {
    _secGrpErr.hidden = YES;
    _secDprtErr.hidden = YES;
    _secSctnLbl.hidden = YES;
    
    if(_secGrpNameTF.text.length==0){
        [_secGrpNameTF becomeFirstResponder];
        _secGrpErr.hidden = NO;
        
    }else if(_secDprtTF.text.length==0){
        [_secDprtTF becomeFirstResponder];
        _secDprtErr.hidden = NO;
        
    }else if(![secSlctArr containsObject:@"1"]){
        _secSctnLbl.hidden = NO;
        
    }else{
        
    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Success" message:@"Data successfully submitted." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RootVC * rt = [self.storyboard instantiateViewControllerWithIdentifier:@"RootVC"];
        self->app.window.rootViewController = rt;
        
    }];
    [alrt addAction:ok];
    [self presentViewController:alrt animated:YES completion:nil];
        
    }
}

- (IBAction)secOptnAct:(UIButton *)sender {
    _sectnVW.hidden = NO;
    _sectnOptn.image = [UIImage imageNamed:@"dotClse"];
    _dprtOptn.image = [UIImage imageNamed:@"dotOpn"];
    _deprtVW.hidden = YES;
    
}

- (IBAction)deprtOptnAct:(UIButton *)sender {
    _sectnVW.hidden = YES;
    _sectnOptn.image = [UIImage imageNamed:@"dotOpn"];
    _dprtOptn.image = [UIImage imageNamed:@"dotClse"];
    _deprtVW.hidden = NO;
    
}

-(void)resign{
    [_secGrpNameTF resignFirstResponder];
    [_secDprtTF resignFirstResponder];
    [_dprtGrpNameTF resignFirstResponder];
     
    
}

@end
