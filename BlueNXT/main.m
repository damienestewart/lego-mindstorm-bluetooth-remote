// BlueNXT project.
//
//  Created by Damiene Stewart on 2/8/15.
//  Copyright (c) 2015 Damiene Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ChannelDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        // Here we're going to check if the radio is on.
        // if it is not, we're going to exit.
        
        IOBluetoothHostController *hostController = [IOBluetoothHostController defaultController];
        
        if (![hostController powerState]) {
            printf("Your bluetooth radio is off. Turn it on and try again.\n");
            exit(1);
        }
        
        // Search for devices in the area. Delegate methods will update
        // us appropriately.
        
        AppDelegate *delegate = [[AppDelegate alloc] init];
        
        IOBluetoothDeviceInquiry *inq = [IOBluetoothDeviceInquiry inquiryWithDelegate:delegate];
        [inq start];
        
        CFRunLoopRun(); // Begin a run loop to allow asynchronous searching.
        
        // Have devices been discovered?
        
        if ([inq.foundDevices count] == 0) {
            printf("No bluetooth devices have been discovered. Ensure that the other device"
                   " has it's radio enabled.\n\n");
            exit(0);
        } else {
            // Devices have been discovered.
            // Does the user want to connect to a device?
            printf("Which device would you like to connect to? 'q' to quit.\n\n");
            
            for (int i = 0; i < [inq.foundDevices count]; i++)
                printf("%d: %s\n", i+1, [[inq.foundDevices[i] name] UTF8String]);
        }
        
        int connectTo = 0;

        printf("\nEnter device number: ");
        scanf("%d", &connectTo);
        
        // Quit.
        if (connectTo == 0) {
            exit(0);
        }
        
        IOBluetoothDevice *device = inq.foundDevices[connectTo-1];
        ChannelDelegate *channel = [[ChannelDelegate alloc] init];
        
        // Open connection to the device.
        IOBluetoothRFCOMMChannel *rf = [[IOBluetoothRFCOMMChannel alloc] init];
        [device openRFCOMMChannelSync:&rf withChannelID:1 delegate:channel];
        
        if (![device isConnected]) {
            printf("\nUnsuccessful connection.\n");
            exit(2);
        }
        
        printf("\nSuccessful connection made.\n\n");
        
        char *input = malloc(sizeof(char) * 20);
        fgets(input, 20, stdin);
        
        input[strlen(input) - 1] = '\0';
        
        while (strcmp(input, "q")) {
            
            
            
            if (!strcmp(input, "beep")) {
                char comm[8] = {0x06, 0x00, 0x80, 0x03, 0x0B, 0x02, 0xF4, 0x01};
                [rf writeSync:comm length:8];
            } else if (!strcmp(input, "move forward")) {
                char comm[28] = {0x0C, 0x00, 0x00, 0x04, 0x00, 0x64,
                    0x05, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x04, 0x02, 0x64,
                    0x05, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00};
                
                [rf writeSync:comm length:28];
            } else if (!strcmp(input, "stop")) {
                char comm[28] = {0x0C, 0x00, 0x00, 0x04, 0x00, 0x00,
                    0x05, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x04, 0x02, 0x00,
                    0x05, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00};
                
                [rf writeSync:comm length:28];
            } else if (!strcmp(input, "reverse")) {
                char comm[28] = {0x0C, 0x00, 0x00, 0x04, 0x00, 0x9C,
                    0x05, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x04, 0x02, 0x9C,
                    0x05, 0x02, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00};
                
                [rf writeSync:comm length:28];
            }
            
            printf("#> ");
            fgets(input, 20, stdin);

            input[strlen(input) - 1] = '\0';
        }
        
        [rf closeChannel];
        [device closeConnection];
        
    return 0;
    }
}
