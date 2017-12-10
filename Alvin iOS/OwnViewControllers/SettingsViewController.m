//
//  SettingsViewController.m
//  Alvin iOS
//
//  Created by Max on 10.12.17.
//  Copyright © 2017 Dynamic Devices AG. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController
{
    UIDatePicker *datePicker;
}

@synthesize myName;
@synthesize myEmailAddress;
@synthesize myBirthDate;
@synthesize myWeightKg;
@synthesize myHeightCm;
@synthesize myHeightSlider;
@synthesize myWeightSlider;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Make the textfield its own delegate
    self.myBirthDate.delegate = self;
    
    // Alloc/init your date picker, and set its initial date
    datePicker = [[UIDatePicker alloc]init];
    // Set mode
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[NSDate date]];     // This returns today's date
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1900];
   
    [datePicker setMinimumDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
    [datePicker setMaximumDate:[NSDate date]];
    
    // Update the textfield with the date everytime it changes with selector defined below
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // Set the datePicker as the input mode of your textfield
    [self.myBirthDate setInputView:datePicker];
    
    self.myHeightSlider.minimumValue = 140;
    self.myHeightSlider.maximumValue = 210;
    self.myWeightSlider.minimumValue = 25;
    self.myWeightSlider.maximumValue = 250;
    
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        NSString *name = [defaults stringForKey:@"Name"];
        NSString *emailAddress = [defaults stringForKey:@"EmailAddress"];
        NSString *birthDate = [defaults stringForKey:@"BirthDate"];
        NSString *heightCm = [defaults stringForKey:@"HeightCm"];
        NSString *weightKg = [defaults stringForKey:@"WeightKg"];
        
        if (name!=nil)
            [self.myName setText:name];
        if (emailAddress!=nil)
            [self.myEmailAddress setText:emailAddress];
        if (birthDate!=nil)
            [self.myBirthDate setText:birthDate];
        if (heightCm!=nil) {
            [self.myHeightCm setText:heightCm];
            self.myHeightSlider.value = [heightCm floatValue];
        }
        if (weightKg!=nil) {
            [self.myWeightKg setText:weightKg];
            self.myWeightSlider.value = [weightKg floatValue];
        }
    }
}

- (void) hideKeyboard
{
    [self.view endEditing:YES];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)myBirthDate.inputView;
    self.myBirthDate.text = [self formatDate:picker.date];
}

- (NSString *) formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

- (IBAction) heightSliderValueChanged:(id)sender
{
    self.myHeightCm.text = [NSString stringWithFormat:@"%d", (int)self.myHeightSlider.value];
}

- (IBAction) weightSliderValueChanged:(id)sender
{
    self.myWeightKg.text = [NSString stringWithFormat:@"%d", (int)self.myWeightSlider.value];
}

- (IBAction) storeSettings:(id)sender
{
    NSString *name = self.myName.text;
    NSString *emailAddress = self.myEmailAddress.text;
    NSString *birthDate = self.myBirthDate.text;
    NSString *heightCm = self.myHeightCm.text;
    NSString *weightKg = self.myWeightKg.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (defaults) {
        [defaults setValue:name forKey:@"Name"];
        [defaults setValue:emailAddress forKey:@"EmailAddress"];
        [defaults setValue:birthDate forKey:@"BirthDate"];
        [defaults setValue:heightCm forKey:@"HeightCm"];
        [defaults setValue:weightKg forKey:@"WeightKg"];
        
        // Make sure these values are saved immediately
        [defaults synchronize];
    }
}

@end
