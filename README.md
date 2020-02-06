# Flutter Animated Slider!

[](images/sliders_example.gif)

If you want to save your time with a animated slider, just install and enjoy it!

## How to use

Install the package
```dart
dependencies:
  animated_slider: ^1.0.0
```
Now, you can use **AnimatedSlider** in your application.
``` dart
AnimatedSlider(
	buttonSize: 50,
	barHeight: 40,
	barText: Center(child: Text('Swipe to signing', style: TextStyle(color: Colors.black45),),),
	progressText: Center(child: Text('Signing...', style: TextStyle(color: Colors.white)),),
	buttonIcon: Icon(
	Icons.create,
	color: Colors.white,
	size: 25,
	),
),
```
## Properties
|Property               |Description                                                                                        |
|-----------------------|---------------------------------------------------------------------------------------------------|
|key				    |use the property KEY to access some functions like **reset()** and **setPosition(double)**.        |
|range				    |define the max range in percent(%) to trigger **onSuccess()**.                                     |
|buttonIcon				|define a icon to your button.                                                                      |
|buttonBorderRadius		|define a border radius to your button.                                                             |
|buttonColor			|define the button color.                                                                           |
|buttonSize				|define the button size.                                                                            |
|barText				|define a widget inside the bar.                                                                    |
|barHeight				|define the height of the bar.                                                                      |
|barColor				|define the bar color.                                                                              |
|barBorderRadius		|define the border radius bar.                                                                      |
|progressText           |define a widget inside the progress bar.                                                           |
|progressColor          |define the progress bar color.                                                                     |
|onSuccess              |define a callback when you swipe to right.                                                         |
|onFailed               |define a callback when you swipe to left.                                                          |

## Plataforma
|           |Android   |IOS            |Web          |
|-----------|----------|---------------|-------------|
|Suporte	|Sim       |Sim            |Não testado  |

## Colaboradores
- Rafael Kenji Nagai

## Links
[Flutter Package](https://pub.dev/packages/animated_slider)

#### Enjoy yourself!
