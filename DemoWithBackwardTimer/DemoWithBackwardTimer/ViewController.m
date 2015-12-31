//
//  ViewController.m
//  DemoWithBackwardTimer
//
//  Created by lister on 15/12/31.
//  Copyright (c) 2015年 hongwing.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *_dataWithHour;
    NSMutableArray *_dataWithMinite;
    NSTimer *_timer;
    NSDate *_standardTime;
    NSDate *_destTime;
    NSString *hours;
    NSString *minites;
    NSString *seconds;
    BOOL _isEndWithCountDown;
}

/**
 *  PickerView Delefate
 *
 *  @param NSString <#NSString description#>
 *
 *  @return
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2; // 2列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [_dataWithHour count];
    }else
    {
        return [_dataWithMinite count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [_dataWithHour objectAtIndex:row];
    }else
    {
        return [_dataWithMinite objectAtIndex:row];
    }
}

// 获得需要显示在label上的时间
- (NSString *)getNeedToDisplayTime
{
    // NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // [formatter setDateFormat:@"HH:mm:ss"];
    // 目标时间
    _standardTime = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:_standardTime toDate:_destTime options:0];
    
    if (([comp hour])< 10 )
    {
        hours = [NSString stringWithFormat:@"0%d",[comp hour]];
    }
    else
    {
        hours = [NSString stringWithFormat:@"%d",[comp hour]];
    }
    
    if (([comp minute])< 10 )
    {
        minites = [NSString stringWithFormat:@"0%d",[comp minute]];
    }
    else
    {
        minites = [NSString stringWithFormat:@"%d",[comp minute]];
    }
    
    if (([comp second])< 10 )
    {
        seconds = [NSString stringWithFormat:@"0%d",[comp second]];
    }
    else
    {
        seconds = [NSString stringWithFormat:@"%d",[comp second]];
    }
    _isEndWithCountDown = ( ([comp hour] == 0) && ([comp minute] == 0) && ([comp second] == 0));
    return [NSString stringWithFormat:@"%@ : %@ : %@",hours,minites,seconds];
}

// 获取picker的时间
- (NSDate *)getDestTime
{
    int hour = [self.datePicker selectedRowInComponent:0];
    int minite = [self.datePicker selectedRowInComponent:1];
    
    return  [NSDate dateWithTimeInterval:(hour * 3600 + minite * 60 + 1)
                               sinceDate:[NSDate date]];
}

// 开始计时
- (IBAction)startCountDown:(id)sender
{
    _destTime = [self getDestTime];
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(displayLabel)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)tipsShow
{
    UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"Tips"
                                                    message:@"Countdown is end !"
                                                   delegate:nil
                                          cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)displayLabel
{
    if (_isEndWithCountDown)
    {
        [_timer invalidate];
        _timer = nil;
        _isEndWithCountDown = FALSE;
        [self tipsShow];
    }
    else
    {
        self.labelToDisplay.text = [self getNeedToDisplayTime];
    }
}

- (void)initialDataSource
{
    _dataWithHour = [[NSMutableArray alloc] initWithCapacity:13];
    _dataWithMinite = [[NSMutableArray alloc] initWithCapacity:60];
    
    for (int i = 0 ; i < 13 ; i++)
    {
        if (i < 2)
        {
            [_dataWithHour addObject:[NSString stringWithFormat:@"%d  Hour",i]];
        }else
        {
            [_dataWithHour addObject:[NSString stringWithFormat:@"%d  Hours",i]];
        }
    }
    
    for (int i = 0 ; i < 60 ; i++)
    {
        [_dataWithMinite addObject:[NSString stringWithFormat:@"%d  Minute",i]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.datePicker selectRow:25 inComponent:1 animated:YES];
    self.labelToDisplay.text = @"00 : 00 : 00";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialDataSource];
    // 初始化计时 “结束指针”
    _isEndWithCountDown = FALSE;
    self.datePicker.delegate = self;
    self.datePicker.dataSource = self;
}

@end
