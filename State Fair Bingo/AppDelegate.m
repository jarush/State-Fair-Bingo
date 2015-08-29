//
//  AppDelegate.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/28/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "AppDelegate.h"
#import "BingoCardViewController.h"
#import "Square.h"

@interface AppDelegate ()
@property (nonatomic, retain) BingoCardViewController *bingoViewController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *squares = [self loadCurrentGame];
    if (squares == nil) {
        squares = [self loadCardWithName:@"card1"];
    }
    
    self.bingoViewController = [[BingoCardViewController alloc] initWithSquares:squares];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.bingoViewController];
    navigationController.navigationBar.translucent = NO;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveCurrentGame:self.bingoViewController.squares];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self saveCurrentGame:self.bingoViewController.squares];
}

+ (AppDelegate *)appDelegate {
    return [[UIApplication sharedApplication] delegate];
}

- (NSArray *)loadCardNames {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    return [[dict allKeys] sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2];
    }];
}

- (NSArray *)loadCardWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *array = (NSArray *)[dict objectForKey:name];

    NSMutableArray *squares = [NSMutableArray array];
    for (NSString *text in array) {
        [squares addObject:[[Square alloc] initWithText:text]];
    }

    return squares;
}

- (NSArray *)loadCurrentGame {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGame"];
    if (data == nil) {
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)saveCurrentGame:(NSArray *)squares {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:squares];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentGame"];
}

@end
