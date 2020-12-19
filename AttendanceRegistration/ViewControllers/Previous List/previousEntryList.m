//
//  previousEntryList.m
//  studentRegistery
//
//  Created by macmini on 1/18/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "previousEntryList.h"
#import "RSDFDatePickerView.h"
#import "previousEntryDetails.h"


@interface previousEntryList ()<RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource>

@property (copy, nonatomic) NSArray *datesToMark;
@property (copy, nonatomic) NSDictionary *statesOfTasks;
@property (copy, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) RSDFDatePickerView *datePickerView;
@property (copy, nonatomic) UIColor *completedTasksColor;
@property (copy, nonatomic) UIColor *uncompletedTasksColor;
@property (copy, nonatomic) NSDate *today;


@end

@implementation previousEntryList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.opaque = YES;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.0f];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    
//    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
    
    NSDateComponents *todayComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [self.calendar dateFromComponents:todayComponents];
    [self.datePickerView selectDate:today];

    [self.view addSubview:self.datePickerView];
    
}

#pragma mark - Custom Accessors

- (void)setCalendar:(NSCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
        
        self.title = [_calendar.calendarIdentifier capitalizedString];
    }
}

- (NSArray *)datesToMark
{
    if (!_datesToMark) {
        NSArray *numberOfDaysFromToda = @[@(-8), @(-2), @(-1), @(0), @(2), @(4), @(8), @(13), @(22)];
        
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        NSMutableArray *datesToMark = [[NSMutableArray alloc] initWithCapacity:[numberOfDaysFromToda count]];
   
        for (int p=0; p<numberOfDaysFromToda.count; p++) {
            dateComponents.day = [[numberOfDaysFromToda objectAtIndex:p] integerValue];
            NSDate *date = [self.calendar dateByAddingComponents:dateComponents toDate:self.today options:0];
            [datesToMark addObject:date];
            
        }
        
        _datesToMark = [datesToMark copy];
    }
    return _datesToMark;
}

- (NSDictionary *)statesOfTasks
{
    if (!_statesOfTasks) {
        NSMutableDictionary *statesOfTasks = [[NSMutableDictionary alloc] initWithCapacity:[self.datesToMark count]];
        [self.datesToMark enumerateObjectsUsingBlock:^(NSDate *date, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL isCompletedAllTasks = NO;
            if ([date compare:self.today] == NSOrderedAscending) {
                isCompletedAllTasks = YES;
            }
            statesOfTasks[date] = @(isCompletedAllTasks);
        }];
        
        _statesOfTasks = [statesOfTasks copy];
    }
    return _statesOfTasks;
}

- (NSDate *)today
{
    if (!_today) {
        NSDateComponents *todayComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
        _today = [self.calendar dateFromComponents:todayComponents];
    }
    return _today;
}

- (UIColor *)completedTasksColor
{
    if (!_completedTasksColor) {
        _completedTasksColor = [UIColor colorWithRed:83/255.0f green:215/255.0f blue:105/255.0f alpha:1.0f];
    }
    return _completedTasksColor;
}

- (UIColor *)uncompletedTasksColor
{
    if (!_uncompletedTasksColor) {
        _uncompletedTasksColor = [UIColor colorWithRed:184/255.0f green:184/255.0f blue:184/255.0f alpha:1.0f];
    }
    return _uncompletedTasksColor;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setCalendar:self.calendar];
        [_dateFormatter setLocale:[self.calendar locale]];
        [_dateFormatter setDateStyle:NSDateFormatterFullStyle];
    }
    return _dateFormatter;
}

- (RSDFDatePickerView *)datePickerView
{
    if (!_datePickerView) {
//        _datePickerView = [[RSDFDatePickerView alloc] initWithFrame:self.view.bounds calendar:self.calendar];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        [comps setMonth:-2];
        NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
        
        _datePickerView = [[RSDFDatePickerView alloc] initWithFrame:self.view.bounds calendar:self.calendar startDate:minDate endDate:[NSDate date]];
                           
        _datePickerView.delegate = self;
        _datePickerView.dataSource = self;
        _datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _datePickerView;
}


#pragma mark - RSDFDatePickerViewDelegate

- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    NSDate *today = [NSDate date]; // it will give you current date
    NSDate *newDate = date; // your date
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:newDate]; // comparing two dates
    
    if(result==NSOrderedAscending){
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"No data found for future date." delegate:nil cancelButtonTitle:@":D" otherButtonTitles:nil] show];
        
    }else if(result==NSOrderedDescending){
        [[NSUserDefaults standardUserDefaults]setValue:newDate forKey:@"daySelect"];
        
        previousEntryDetails * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"previousEntryDetails"];
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    
}

#pragma mark - RSDFDatePickerViewDataSource

- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    if (view == self.datePickerView) {
        return YES;
    }
    
    if ([self.today compare:date] == NSOrderedDescending) {
        return NO;
    }
    
    return YES;
}

- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    if (view == self.datePickerView) {
        return YES;
    }
    
    if ([self.today compare:date] == NSOrderedDescending) {
        return NO;
    }
    
    return YES;
}

- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    return 0;
    
}

- (UIColor *)datePickerView:(RSDFDatePickerView *)view markImageColorForDate:(NSDate *)date
{
    if (![self.statesOfTasks[date] boolValue]) {
        return self.uncompletedTasksColor;
    } else {
        return self.completedTasksColor;
    }
}

- (IBAction)todayAct:(UIBarButtonItem *)sender {
    if (!self.datePickerView.hidden) {
        [self.datePickerView scrollToToday:YES];
    }
}

@end
