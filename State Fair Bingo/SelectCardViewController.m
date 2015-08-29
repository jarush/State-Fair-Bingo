//
//  SelectCardViewController.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/29/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "SelectCardViewController.h"
#import "AppDelegate.h"

@interface SelectCardViewController ()
@property (nonatomic, retain) NSArray *cardNames;
@end

@implementation SelectCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select Card";
    
    self.cardNames = [[AppDelegate appDelegate] loadCardNames];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cardNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.cardNames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cardName = self.cardNames[indexPath.row];
    self.bingoCardViewController.squares = [[AppDelegate appDelegate] loadCardWithName:cardName];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
