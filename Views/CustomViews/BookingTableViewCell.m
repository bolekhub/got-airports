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
@property UILabel *flightDirectionLabel;

@property UILabel *originCityLabel;
@property UILabel *destinationCityLabel;
@property UILabel *airlineLabel;
@property UILabel *departureTimeLabel;
@property UILabel *departureDateLabel;
@property UILabel *arrivalTimeLabel;
@property UILabel *arrivalDateLabel;
@property UIImageView *airlineImageView;
@property UIImageView *verticalLineImageView;


@property BOOKINGCELLUSE cellPurpose;
@end

@implementation BookingTableViewCell


- (instancetype)initWithSegment:(Segment*)segment reuseIdentifier:(NSString*)reuseIdentifier cellPurpose:(BOOKINGCELLUSE)cellPurpose{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _segment = segment;
        _cellPurpose = cellPurpose;
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
        
        _verticalLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"verticalLine"]];
        _verticalLineImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self.contentView addSubview:_flightDurationLabel];
        [self.contentView addSubview:_flightDirectionLabel];
        [self.contentView addSubview:_originCityLabel];
        [self.contentView addSubview:_destinationCityLabel];
        
        [self.contentView addSubview:_airlineImageView];
        [self.contentView addSubview:_verticalLineImageView];
        [self.contentView addSubview:_airlineLabel];

        
        [self.contentView addSubview:_departureDateLabel];
        [self.contentView addSubview:_departureTimeLabel];
        
        [self.contentView addSubview:_arrivalDateLabel];
        [self.contentView addSubview:_arrivalTimeLabel];
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.3f;
        self.layer.cornerRadius = 7.0f;
        
        
        self.layer.shadowOffset = CGSizeMake(-1, 1);
        self.layer.shadowOpacity = 0.5;
        
        [self updateConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)layoutSubviews{
    if (self.cellPurpose == BOOKINGCELLUSE_ARRIVAL) {
        //self.flightDurationLabel.text = [NSString stringWithFormat:@"Flight durarion %@",self.segment.inbound.departureTime] ;
        self.flightDirectionLabel.text = NSLocalizedString(@"Arrival", nil);
        self.departureTimeLabel.text = self.segment.inbound.departureTime;
        self.departureDateLabel.text = self.segment.inbound.departureDate;
        self.arrivalDateLabel.text = self.segment.inbound.arrivalDate;
        self.arrivalTimeLabel.text = self.segment.inbound.arrivalTime;
        self.originCityLabel.text = self.segment.inbound.origin;
        self.destinationCityLabel.text = self.segment.inbound.destination;
        self.airlineLabel.text = self.segment.inbound.airline;
        [[WebService shared] downloadImageFromUrl:self.segment.inbound.airlineImageUrlString completion:^(UIImage *image) {
            [self.airlineImageView setImage:image];
        }];

        
    }else if(self.cellPurpose == BOOKINGCELLUSE_DEPARTURE){
        //self.flightDurationLabel.text = [NSString stringWithFormat:@"Flight durarion %@",self.segment.outbound.departureTime] ;
        self.flightDirectionLabel.text = NSLocalizedString(@"Departure", nil);
        self.departureTimeLabel.text = self.segment.outbound.departureTime;
        self.departureDateLabel.text = self.segment.outbound.departureDate;
        self.arrivalDateLabel.text = self.segment.outbound.arrivalDate;
        self.arrivalTimeLabel.text = self.segment.outbound.arrivalTime;
        self.originCityLabel.text = self.segment.outbound.origin;
        self.destinationCityLabel.text = self.segment.outbound.destination;
        self.airlineLabel.text = self.segment.outbound.airline;
        [[WebService shared] downloadImageFromUrl:self.segment.outbound.airlineImageUrlString completion:^(UIImage *image) {
            [self.airlineImageView setImage:image];
        }];

    }
}

- (void)updateConstraints{
    [super updateConstraints];

    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_flightDirectionLabel,_flightDurationLabel,_originCityLabel,_destinationCityLabel,_airlineImageView,_airlineLabel,_departureTimeLabel,_departureDateLabel,_arrivalTimeLabel,_arrivalDateLabel,_verticalLineImageView);
    
    NSDictionary *metrics = @{@"columnSpace" : @(30), @"columnSpacePlus" : @(70), @"imageViewWidth":@(40),@"imageViewHeight":@(40)};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_flightDirectionLabel(20)][_flightDurationLabel(30)]-[_departureTimeLabel][_departureDateLabel]-[_airlineImageView(imageViewHeight)]-[_arrivalTimeLabel][_arrivalDateLabel]" options:0 metrics:metrics views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(70)-[_originCityLabel]-(15)-[_airlineLabel]-(20)-[_destinationCityLabel]" options:0 metrics:0 views:dictionaryView]];

    
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(70)-[_verticalLineImageView]-|" options:0 metrics:0 views:dictionaryView]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_flightDurationLabel]|" options:0 metrics:0 views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_flightDirectionLabel]|" options:0 metrics:0 views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureTimeLabel(40)]-(columnSpace)-[_verticalLineImageView(15)]-(20)-[_originCityLabel]|" options:0 metrics:metrics views:dictionaryView]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureTimeLabel(40)]-(columnSpacePlus)-[_airlineImageView(imageViewWidth)]-[_airlineLabel]|" options:0 metrics:metrics views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureTimeLabel(40)]-(columnSpacePlus)-[_destinationCityLabel]|" options:0 metrics:metrics views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_departureDateLabel(90)]" options:0 metrics:0 views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_arrivalTimeLabel(40)]" options:0 metrics:0 views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_arrivalDateLabel(90)]" options:0 metrics:0 views:dictionaryView]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(UIColor*)lightYellow{
    return [UIColor colorWithRed:255.0f/255 green:251.0f/255 blue:230.0f/255 alpha:1];
}

@end
