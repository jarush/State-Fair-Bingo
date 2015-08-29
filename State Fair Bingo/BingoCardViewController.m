//
//  BingoCardViewController.m
//  State Fair Bingo
//
//  Created by Jason Rush on 8/28/15.
//  Copyright (c) 2015 Jason Rush. All rights reserved.
//

#import "BingoCardViewController.h"
#import "HeaderView.h"
#import "SquareCell.h"
#import "Square.h"

#define NUM_SQUARES_ROW 5
#define NUM_SQUARES_COL 5
#define NUM_SQUARES     (NUM_SQUARES_ROW * NUM_SQUARES_COL)

@interface BingoCardViewController ()

@end

@implementation BingoCardViewController

static NSString * const kHeaderReuseIdentifier = @"HeaderView";
static NSString * const kCellReuseIdentifier = @"Cell";

- (instancetype)initWithSquares:(NSArray *)squares {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self) {
        self.title = @"Bingo!";

        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.allowsMultipleSelection = YES;

        [self.collectionView registerClass:[SquareCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
        [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseIdentifier];

        CGFloat squareSize = self.collectionView.bounds.size.width / NUM_SQUARES_ROW;
        CGFloat headerSize = (self.collectionView.bounds.size.height - (squareSize * 5)) / 2.0f;
        ((UICollectionViewFlowLayout *)self.collectionViewLayout).headerReferenceSize = CGSizeMake(0, headerSize);

        self.squareStampedColor = [UIColor colorWithRed:34/255.0f green:189/255.0f blue:34/255.0f alpha:1.0f];
        self.squares = squares;

        // Make sure the free cell is selected
        ((Square *)self.squares[12]).selected = YES;
    }
    return self;
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
    CGFloat squareSize = self.collectionView.bounds.size.width / NUM_SQUARES_ROW;
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
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ((Square *)self.squares[indexPath.row]).selected = NO;
    
    SquareCell *squareCell = (SquareCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    squareCell.backgroundColor = self.collectionView.backgroundColor;
}

@end
