//
//  BingoCardViewController.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/28/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "BingoCardViewController.h"
#import "SelectCardViewController.h"
#import "AppDelegate.h"
#import "HeaderView.h"
#import "SquareCell.h"
#import "Square.h"

#define NUM_ROWS    5
#define NUM_COLS    5
#define NUM_SQUARES (NUM_ROWS * NUM_COLS)

@implementation BingoCardViewController

static NSString * const kHeaderReuseIdentifier = @"HeaderView";
static NSString * const kCellReuseIdentifier = @"Cell";

- (instancetype)initWithSquares:(NSArray *)squares {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self) {
        self.title = @"Bingo!";
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(selectCard)];

        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.allowsMultipleSelection = YES;

        [self.collectionView registerClass:[SquareCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
        [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseIdentifier];

        CGFloat squareSize = self.collectionView.bounds.size.width / NUM_ROWS;
        CGFloat headerSize = (self.collectionView.bounds.size.height - (squareSize * 5)) / 2.0f;
        ((UICollectionViewFlowLayout *)self.collectionViewLayout).headerReferenceSize = CGSizeMake(0, headerSize);

        _squareStampedColor = [UIColor colorWithRed:34/255.0f green:189/255.0f blue:34/255.0f alpha:1.0f];
        _squares = squares;
    }
    return self;
}

- (void)setSquares:(NSArray *)squares {
    _squares = squares;

    // Make sure the free cell is selected
    ((Square *)_squares[12]).selected = YES;

    [self.collectionView reloadData];
}

- (void)selectCard {
    SelectCardViewController *selectCardViewController = [[SelectCardViewController alloc] initWithStyle:UITableViewStylePlain];
    selectCardViewController.bingoCardViewController = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:selectCardViewController];
    
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (BOOL)checkColumns {
    for (int col = 0; col < NUM_COLS; col++) {
        BOOL bingo = YES;
        for (int i = col; i < NUM_SQUARES; i += NUM_COLS) {
            bingo &= ((Square *)self.squares[i]).selected;
        }
        
        if (bingo) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)checkRows {
    for (int row = 0; row < NUM_ROWS; row++) {
        BOOL bingo = YES;
        for (int i = row * NUM_COLS; i < (row + 1) * NUM_COLS; i++) {
            bingo &= ((Square *)self.squares[i]).selected;
        }
        
        if (bingo) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)checkDiagonal {
    BOOL bingo = YES;
    for (int i = 0; i < NUM_SQUARES; i += NUM_COLS + 1) {
        bingo &= ((Square *)self.squares[i]).selected;
    }
    
    if (bingo) {
        return YES;
    }

    bingo = YES;
    for (int i = NUM_COLS - 1; i < NUM_SQUARES - 1; i += NUM_COLS - 1) {
        bingo &= ((Square *)self.squares[i]).selected;
    }
    
    if (bingo) {
        return YES;
    }
    
    return NO;
}

- (void)checkIfWinner {
    BOOL bingo = [self checkColumns] || [self checkRows] || [self checkDiagonal];
    if (bingo) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bingo!" message:nil delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NUM_SQUARES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseIdentifier forIndexPath:indexPath];
        reusableview = headerView;
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareCell *squareCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Square *square = self.squares[indexPath.row];
    
    squareCell.label.text = square.text;
    squareCell.selected = square.selected;
    squareCell.backgroundColor = square.selected ? self.squareStampedColor : self.collectionView.backgroundColor;

    return squareCell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat squareSize = self.collectionView.bounds.size.width / NUM_ROWS;
    return CGSizeMake(squareSize, squareSize);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 12;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 12;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ((Square *)self.squares[indexPath.row]).selected = YES;
    
    SquareCell *squareCell = (SquareCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    squareCell.backgroundColor = self.squareStampedColor;
    
    [self checkIfWinner];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ((Square *)self.squares[indexPath.row]).selected = NO;
    
    SquareCell *squareCell = (SquareCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    squareCell.backgroundColor = self.collectionView.backgroundColor;
}

@end
