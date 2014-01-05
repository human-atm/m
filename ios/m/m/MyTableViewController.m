//
//  MyViewController.m
//  m
//
//  Created by Andrew Rasmussen on 1/5/14.
//  Copyright (c) 2014 42 Technologies. All rights reserved.
//

#import "MyTableViewController.h"

#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>

@interface MyTableViewController ()

@property (nonatomic) FYXVisitManager *visitManager;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // initialize FYX
  [FYX setAppId:@"593d8898fd19159454e9c9758e719518f612502992c74b1a5dc6ced1aa17a7ca"
      appSecret:@"1f3a5a822dab7f40052225e49b44250eb7fafeb312af142bf894a18d051ebd93"
    callbackUrl:@"m://authcode"];
  [FYX startService:self];
  
  self.visitManager = [[FYXVisitManager alloc] init];
  self.visitManager.delegate = self;
  [self.visitManager start];
}

- (void)serviceStarted
{
  NSLog(@"Service Successfully Started");
}

- (void)startServiceFailed
{
  NSLog(@"Service Start Failed");
}

#pragma mark - FYX visit delegate

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI {
  if (![visit.transmitter.name isEqualToString:@"m beacon"]) {
    NSLog(@"Unknown beacon found named %@", visit.transmitter.name);
    return;
  }
  NSLog(@"%@", RSSI);
  /*
  
  Transmitter *transmitter = [self transmitterForID:visit.transmitter.identifier];
  if (!transmitter) {
    NSString *transmitterName = visit.transmitter.identifier;
    if(visit.transmitter.name){
      transmitterName = visit.transmitter.name;
    }
    transmitter = [Transmitter new];
    transmitter.identifier = visit.transmitter.identifier;
    transmitter.name = transmitterName;
    transmitter.lastSighted = [NSDate dateWithTimeIntervalSince1970:0];
    transmitter.rssi = [NSNumber numberWithInt:-100];
    transmitter.previousRSSI = transmitter.rssi;
    transmitter.batteryLevel = 0;
    transmitter.temperature = 0;
    [self addTransmitter:transmitter];
    [self.tableView reloadData];
  }
  
  transmitter.lastSighted = updateTime;
  if([self shouldUpdateTransmitterCell:visit withTransmitter:transmitter RSSI:RSSI]){
    [self updateTransmitter:transmitter withVisit:visit  RSSI:RSSI];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.transmitters indexOfObject:transmitter] inSection:0];
    for (UITableViewCell *cell in self.tableView.visibleCells) {
      if ([[self.tableView indexPathForCell:cell] isEqual:indexPath]) {
        SightingsTableViewCell *sightingsCell = (SightingsTableViewCell *)cell;
        
        CALayer *tempLayer = [sightingsCell.rssiImageView.layer presentationLayer];
        transmitter.previousRSSI =  [self rssiForBarWidth:[tempLayer frame].size.width];
        
        [self updateSightingsCell:sightingsCell withTransmitter:transmitter];
      }
    }
  }*/
}


@end
