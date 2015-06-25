//
//  ViewController.m
//  LinkedInPractice
//
//  Created by Manish Kumar on 25/06/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "OAuthLoginView.h"
#import <UIKit/UIKit.h>

@interface ViewController (){
    OAuthLoginView *linkedInLoginView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)integrateLinkedInInTheApp:(id)sender {
    
    [self getProfileDetailsFromLinkedIn];
}



-(void)getProfileDetailsFromLinkedIn
{
    linkedInLoginView=[[OAuthLoginView alloc] init];
    linkedInLoginView.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailsOfProfile:) name:@"loginViewDidFinish" object:nil];
    [self presentViewController:linkedInLoginView animated:YES completion:nil];
}


-(void)showDetailsOfProfile:(NSNotification *)notification{
    
    NSDictionary *jsonResponse = notification.userInfo;
    
    NSLog(@"notification  : %@", notification.userInfo);
    
    NSString *position;
    NSString *company;
    if([jsonResponse objectForKey:@"positions"])
    {
        if ([[jsonResponse objectForKey:@"positions"] objectForKey:@"values"])
        {
            if([[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0])
            {
                if ([[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"title"])
                {
                    position=[[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"title"];
                }
                
                
                if ([[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"company"])
                {
                    
                    if ([[[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"company"]objectForKey:@"name"])
                    {
                        company=[[[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"company"]objectForKey:@"name"];
                    }
                }
            }
        }
    }
    
    NSString *_id;
    
    if ([jsonResponse objectForKey:@"id"])
    {
        _id=[jsonResponse objectForKey:@"id"];
    }
    
    
    NSString *profileUrl;
    
    if ([jsonResponse objectForKey:@"publicProfileUrl"])
    {
        profileUrl=[jsonResponse objectForKey:@"publicProfileUrl"];
    }
    
    NSString *email;
    if ([jsonResponse objectForKey:@"emailAddress"])
    {
        email=[jsonResponse objectForKey:@"emailAddress"];
    }
    
    NSString *industry;
    if ([jsonResponse objectForKey:@"industry"])
    {
        industry=[jsonResponse objectForKey:@"industry"];
    }
    
    NSString *pictureUrl;
    if ([jsonResponse objectForKey:@"pictureUrl"])
    {
        pictureUrl=[jsonResponse objectForKey:@"pictureUrl"];
    }
    
    
    NSString *biography;
    if ([jsonResponse objectForKey:@"summary"])
    {
        biography=[jsonResponse objectForKey:@"summary"];
    }
    
    
    NSString *location;
    if ([jsonResponse objectForKey:@"location"])
    {
        NSDictionary *locationDictionary = [jsonResponse objectForKey:@"location"];
        location = [locationDictionary objectForKey:@"name"];
        //location = [location substringToIndex:[location rangeOfString:@","].location];
    }
    
    NSString *twitterAccountName;
    if ([jsonResponse objectForKey:@"primaryTwitterAccount"])
    {
        if ([[jsonResponse objectForKey:@"primaryTwitterAccount"] objectForKey:@"providerAccountName"])
        {
            twitterAccountName=[[jsonResponse objectForKey:@"primaryTwitterAccount"] objectForKey:@"providerAccountName"];
        }
    }
    
    NSString *day;
    NSString *month;
    NSString *year;
    NSDate *dob ;
    if ([jsonResponse objectForKey:@"dateOfBirth"] ) {
        
        day = [[jsonResponse objectForKey:@"dateOfBirth"] objectForKey:@"day"];
        month = [[jsonResponse objectForKey:@"dateOfBirth"] objectForKey:@"month"];
        year = [[jsonResponse objectForKey:@"dateOfBirth"] objectForKey:@"year"];
        
        NSString *str ;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [formatter setTimeZone:gmt];
        str = [NSString stringWithFormat:@"%@/%@/%@ 00:00 AM",month,day,year];
        dob = [formatter dateFromString:str];
        
        
    }
    
    NSString *contactNumber;
    if ([jsonResponse objectForKey:@"phoneNumbers"]) {
        if ([[jsonResponse objectForKey:@"phoneNumbers"] objectForKey:@"values"]) {
            NSArray *arr = [[jsonResponse objectForKey:@"phoneNumbers"] objectForKey:@"values"];
            if ([arr count]>0) {
                NSDictionary *con = [arr objectAtIndex:0];
                contactNumber = [con objectForKey:@"phoneNumber"];
            }
        }
    }
}

@end
