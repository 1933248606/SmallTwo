# FYComboBox

[![Build Status][travis-image]][travis-url]

FYComboBox is a flexible and easy to use ComboBox.
You can configure the look and feel on Interface Builder.

<img src="https://raw.githubusercontent.com/felipowsky/FYComboBox/master/Extras/example.gif" width="400">

## Installation

### CocoaPods

1. Add `pod 'FYComboBox'` to your project's Podfile
2. Run `pod install`

## Usage

**Important**: in order to make `FYComboBox` really flexible the control doesn't implement any extra component automatically like a `UILabel` or `UIImageView`. Instead you use the delegate methods to handle the changes on your interface programmatically. See the [example project](http://github.com/felipowsky/FYComboBox/tree/master/FYComboBoxExample) for references.

### Interface Builder

Select a View an change its class to `FYComboBox` in the identity inspector.

<img src="https://raw.githubusercontent.com/felipowsky/FYComboBox/master/Extras/interfacebuilder_configuration.png">

You can also configure other aspects of the ComboBox in the attributes inspector.

### Delegate

Implement `FYComboBoxDelegate` to handle datasource and events.

```objective-c
// Example

@interface ExampleViewController
@property (nonatomic, strong) NSArray *array;
@end

// ...

#pragma mark - FYComboBoxDelegate

- (NSInteger)comboBoxNumberOfRows:(FYComboBox *)comboBox
{
  return self.array.count;
}

- (NSString *)comboBox:(FYComboBox *)comboBox titleForRow:(NSInteger)row
{
  return self.array[row];
}

- (void)comboBox:(FYComboBox *)comboBox didSelectRow:(NSInteger)row
{
  NSLog(@"Selected %@", self.array[row]);
  [comboBox closeAnimated:YES];
}
```

## License

You can check the license in the [license file](http://github.com/felipowsky/FYComboBox/blob/master/LICENSE)

[travis-url]:  https://travis-ci.org/felipowsky/FYComboBox
[travis-image]: https://travis-ci.org/felipowsky/FYComboBox.svg?style=flat
