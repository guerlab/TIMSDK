//
//  TCommonCell.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/6.
//

#import "TCommonCell.h"
#import "MMLayout/UIView+MMLayout.h"

@implementation TCommonCellData

- (CGFloat)heightOfWidth:(CGFloat)width
{
    return 44;
}
@end

@interface TCommonTableViewCell()<UIGestureRecognizerDelegate>
@property TCommonCellData *data;
@property UITapGestureRecognizer *tapRecognizer;
@end

@implementation TCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        _tapRecognizer.delegate = self;
        _tapRecognizer.cancelsTouchesInView = NO;
        
        _colorWhenTouched = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0  blue:219.0/255.0  alpha:1];
        _changeColorWhenTouched = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)tapGesture:(UIGestureRecognizer *)gesture
{
    if (self.data.cselector) {
        UIViewController *vc = self.mm_viewController;
        if ([vc respondsToSelector:self.data.cselector]) {
            self.selected = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [vc performSelector:self.data.cselector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

- (void)fillWithData:(TCommonCellData *)data
{
    self.data = data;
    if (data.cselector) {
        [self addGestureRecognizer:self.tapRecognizer];
    } else {
        [self removeGestureRecognizer:self.tapRecognizer];
    }
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = self.colorWhenTouched;
    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = [UIColor whiteColor];
    }
}


-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = [UIColor whiteColor];
    }
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
