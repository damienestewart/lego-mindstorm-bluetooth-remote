//
//  ChannelDelegate.m
//  BlueNXT
//
//  Created by Damiene Stewart on 2/21/15.
//  Copyright (c) 2015 Damiene Stewart. All rights reserved.
//

#import "ChannelDelegate.h"

@implementation ChannelDelegate

-(void)rfcommChannelClosed:(IOBluetoothRFCOMMChannel *)rfcommChannel {
    printf("Closed complete.\n");
}

-(void)rfcommChannelOpenComplete:(IOBluetoothRFCOMMChannel *)rfcommChannel status:(IOReturn)error {
    printf("Open complete.\n");
}

-(void)rfcommChannelData:(IOBluetoothRFCOMMChannel *)rfcommChannel data:(void *)dataPointer length:(size_t)dataLength {
    printf("Data?\n");
}

-(void)rfcommChannelWriteComplete:(IOBluetoothRFCOMMChannel *)rfcommChannel refcon:(void *)refcon status:(IOReturn)error {
    printf("Write complete.\n");
}

@end
