//
//  schdleTableVW.m
//  studentRegistery
//
//  Created by macmini on 2/5/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "schdleTableVW.h"
#import "MMSpreadsheetView.h"
#import "MMGridCell.h"
#import "MMTopRowCell.h"
#import "MMLeftColumnCell.h"
#import "NSIndexPath+MMSpreadsheetView.h"

@interface schdleTableVW ()<MMSpreadsheetViewDataSource, MMSpreadsheetViewDelegate>{
    NSMutableArray *fcltySmmry,*monArr,*tueArr,*wedArr,*thrArr,*friArr,*satArr;
    NSArray * yearsId,*dayArr,*timeArr;
    NSString * btchId;
}
@property (nonatomic, strong) NSMutableSet *selectedGridCells;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSString *cellDataBuffer;

@end

@implementation schdleTableVW

- (void)viewDidLoad {
    [super viewDidLoad];
    fcltySmmry = [NSMutableArray new];
    monArr = [NSMutableArray new];
    tueArr = [NSMutableArray new];
    wedArr = [NSMutableArray new];
    thrArr = [NSMutableArray new];
    friArr = [NSMutableArray new];
    satArr = [NSMutableArray new];
    dayArr = [NSArray new];
    timeArr = [NSArray new];
    
    dayArr = @[@"MON",@"TUE",@"WED",@"THR",@"FRI",@"SAT"];
    timeArr = @[@"09:00 AM - 10:00 AM",@"10:00 AM - 11:00 AM",@"11:00 AM - 12:00 PM",@"12:00 PM - 01:00 PM",@"02:00 PM - 03:00 PM",@"03:00 PM - 04:00 PM",@"04:00 PM - 05:00 PM"];
    
//    NSDictionary* encrptData = [NSDictionary dictionaryWithObjects:@[@"1",@"1",@"1",@"1",@"1",@"0",@"1",@"1"] forKeys:@[@"Time",@"SubjectCode",@"RollName",@"SubjectName",@"HTNO",@"Status",@"Date",@"FacultyId"]];
//
//    [self->monArr addObject:encrptData];
//    [self->tueArr addObject:encrptData];
//    [self->wedArr addObject:encrptData];
//    [self->thrArr addObject:encrptData];
//    [self->friArr addObject:encrptData];
    
    NSString* facultyId = [[NSUserDefaults standardUserDefaults]valueForKey:@"facultyId"];
    
    [SVProgressHUD showWithStatus:@"Please Wait"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:1.0]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:27.0/255.0 green:47.0/255.0 blue:89.0/255.0 alpha:0.34]];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    NSString*req=[NSString stringWithFormat:@"%@%@",getScheduleTable,facultyId];
    
    [manager1 GET:[req stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        self->fcltySmmry = (NSMutableArray* )responseObject;
//        NSLog(@"Data:%@",rslt);
//        for (int p=0; p<rslt.count; p++) {
//            NSString * fct = [NSString stringWithFormat:@"%@",[[rslt objectAtIndex:p]objectForKey:@"FacultyId"]];
//            if ([fct isEqualToString:facultyId]) {
//                [self->fcltySmmry addObject:[rslt objectAtIndex:p]];
//            }
//
//        }
        
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
            
            NSLog(@"Wed:%@",self->wedArr);
            
            self.selectedGridCells = [NSMutableSet set];
            
            // Create the spreadsheet in code.
            MMSpreadsheetView *spreadSheetView = [[MMSpreadsheetView alloc] initWithNumberOfHeaderRows:1 numberOfHeaderColumns:1 frame:self.scheduleTableVW.bounds];
            self.restorationIdentifier = NSStringFromClass([self class]);
            spreadSheetView.restorationIdentifier = @"MMSpreadsheetView";
            spreadSheetView.layer.borderWidth = 1;
            
            // Register your cell classes.
            [spreadSheetView registerCellClass:[MMGridCell class] forCellWithReuseIdentifier:@"GridCell"];
            [spreadSheetView registerCellClass:[MMTopRowCell class] forCellWithReuseIdentifier:@"TopRowCell"];
            [spreadSheetView registerCellClass:[MMLeftColumnCell class] forCellWithReuseIdentifier:@"LeftColumnCell"];
            
            // Set the delegate & datasource for the spreadsheet view.
            spreadSheetView.delegate = self;
            spreadSheetView.dataSource = self;
            spreadSheetView.bounces = NO;
            
            // Add the spreadsheet view as a subview.
            [self.scheduleTableVW addSubview:spreadSheetView];
            
            [spreadSheetView reloadData];
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

- (CGSize)spreadsheetView:(MMSpreadsheetView *)spreadsheetView sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat leftColumnWidth = 80.0f;
    CGFloat topRowHeight = 30.0f;
    CGFloat gridCellWidth = 180.0f;
    CGFloat gridCellHeight = 150.0f;
    
    // Upper left.
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn == 0) {
        return CGSizeMake(leftColumnWidth, topRowHeight);
    }
    
    // Upper right.
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn == 1) {
        return CGSizeMake(gridCellWidth, topRowHeight);
    }
    
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn == 2) {
        return CGSizeMake(300.0f, topRowHeight);
    }
    
    // Lower left.
    if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn == 0) {
        return CGSizeMake(leftColumnWidth, gridCellHeight);
    }
    
    if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn == 1) {
        return CGSizeMake(gridCellWidth, gridCellHeight);
    }
    
    if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn == 2) {
        return CGSizeMake(300.0f, topRowHeight);
    }
    
    return CGSizeMake(300.0f, gridCellHeight);
}

- (NSInteger)numberOfRowsInSpreadsheetView:(MMSpreadsheetView *)spreadsheetView
{
    if (self->fcltySmmry.count>0) {
        return 7;
    }
    
    return 0;
}

- (NSInteger)numberOfColumnsInSpreadsheetView:(MMSpreadsheetView *)spreadsheetView
{
    if (self->fcltySmmry.count>0) {
    return 8;
    }
    return 0;
}

- (UICollectionViewCell *)spreadsheetView:(MMSpreadsheetView *)spreadsheetView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn == 0) {
        // Upper left.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
        MMGridCell *gc = (MMGridCell *)cell;
        gc.textLabel.text = @"DAY";
        gc.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        
    }else if (indexPath.mmSpreadsheetRow == 0 && indexPath.mmSpreadsheetColumn > 0) {
        // Upper right.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"TopRowCell" forIndexPath:indexPath];
        MMTopRowCell *tr = (MMTopRowCell *)cell;
        
        tr.textLabel.text = [timeArr objectAtIndex:indexPath.mmSpreadsheetColumn-1];
        
        tr.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        
    }
    else if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn == 0) {
        
        // Lower left.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"LeftColumnCell" forIndexPath:indexPath];
        MMLeftColumnCell *lc = (MMLeftColumnCell *)cell;
        
        lc.textLabel.text = [dayArr objectAtIndex:indexPath.mmSpreadsheetRow-1];
        
        BOOL isDarker = indexPath.mmSpreadsheetRow % 2 == 0;
        if (isDarker) {
            cell.backgroundColor = [UIColor colorWithRed:222.0f / 255.0f green:243.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:233.0f / 255.0f green:247.0f / 255.0f blue:252.0f / 255.0f alpha:1.0f];
        }
        
    }else if (indexPath.mmSpreadsheetRow > 0 && indexPath.mmSpreadsheetColumn > 0) {
        // Lower right.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
        MMGridCell *gc = (MMGridCell *)cell;
        if (indexPath.mmSpreadsheetRow==1) {
            
            if (indexPath.mmSpreadsheetColumn==1) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"09:00 AM - 10:00 AM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==2) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"10:00 AM - 11:00 AM "]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==3) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"11:00 AM - 12:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==4) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"12:00 PM - 01:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==5) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"02:00 PM - 03:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==6) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"03:00 PM - 04:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==7) {
                gc.textLabel.text = @"";
                for (int k=0; k<monArr.count; k++) {
                    if ([[[monArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"04:00 PM - 05:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[monArr objectAtIndex:k]objectForKey:@"empName"],[[monArr objectAtIndex:k]objectForKey:@"rollName"],[[monArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }
        }else if (indexPath.mmSpreadsheetRow==2) {
            
            if (indexPath.mmSpreadsheetColumn==1) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"09:00 AM - 10:00 AM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==2) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"10:00 AM - 11:00 AM "]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==3) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"11:00 AM - 12:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==4) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"12:00 PM - 01:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==5) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"02:00 PM - 03:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==6) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"03:00 PM - 04:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==7) {
                gc.textLabel.text = @"";
                for (int k=0; k<tueArr.count; k++) {
                    if ([[[tueArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"04:00 PM - 05:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[tueArr objectAtIndex:k]objectForKey:@"empName"],[[tueArr objectAtIndex:k]objectForKey:@"rollName"],[[tueArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }
        }else if (indexPath.mmSpreadsheetRow==3) {
            
            if (indexPath.mmSpreadsheetColumn==1) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"09:00 AM - 10:00 AM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==2) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"10:00 AM - 11:00 AM "]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==3) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"11:00 AM - 12:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==4) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"12:00 PM - 01:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==5) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"02:00 PM - 03:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==6) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"03:00 PM - 04:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==7) {
                gc.textLabel.text = @"";
                for (int k=0; k<wedArr.count; k++) {
                    if ([[[wedArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"04:00 PM - 05:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[wedArr objectAtIndex:k]objectForKey:@"empName"],[[wedArr objectAtIndex:k]objectForKey:@"rollName"],[[wedArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }
        }else if (indexPath.mmSpreadsheetRow==4) {
            
            if (indexPath.mmSpreadsheetColumn==1) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"09:00 AM - 10:00 AM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==2) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"10:00 AM - 11:00 AM "]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==3) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"11:00 AM - 12:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==4) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"12:00 PM - 01:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==5) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"02:00 PM - 03:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==6) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"03:00 PM - 04:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==7) {
                gc.textLabel.text = @"";
                for (int k=0; k<thrArr.count; k++) {
                    if ([[[thrArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"04:00 PM - 05:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[thrArr objectAtIndex:k]objectForKey:@"empName"],[[thrArr objectAtIndex:k]objectForKey:@"rollName"],[[thrArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }
        }else if (indexPath.mmSpreadsheetRow==5) {
            
            if (indexPath.mmSpreadsheetColumn==1) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"09:00 AM - 10:00 AM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==2) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"10:00 AM - 11:00 AM "]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==3) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"11:00 AM - 12:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==4) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"12:00 PM - 01:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==5) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"02:00 PM - 03:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==6) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"03:00 PM - 04:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==7) {
                gc.textLabel.text = @"";
                for (int k=0; k<friArr.count; k++) {
                    if ([[[friArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"04:00 PM - 05:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[friArr objectAtIndex:k]objectForKey:@"empName"],[[friArr objectAtIndex:k]objectForKey:@"rollName"],[[friArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }
            
        }else if (indexPath.mmSpreadsheetRow==6) {
            
            if (indexPath.mmSpreadsheetColumn==1) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"09:00 AM - 10:00 AM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==2) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"10:00 AM - 11:00 AM  "]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==3) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"11:00 AM - 12:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==4) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"12:00 PM - 01:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==5) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"02:00 PM - 03:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==6) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"03:00 PM - 04:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }else if (indexPath.mmSpreadsheetColumn==7) {
                gc.textLabel.text = @"";
                for (int k=0; k<satArr.count; k++) {
                    if ([[[satArr objectAtIndex:k]objectForKey:@"time"] isEqualToString:@"04:00 PM - 05:00 PM"]) {
                        gc.textLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@",[[satArr objectAtIndex:k]objectForKey:@"empName"],[[satArr objectAtIndex:k]objectForKey:@"rollName"],[[satArr objectAtIndex:k]objectForKey:@"subjectName"]];
                        gc.textLabel.numberOfLines=5;
                    }
                }
            }
        }
        
        BOOL isDarker = indexPath.mmSpreadsheetRow % 2 == 0;
        if (isDarker) {
            cell.backgroundColor = [UIColor colorWithRed:242.0f / 255.0f green:242.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:250.0f / 255.0f green:250.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
        }
    }
    
    return cell;
}

#pragma mark - MMSpreadsheetViewDelegate

- (void)spreadsheetView:(MMSpreadsheetView *)spreadsheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectedGridCells containsObject:indexPath]) {
        [self.selectedGridCells removeObject:indexPath];
        [spreadsheetView deselectItemAtIndexPath:indexPath animated:YES];
    } else {
        [self.selectedGridCells removeAllObjects];
        [self.selectedGridCells addObject:indexPath];
        [spreadsheetView deselectItemAtIndexPath:indexPath animated:YES];
    }
//    if (indexPath.mmSpreadsheetColumn==3) {
//
//        clgFaculty * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"clgFaculty"];
//        [[self navigationController] pushViewController:vc animated:YES];
//        vc.pgId = [[[fcltySmmry objectAtIndex:indexPath.mmSpreadsheetRow-1]objectForKey:@"ProgramId"]intValue];
//        vc.btchId = btchId;
//
//    }
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
