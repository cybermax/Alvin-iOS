//
//  ViewController.m
//  Alvin iOS
//
//  Created by Max on 06.12.17.
//  Copyright © 2017 Dynamic Devices AG. All rights reserved.
//

#import "MainViewController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"

@implementation MainViewController

- (void) viewDidLoad
{    
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) scanAction:(id)sender
{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else {
        UIAlertController *alertController = [UIAlertController
                            alertControllerWithTitle:@"Error"
                            message:@"Reader not support by current device"
                            preferredStyle: UIAlertControllerStyleAlert];
        // Add button
        UIAlertAction *button = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:button];
        // Get pointer to app delegate, its main window and eventually to the rootViewController
        UIViewController *presentingController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [presentingController presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - QRCodeReader Delegate Methods

- (void) reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning];
    
    /*
       1. Extract:
          - server IP address + port (string of the form ADDRESS:PORT)
          - base64 encoded string (date + Allegro serial number)
       2. 
    */
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Success"
                                              message:result
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *button = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:button];
        // Get pointer to app delegate, its main window and eventually to the rootViewController
        UIViewController *presentingController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [presentingController presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void) readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
