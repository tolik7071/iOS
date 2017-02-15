//
//  Paginator.m
//  Wonderland
//
//  Created by Anatoliy Goodz on 8/26/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "Paginator.h"

@interface Paginator ()
{
    NSInteger _charCount;
    NSDictionary<NSString*, id> *_attributes;
    NSMutableArray<NSValue *> *_ranges;
    NSInteger _lastPageWithContent;
}

@end

@implementation Paginator

- (instancetype)initWithFont:(UIFont *)font
{
    self = [super init];
    
    if (self != nil)
    {
        _font = font;
        _lastPageWithContent = 1;
        _ranges = [[NSMutableArray alloc] init];
        _viewSize = CGSizeMake(100, 500);
    }
    
    return self;
}

- (void)setViewSize:(CGSize)viewSize
{
    if (!CGSizeEqualToSize(_viewSize, viewSize))
    {
        memcpy(&_viewSize, &viewSize, sizeof(viewSize));
        
        [self resetPages];
    }
}

- (void)resetPages
{
    [_ranges removeAllObjects];
    _lastPageWithContent = 1;
}

- (void)setBookText:(NSString *)bookText
{
    if (_bookText != bookText)
    {
        _bookText = bookText;
        _charCount = self.bookText.length;
        [self resetPages];
    }
}

- (void)setFont:(UIFont *)font
{
    if (_font != font)
    {
        _font = font;
        _attributes = nil;
        [self resetPages];
    }
}

- (NSDictionary<NSString *,id> *)fontAttrs
{
    if (_attributes == nil)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        _attributes = @{
            NSFontAttributeName : self.font,
            NSParagraphStyleAttributeName : paragraphStyle
        };
    }
    
    return _attributes;
}

- (NSInteger)lastKnownPage
{
    return _lastKnownPage;
}

- (NSRange)rangeOfTextForPage:(NSInteger)page
{
    if (_ranges.count >= page)
    {
        return [(NSValue *)_ranges[page - 1] rangeValue];
    }
    
    __block CGSize constraintSize = self.viewSize;
    __block CGFloat targetHeight = constraintSize.height;
    constraintSize.height = 32000;
    
    __block NSRange textRange = { 0 };
    
    if (page != 1)
    {
        textRange.location = NSMaxRange([self rangeOfTextForPage:(page - 1)]);
    }
    
    textRange.length = _charCount - textRange.location;
    __block BOOL firstParagraph = YES;
    __block BOOL needsTrimming = NO;
    
    [self.bookText enumerateSubstringsInRange:textRange
        options:NSStringEnumerationByLines
        usingBlock:^(
             NSString * _Nullable substring,    // _
             NSRange substringRange,
             NSRange enclosingRange,            // _
             BOOL * _Nonnull stop)
    {
        if (firstParagraph)
        {
            textRange = substringRange;
            firstParagraph = NO;
        }
        else
        {
            textRange.length = NSMaxRange(substringRange) - textRange.location;
        }
        
        NSString *testText = [self.bookText substringWithRange:textRange];
        CGRect textBound = [testText boundingRectWithSize:constraintSize
            options:NSStringDrawingUsesLineFragmentOrigin
            attributes:self.fontAttrs
            context:[[NSStringDrawingContext alloc] init]];
        
        if (textBound.size.height > targetHeight)
        {
            needsTrimming = YES;
            *stop = YES;
        }
    }];
    
    if (needsTrimming)
    {
        [self.bookText enumerateSubstringsInRange:textRange
            options:(NSStringEnumerationByWords | NSStringEnumerationReverse)
            usingBlock:^(
                NSString * _Nullable substring,    // _
                NSRange substringRange,            // _
                NSRange enclosingRange,
                BOOL * _Nonnull stop)
         {
             textRange.length = enclosingRange.location - textRange.location;
             NSString *testText = [self.bookText substringWithRange:textRange];
             CGRect textBound = [testText boundingRectWithSize:constraintSize
                options:NSStringDrawingUsesLineFragmentOrigin
                attributes:self.fontAttrs
                context:[[NSStringDrawingContext alloc] init]];
             
             if (textBound.size.height <= targetHeight)
             {
                 *stop = YES;
             }
         }];
    }
    
    if (textRange.length != 0)
    {
        _lastPageWithContent = page;
    }
    
    [_ranges addObject:[NSValue valueWithRange:textRange]];
    
    return textRange;
}

- (BOOL)pageAvailable:(NSInteger)page
{
    if (page == 1)
    {
        return YES;
    }
    
    NSRange textRange = [self rangeOfTextForPage:page];
    return (textRange.length != 0);
}

- (NSString *)textForPage:(NSInteger)page
{
    return [self.bookText substringWithRange:[self rangeOfTextForPage:page]];
}

@end
