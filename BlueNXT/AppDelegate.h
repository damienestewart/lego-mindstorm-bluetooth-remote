//
//  InquiryController.h
//  BlueNXT
//
//  Created by Damiene Stewart on 2/8/15.
//  Copyright (c) 2015 Damiene Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
@import IOBluetooth;

@interface AppDelegate : NSObject <IOBluetoothDeviceInquiryDelegate, IOBluetoothRFCOMMChannelDelegate>

@end
