//
//  ViewController.m
//  studentRegistery
//
//  Created by macmini on 1/5/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "periodVC.h"
#import "groupingVC.h"
#import "previousEntryList.h"


@interface ViewController (){
    UIPickerView *picker,*picker1,*picker2;
    NSArray * yearArr,*brnchArr,*sctnArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:109.0/255.0 green:17.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:80.0/255.0 green:117.0/255.0 blue:217.0/255.0 alpha:1.0]];
    
    _yearTF.layer.cornerRadius = _yearTF.frame.size.height/5;
    _yearTF.layer.masksToBounds = YES;
    _yearTF.layer.borderWidth = 1;
    
    _branchTF.layer.cornerRadius = _branchTF.frame.size.height/5;
    _branchTF.layer.masksToBounds = YES;
    _branchTF.layer.borderWidth = 1;
    
    _sectionTF.layer.cornerRadius = _sectionTF.frame.size.height/5;
    _sectionTF.layer.masksToBounds = YES;
    _sectionTF.layer.borderWidth = 1;
    
    _nextBttn.layer.cornerRadius = _nextBttn.frame.size.height/8;
    _nextBttn.layer.masksToBounds = YES;
    _nextBttn.layer.borderWidth = 1;
    
    _prvusList.layer.cornerRadius = _prvusList.frame.size.height/8;
    _prvusList.layer.masksToBounds = YES;
    _prvusList.layer.borderWidth = 1;
    
    NSArray * fields= @[_yearTF,_branchTF,_sectionTF];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    [self.keyboardControls setBarTintColor:[UIColor whiteColor]];
    [self.keyboardControls setBarStyle:UIBarStyleBlack];
    
   
//        [fields enumerateObjectsUsingBlock:^(UITextField * obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        obj.layer.cornerRadius = obj.frame.size.width/25;
    //        obj.layer.masksToBounds = YES;
    //        obj.layer.borderWidth=1;
    //        obj.layer.borderColor=[UIColor colorWithRed:217.0/255.0 green:22.0/255.0 blue:8.0/255.0 alpha:1.0].CGColor;
    //    }];
    
    picker=[UIPickerView new];
    picker1 =[UIPickerView new];
    picker2 =[UIPickerView new];
    
    _yearTF.inputView=picker;
    _branchTF.inputView = picker1;
    _sectionTF.inputView = picker2;
    
    NSArray *fields3 = @[picker,picker1,picker2];
    [fields3 enumerateObjectsUsingBlock:^(UIPickerView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.delegate = self;
        obj.dataSource = self;
    }];
    
    self->yearArr = [NSMutableArray new];
    self->brnchArr = [NSMutableArray new];
    self->sctnArr = [NSMutableArray new];
    
    yearArr = @[@"--Select Year--",@"I SEM",@"II SEM",@"III SEM",@"IV SEM",@"V SEM",@"VI SEM",@"VII SEM",@"VIII SEM"];
    brnchArr = @[@"--Select Branch--",@"IT",@"CSE",@"ECE",@"EEE",@"MECH",@"Dept G1"];
    sctnArr = @[@"--Select Section--",@"Section A",@"Section B",@"Section G1"];
    
    
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view;
    view = field.superview.superview.superview;
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==picker) {
        return yearArr.count;
        
    }else if (pickerView==picker1) {
        return brnchArr.count;
        
    }else if (pickerView==picker2) {
        return sctnArr.count;
        
    }
    return 0;
}


- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==picker) {
        return [yearArr objectAtIndex:row];
        
    }else if (pickerView==picker1) {
        return [brnchArr objectAtIndex:row];
        
    }else if (pickerView==picker2) {
        return [sctnArr objectAtIndex:row];
        
    }
    return [sctnArr objectAtIndex:row];
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
        pickerLabel.text = [yearArr objectAtIndex:row];
        
    }else if (pickerView==picker1) {
        pickerLabel.text= [brnchArr objectAtIndex:row];
        
    }else if (pickerView==picker2) {
        pickerLabel.text= [sctnArr objectAtIndex:row];
        
    }
    
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==picker && row>0) {
        
        _yearTF.text = [NSString stringWithFormat:@"%@",[yearArr objectAtIndex:row]];
        _yearTF.tag = 1;
        
    }else if (pickerView==picker1 && row>0) {
        _branchTF.text= [NSString stringWithFormat:@"%@",[brnchArr objectAtIndex:row]];
        _branchTF.tag = 1;
        if (row==6) {
            _sectionTF.hidden = YES;
            _imgDrp.hidden = YES;
            
        }else{
            _sectionTF.hidden = NO;
            _imgDrp.hidden = NO;
        }
        
    }else if (pickerView==picker2 && row>0) {
        _sectionTF.text= [NSString stringWithFormat:@"%@",[sctnArr objectAtIndex:row]];
        _sectionTF.tag = 1;
        
    }
    
}


- (IBAction)nextAction:(UIButton *)sender {
    _yearErr.hidden = YES;
    _brnchErr.hidden = YES;
    _sctnErr.hidden = YES;
    
    if(_yearTF.text.length==0){
        [_yearTF becomeFirstResponder];
        _yearErr.hidden = NO;
        
    }else if(_branchTF.text.length==0){
        [_branchTF becomeFirstResponder];
        _brnchErr.hidden = NO;
        
    }else if(_sectionTF.text.length==0 && _sectionTF.hidden==NO){
        [_sectionTF becomeFirstResponder];
        _sctnErr.hidden = NO;
        
    }else{
        [[NSUserDefaults standardUserDefaults]setValue:_yearTF.text forKey:@"year"];
        [[NSUserDefaults standardUserDefaults]setValue:_branchTF.text forKey:@"branch"];
        if (_sectionTF.hidden==NO) {
            [[NSUserDefaults standardUserDefaults]setValue:_sectionTF.text forKey:@"section"];
        }else{
            [[NSUserDefaults standardUserDefaults]setValue:@">>" forKey:@"section"];
        }
        
        
        periodVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"periodVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (IBAction)addGrpAct:(UIBarButtonItem *)sender {
    groupingVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"groupingVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)prevousAct:(UIButton *)sender {
    previousEntryList * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"previousEntryList"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
