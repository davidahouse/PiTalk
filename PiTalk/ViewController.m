//
//  ViewController.m
//  PiTalk
//
//  Created by David House on 8/24/12.
//  Copyright (c) 2012 Random Accident. All rights reserved.
//

#import "ViewController.h"

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

@interface ViewController ()

@end

@implementation ViewController
@synthesize pin1;
@synthesize pin2;
@synthesize pin3;
@synthesize pin4;
@synthesize pin5;
@synthesize pin6;
@synthesize pin7;
@synthesize pin8;
@synthesize pin9;
@synthesize pin10;
@synthesize pin11;
@synthesize pin12;
@synthesize pin13;
@synthesize pin14;
@synthesize pin15;
@synthesize pin16;
@synthesize pin17;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    socketQueue = dispatch_queue_create("socketQueue", NULL);
    
    listenSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:socketQueue];
    
    // Setup an array to store all accepted client connections
    connectedSockets = [[NSMutableArray alloc] initWithCapacity:1];
    
    int port = 2345;
    NSError *error = nil;
    if(![listenSocket acceptOnPort:port error:&error])
    {
        NSLog(@"error starting server %@",error);
        return;
    }
}


- (void)viewDidUnload
{
    [self setPin1:nil];
    [self setPin2:nil];
    [self setPin3:nil];
    [self setPin4:nil];
    [self setPin5:nil];
    [self setPin6:nil];
    [self setPin7:nil];
    [self setPin8:nil];
    [self setPin9:nil];
    [self setPin10:nil];
    [self setPin11:nil];
    [self setPin12:nil];
    [self setPin13:nil];
    [self setPin14:nil];
    [self setPin15:nil];
    [self setPin16:nil];
    [self setPin17:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
	// This method is executed on the socketQueue (not the main thread)
	
	@synchronized(connectedSockets)
	{
		[connectedSockets addObject:newSocket];
	}
	
	NSString *host = [newSocket connectedHost];
	UInt16 port = [newSocket connectedPort];
	
    NSLog(@"Accepted client %@:%hu", host, port);
	
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
	if (sock != listenSocket)
	{
        NSLog(@"client disconnected");
		
		@synchronized(connectedSockets)
		{
			[connectedSockets removeObject:sock];
		}
	}
}


- (IBAction)pinChange:(id)sender {
    
    // prepare the message to send to the Pi
    NSString *msg = @"";
    
    msg = [msg stringByAppendingString:pin1.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin2.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin3.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin4.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin5.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin6.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin7.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin8.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin9.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin10.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin11.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin12.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin13.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin14.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin15.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin16.on ? @"1" : @"0"];
    msg = [msg stringByAppendingString:pin17.on ? @"1" : @"0"];
    
    NSData *msgData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    for ( GCDAsyncSocket *socket in connectedSockets ) {
        [socket writeData:msgData withTimeout:1 tag:0];
    }
}
@end
