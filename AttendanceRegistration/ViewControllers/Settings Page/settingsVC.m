//
//  settingsVC.m
//  studentRegistery
//
//  Created by macmini on 2/9/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "settingsVC.h"
#import "personalTableCell.h"

@interface settingsVC (){
    NSMutableArray * states;
}

@end

@implementation settingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    states = [NSMutableArray new];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"entryState"]isEqualToString:@"0"]) {
        [states addObject:@"1"];
        [states addObject:@"0"];
        
    }else{
        [states addObject:@"0"];
        [states addObject:@"1"];
    }
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Choose Attendance Entry Type:-";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell new];
    if (indexPath.row==0) {
        personalTableCell * gc = [tableView dequeueReusableCellWithIdentifier:@"setting1" forIndexPath:indexPath];
        gc.settingSwitch.tag = indexPath.row;
        
        if ([[states objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
            [gc.settingSwitch setOn:YES];
            
        }else{
            [gc.settingSwitch setOn:NO];
        }
        cell = gc;
        
    }else if (indexPath.row==1) {
        personalTableCell * gc = [tableView dequeueReusableCellWithIdentifier:@"setting2" forIndexPath:indexPath];
        gc.settingSwitch.tag = indexPath.row;
        
        if ([[states objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
            [gc.settingSwitch setOn:YES];
            
        }else{
            [gc.settingSwitch setOn:NO];
        }
        cell = gc;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (IBAction)absentAct:(UISwitch *)sender {
    
    if ([[states objectAtIndex:0]isEqualToString:@"1"]) {
        [states replaceObjectAtIndex:0 withObject:@"0"];
        [states replaceObjectAtIndex:1 withObject:@"1"];
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"entryState"];
        [self.settingTable reloadData];
    }else{
        [states replaceObjectAtIndex:0 withObject:@"1"];
        [states replaceObjectAtIndex:1 withObject:@"0"];
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"entryState"];
        [self.settingTable reloadData];
    }
}

- (IBAction)presentAct:(UISwitch *)sender {
    if ([[states objectAtIndex:1]isEqualToString:@"1"]) {
        [states replaceObjectAtIndex:0 withObject:@"1"];
        [states replaceObjectAtIndex:1 withObject:@"0"];
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"entryState"];
        [self.settingTable reloadData];
        
    }else{
        [states replaceObjectAtIndex:0 withObject:@"0"];
        [states replaceObjectAtIndex:1 withObject:@"1"];
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"entryState"];
        [self.settingTable reloadData];
        
    }
}

@end
