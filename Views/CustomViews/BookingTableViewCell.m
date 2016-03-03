//
//  BookingTableViewCell.m
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "BookingTableViewCell.h"
#import "Segment.h"
#import "FlightDetails.h"
#import "WebService.h"


@interface BookingTableViewCell ()
@property UILabel *flightDurationLabel;
@property UILabel *flightDirectionLabel;

@property UILabel *originCityLabel;
@property UILabel *destinationCityLabel;
@property UILabel *airlineLabel;
@property UILabel *departureTimeLabel;
@property UILabel *departureDateLabel;
@property UILabel *arrivalTimeLabel;
@property UILabel *arrivalDateLabel;
@property UIImageView *airlineImageView;




@end

@implementation BookingTableViewCell


- (instancetype)initWithSegment:(Segment*)segment reuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _segment = segment;
        
        _flightDirectionLabel = [UILabel new];
        _flightDirectionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_flightDirectionLabel setTextAlignment:NSTextAlignmentCenter];
        [_flightDirectionLabel setFont:[UIFont boldSystemFontOfSize:23.0]];
        [_flightDirectionLabel setBackgroundColor:[BookingTableViewCell lightYellow]];
        [_flightDirectionLabel setTextColor:[UIColor blackColor]];
        
        _flightDurationLabel = [UILabel new];
        [_flightDurationLabel setBackgroundColor:[BookingTableViewCell lightYellow]];
        [_flightDurationLabel setTextAlignment:NSTextAlignmentCenter];
        _flightDurationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_flightDurationLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_flightDurationLabel setTextColor:[UIColor blackColor]];
        
        _originCityLabel = [UILabel new];
        _originCityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_originCityLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_originCityLabel setTextColor:[UIColor blackColor]];
        [_originCityLabel setTextAlignment:NSTextAlignmentLeft];

        _destinationCityLabel = [UILabel new];
        _destinationCityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_destinationCityLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_destinationCityLabel setTextColor:[UIColor blackColor]];
        [_destinationCityLabel setTextAlignment:NSTextAlignmentLeft];
        
        _airlineLabel = [UILabel new];
        _airlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_airlineLabel setFont:[UIFont italicSystemFontOfSize:19.0f]];
        [_airlineLabel setTextColor:[UIColor grayColor]];
        [_airlineLabel setTextAlignment:NSTextAlignmentLeft];
        
        _departureDateLabel = [UILabel new];
        _departureDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_departureDateLabel setFont:[UIFont systemFontOfSize:10.0]];
        [_departureDateLabel setTextColor:[UIColor blackColor]];
        [_departureDateLabel setTextAlignment:NSTextAlignmentLeft];
        
        _departureTimeLabel = [UILabel new];
        _departureTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_departureTimeLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [_departureTimeLabel setTextColor:[UIColor blackColor]];
        [_departureTimeLabel setTextAlignment:NSTextAlignmentLeft];
        
        _arrivalTimeLabel = [UILabel new];
        _arrivalTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_arrivalTimeLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [_arrivalTimeLabel setTextColor:[UIColor blackColor]];
        [_arrivalTimeLabel setTextAlignment:NSTextAlignmentLeft];
        
        _arrivalDateLabel = [UILabel new];
        _arrivalDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_arrivalDateLabel setFont:[UIFont systemFontOfSize:10.0]];
        [_arrivalDateLabel setTextColor:[UIColor blackColor]];
        [_arrivalDateLabel setTextAlignment:NSTextAlignmentLeft];
        
        _airlineImageView = [UIImageView new];
        _airlineImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self.contentView addSubview:_flightDurationLabel];
        [self.contentView addSubview:_flightDirectionLabel];
        [self.contentView addSubview:_originCityLabel];
        [self.contentView addSubview:_destinationCityLabel];
        
        [self.contentView addSubview:_airlineImageView];
        [self.contentView addSubview:_airlineLabel];

        
        [self.contentView addSubview:_departureDateLabel];
        [self.contentView addSubview:_departureTimeLabel];
        
        [self.contentView addSubview:_arrivalDateLabel];
        [self.contentView addSubview:_arrivalTimeLabel];
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.3f;
        self.layer.cornerRadius = 7.0f;
        [self updateConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)layoutSubviews{
    self.flightDurationLabel.text = [NSString stringWithFormat:@"Flight durarion %@",self.segment.outbound.departureTime] ;
    self.flightDirectionLabel.text = @"Ida";
    self.departureTimeLabel.text = self.segment.outbound.departureTime;
    self.departureDateLabel.text = self.segment.outbound.departureDate;
    self.arrivalDateLabel.text = self.segment.inbound.arrivalDate;
    self.arrivalTimeLabel.text = self.segment.inbound.arrivalTime;
    self.originCityLabel.text = self.segment.inbound.origin;
    self.destinationCityLabel.text = self.segment.inbound.destination;
    self.airlineLabel.text = self.segment.outbound.airline;
    [[WebService shared] downloadImageFromUrl:self.segment.outbound.airlineImageUrlString completion:^(UIImage *image) {
        [self.airlineImageView setImage:image];
    }];
}

- (void)updateConstraints{
    [super updateConstraints];
    
       NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_flightDirectionLabel,_flightDurationLabel,_originCityLabel,_destinationCityLabel,_airlineImageView,_airlineLabel,_departureTimeLabel,_departureDateLabel,_arrivalTimeLabel,_arrivalDateLabel);
    
    NSDictionary *metrics = @{@"columnSpace" : @(30),@"imageViewWidth":@(40),@"imageViewHeight":@(40)};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_flightDirectionLabel(20)][_flightDurationLabel(30)]-[_departureTimeLabel][_departureDateLabel]-[_airlineImageView(imageViewHeight)]-[_arrivalTimeLabel][_arrivalDateLabel]" options:0 metrics:metrics views:dictionaryView]];
    
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(70)-[_originCityLabel]-(15)-[_airlineLabel]-(20)-[_destinationCityLabel]" options:0 metrics:0 views:dictionaryView]];
    
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_flightDurationLabel]|" options:0 metrics:0 views:dictionaryView]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_flightDirectionLabel]|" options:0 metrics:0 views:dictionaryView]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureTimeLabel(40)]-(columnSpace)-[_originCityLabel]|" options:0 metrics:metrics views:dictionaryView]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureTimeLabel(40)]-(columnSpace)-[_airlineImageView(imageViewWidth)]-[_airlineLabel]|" options:0 metrics:metrics views:dictionaryView]];
    
      [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureTimeLabel(40)]-(columnSpace)-[_destinationCityLabel]|" options:0 metrics:metrics views:dictionaryView]];
    
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureDateLabel(90)]" options:0 metrics:0 views:dictionaryView]];
    
      [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_arrivalTimeLabel(40)]" options:0 metrics:0 views:dictionaryView]];
    
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_arrivalDateLabel(90)]" options:0 metrics:0 views:dictionaryView]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(UIColor*)lightYellow{
    return [UIColor colorWithRed:255.0f/255 green:251.0f/255 blue:230.0f/255 alpha:1];
}

@end
