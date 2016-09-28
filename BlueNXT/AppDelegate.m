//
//  InquiryController.m
//  BlueNXT
//
//  Created by Damiene Stewart on 2/8/15.
//  Copyright (c) 2015 Damiene Stewart. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)deviceInquiryStarted:(IOBluetoothDeviceInquiry *)sender {
    printf("Attempting device discovery.\n\n");
}

- (void)deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry *)sender
                          device:(IOBluetoothDevice *)device {
    printf("Found device, %s!\n", [device.name UTF8String]);
}

- (void)deviceInquiryComplete:(IOBluetoothDeviceInquiry *)sender
                        error:(IOReturn)error
                      aborted:(BOOL)aborted {
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    if (error == kIOReturnSuccess) {
        printf("Search completed successfully.\n\n");
    } else {
        printf("There was an issue.\n");
    }
}

@end
