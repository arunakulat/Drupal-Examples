//
//  DruaplNiPhoneDemoViewController.m
//  DruaplNiPhoneDemo
//
//  Created by Peter Harrington on 1/21/10.
//  Copyright Clean Micro, LLC 2010. All rights reserved.
//

#import "DruaplNiPhoneDemoViewController.h"

#define DRUPAL_URL @"http://www.heavisidelabs.com/?q=services/xmlrpc"
//if you are using clean URLs it's: 
//#define DRUPAL_URL @"http://www.yoursitename.com/services/xmlrpc"
#define USER_NAME @"jazzMaster0"
#define PASSWD @"asdfjkl"

@implementation DruaplNiPhoneDemoViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//  The process to execute a remote command is: 
	//  1. system.connect 
	//  2. user.login 
	//  3. desired command example: comment.loadNodeComments 
	//  4. user.logout
	//
	// create and execute XML-RPC request for method: system.connect to get sessid
	
	XMLRPCRequest *reqUserInfo = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:DRUPAL_URL]];
	
	int nodeToGrab = 4;  //sample node for demo
	
	
	 [reqUserInfo setMethod:@"system.connect" withObjects:[NSArray arrayWithObjects: nil]];
	 XMLRPCResponse *Response = [XMLRPCConnection sendSynchronousXMLRPCRequest:reqUserInfo];
	 NSString *source = [Response source];
	 NSLog(@"The system.connect response is: %@", source);
	 //trying out XMLRPCDecoder
	 //Response.data is the data from the response 
	 XMLRPCDecoder *responseDecoder = [[XMLRPCDecoder alloc] initWithData: [source dataUsingEncoding: NSUTF8StringEncoding] ];
	 NSDictionary *decodedResponse = [responseDecoder decode];
	 //NSLog(@"The decoded response looks like: %@",decodedResponse);
	 NSString *sessionID = [decodedResponse objectForKey:@"sessid"];
	 NSLog(@"The sessionID is: %@", sessionID);
	 
	//For user.login we need: hash, domain_name, domain_time_stamp, nonce, sessid, username, passwd
	//generate hash sha256
	
	 [reqUserInfo setMethod:@"user.login" withObjects:[NSArray arrayWithObjects:sessionID ,USER_NAME, PASSWD, nil]];
	 XMLRPCResponse *Response2 = [XMLRPCConnection sendSynchronousXMLRPCRequest:reqUserInfo];
	 NSString *source2 = [Response2 source];
	 NSLog(@"The user.login response is: %@", source2);

	//now fetch the comments
	//NSMutableDictionary *commentObj = [NSMutableDictionary dictionary];
	//[commentObj setObject:[NSNumber numberWithInt:[nodeID intValue]] forKey:@"nid"];
	
	
	//[reqUserInfo setMethod:@"comment.loadNodeComTerse" withObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:nodeToGrab], [NSNumber numberWithInt:10], [NSNumber numberWithInt:0],nil]];
	[reqUserInfo setMethod:@"comment.loadNodeComments" withObjects:[NSArray arrayWithObjects:sessionID, [NSNumber numberWithInt:nodeToGrab], [NSNumber numberWithInt:10], [NSNumber numberWithInt:0],nil]];
	XMLRPCResponse *Response3 = [XMLRPCConnection sendSynchronousXMLRPCRequest:reqUserInfo];
	NSString *source3 = [Response3 source];
	NSLog(@"the comment.loadNodeComTerse response is %@", source3);
	//XMLRPCDecoder *responseDecoder3 = [[XMLRPCDecoder alloc] initWithData: [source3 dataUsingEncoding: NSUTF8StringEncoding] ];
	//NSDictionary *decodedResponse3 = [responseDecoder3 decode];
	//NSLog(@"The decoded response looks like: %@",decodedResponse3);

  	
	 [reqUserInfo setMethod:@"user.logout" withObjects:[NSArray arrayWithObjects: sessionID, nil]];
	 XMLRPCResponse *Response4 = [XMLRPCConnection sendSynchronousXMLRPCRequest:reqUserInfo];
	 NSString *source4 = [Response4 source];
	 NSLog(@"The user.logout response is: %@", source4);
	 
	
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
