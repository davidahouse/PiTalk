//
//  ViewController.h
//  PiTalk
//
//  Created by David House on 8/24/12.
//  Copyright (c) 2012 Random Accident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface ViewController : UIViewController {
    dispatch_queue_t socketQueue;
	
	GCDAsyncSocket *listenSocket;
	NSMutableArray *connectedSockets;

}
@property (weak, nonatomic) IBOutlet UISwitch *pin1;
@property (weak, nonatomic) IBOutlet UISwitch *pin2;
@property (weak, nonatomic) IBOutlet UISwitch *pin3;
@property (weak, nonatomic) IBOutlet UISwitch *pin4;
@property (weak, nonatomic) IBOutlet UISwitch *pin5;
@property (weak, nonatomic) IBOutlet UISwitch *pin6;
@property (weak, nonatomic) IBOutlet UISwitch *pin7;
@property (weak, nonatomic) IBOutlet UISwitch *pin8;
@property (weak, nonatomic) IBOutlet UISwitch *pin9;
@property (weak, nonatomic) IBOutlet UISwitch *pin10;
@property (weak, nonatomic) IBOutlet UISwitch *pin11;
@property (weak, nonatomic) IBOutlet UISwitch *pin12;
@property (weak, nonatomic) IBOutlet UISwitch *pin13;
@property (weak, nonatomic) IBOutlet UISwitch *pin14;
@property (weak, nonatomic) IBOutlet UISwitch *pin15;
@property (weak, nonatomic) IBOutlet UISwitch *pin16;
@property (weak, nonatomic) IBOutlet UISwitch *pin17;

- (IBAction)pinChange:(id)sender;
@end
