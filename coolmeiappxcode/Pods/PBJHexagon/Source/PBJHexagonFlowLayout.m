//
//  PBJHexagonFlowLayout.m
//
//  Created by Patrick Piemonte on 10/30/13.
//  Copyright (c) 2013-present, Patrick Piemonte, http://patrickpiemonte.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PBJHexagonFlowLayout.h"

CG_INLINE CGFloat CGFloat_nearbyint(CGFloat cgfloat) {
#if defined(__LP64__) && __LP64__
    return nearbyint(cgfloat);
#else
    return nearbyintf(cgfloat);
#endif
}

CG_INLINE CGFloat CGFloat_floor(CGFloat cgfloat) {
#if defined(__LP64__) && __LP64__
    return floor(cgfloat);
#else
    return floorf(cgfloat);
#endif
}

@interface PBJHexagonFlowLayout ()
{
    NSInteger _itemsPerRow;
}

@end

@implementation PBJHexagonFlowLayout

@synthesize itemsPerRow = _itemsPerRow;

#pragma mark - UICollectionViewLayout Subclass hooks

// func prepareLayout()
- (void)prepareLayout
{
    [super prepareLayout];
    
    if (_itemsPerRow == 0)
        _itemsPerRow = 4; // mudei de 4 pra 6
}


// func layoutAttributesForElementsInRect (rect: CGRect) -> NSArray
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [[NSMutableArray alloc] init];
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0 ; i < numberOfItems; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return layoutAttributes;
}

//- (void)setItemsPerRow:(NSInteger)itemsPerRow
// esse é o jeito estranho de objective C de escrever funções
// - (Tipo de retorno) nome da função : (Tipo do parâmetro) nome do parâmetro
// seria o equivalente a:
// func layoutAttributesForItemAtIndexPath (indexPath: NSIndexPath, nomeInternoDoSegundo: TipoDoSegundoArg) -> UICollectionViewLayoutAttributes
// andSegundoArgumento:(TipoDoSegundoArgumento *)nomeInternoDoArgumento
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = (NSInteger) CGFloat_nearbyint( CGFloat_floor(indexPath.row / _itemsPerRow) );
    NSInteger col = indexPath.row % _itemsPerRow;
  
    // isso desalinha as células ímpares (em 50% da sua largura) pra esquerda
    // jeito doido de escrever um if else (representado por ?), em swift seria:
    // var horiOffset: CGFloat!
    // if (row % 2 != 0) {
    //   horiOffset = 0
    // } else {
    //   horiOffset = self.itemSize.width * 0.5
    // }
    CGFloat horiOffset = ((row % 2) != 0) ? 0 : self.itemSize.width * 0.5f;
    CGFloat vertOffset = 0;
  
    // var attributes: UICollectionViewLayoutAttributes!
    // * indica que é por referência (ponteiro, vem de C)
    // Tipo *nome = UICollectionViewLayoutAttributes.layoutAttributesForCellWithIndexPath(indexPath)
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    attributes.center = CGPointMake( ( (col * self.itemSize.width) + (0.5f * self.itemSize.width) + horiOffset),
                                     ( ( (row * 0.90f) * self.itemSize.height) + (0.5f * self.itemSize.height) + vertOffset) );
  // mudei de: 0.75f pra 0.90f (aumentou o espaçamento entre as células)
    return attributes;
}


// func shouldInvalidateLayoutForBoundsChange (newBounds: CGRect) -> Bool
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

// func collectionViewContentSize() -> CGSize
- (CGSize)collectionViewContentSize
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];

    CGFloat contentWidth = self.collectionView.bounds.size.width;
    CGFloat contentHeight = ( ((numberOfItems / _itemsPerRow) * 0.75f) * self.itemSize.height) + (0.5f + self.itemSize.height);
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

@end
