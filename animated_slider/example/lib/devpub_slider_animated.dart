import 'package:flutter/material.dart';

class AnimatedSlider extends StatefulWidget {
  final Key key;
  final double range;
  final double buttonSize;
  final double buttonBorderRadius;
  final Icon buttonIcon;
  final Color buttonColor;
  final Color progressColor;
  final Widget progressText;
  final Widget barText;
  final Color barColor;
  final double barBorderRadius;
  final double barHeight;
  final Function onSuccess;
  final Function onFailed;

  AnimatedSlider({
    this.key,
    this.range = 0.8,
    this.buttonIcon,
    this.buttonBorderRadius = 90,
    this.buttonColor = Colors.blue,
    this.buttonSize = 50,
    this.barText,
    this.barHeight = 45,
    this.barColor = Colors.black12,
    this.barBorderRadius = 90,
    this.progressText,
    this.progressColor = Colors.amber,
    this.onSuccess,
    this.onFailed
  }) : super(key: key);

  @override
  AnimatedSliderState createState() => AnimatedSliderState();
}

class AnimatedSliderState extends State<AnimatedSlider> with TickerProviderStateMixin {
  GlobalKey _keyWidget = GlobalKey();
  double _positionX = 0;
  double _scaleButton = 1.3;

  AnimationController animationController;
  Animation<double> _backPosition;

  AnimationController scaleAnimationController;
  Animation<double> _scaleButtonAnimation;

  AnimationController opacityProgressTextAnimationController;
  Animation<double> _opacityProgressTextAnimation;
  Animation<double> _moveProgressTextAnimation;

  void reset(){
    setPosition(0);
    opacityProgressTextAnimationController.reverse();
    scaleAnimationController.reverse();
  }

  void setPosition([double x = 0, Function callback]){
    _backPosition = Tween<double>(begin: _positionX, end: x).animate(CurvedAnimation(
      parent: animationController, 
      curve: Curves.elasticOut)
    );
    // Inicia animação e quando terminar mantem a posicao do botao
    animationController.forward().whenComplete((){
      _positionX = x;
      animationController.reset();
      callback();
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    scaleAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    opacityProgressTextAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _backPosition = Tween<double>(begin: _positionX, end: 0).animate(
      CurvedAnimation(
        parent: animationController, 
        curve: Curves.fastLinearToSlowEaseIn,
      )
    );
    _scaleButtonAnimation = Tween<double>(begin: 1, end: _scaleButton).animate(CurvedAnimation(
      parent: scaleAnimationController, 
      curve: Curves.elasticOut)
    );
    _opacityProgressTextAnimation = Tween<double>(begin: 0, end: 1).animate(opacityProgressTextAnimationController);
    _moveProgressTextAnimation = Tween<double>(begin: -150, end: 0).animate(CurvedAnimation(
      parent: opacityProgressTextAnimationController, 
      curve: Curves.elasticOut)
    );
  }

  void onDragStart(DragStartDetails details){
    setState(() {
      scaleAnimationController.forward();      
    });
  }

  void onDragUpdate(DragUpdateDetails details){
    //verifica se a posicao esta menor que o limite
    var positionXTemp = details.localPosition.dx < 0.0 ? 0.0 : details.localPosition.dx;

    // verifica se a posicao esta maior que o limite
    var maxWidth = _keyWidget.currentContext.size.width - widget.buttonSize;
    positionXTemp = positionXTemp > maxWidth ? maxWidth : positionXTemp;
    
    setState(() {
      _positionX = positionXTemp;

      if(_positionX > maxWidth * widget.range && !opacityProgressTextAnimationController.isAnimating)
        opacityProgressTextAnimationController.forward();
      else if(!opacityProgressTextAnimationController.isAnimating)
        opacityProgressTextAnimationController.reverse();
    });
  }

  void onDragEnd(DragEndDetails details){
    var maxWidth = _keyWidget.currentContext.size.width - widget.buttonSize;
    setState(() {
      scaleAnimationController.reverse();
      if(_positionX < maxWidth * widget.range)
        setPosition(0, (){
          widget.onFailed();
        });
      else
        setPosition(maxWidth, () {
          widget.onSuccess();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: _keyWidget,
      animation: animationController,
      builder: (context, child){
        var x = animationController.isDismissed ? _positionX : _backPosition.value;
        return Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            _BackContainer(
              text: widget.barText,
              backgroundColor: widget.barColor,
              height: widget.barHeight,
              borderRadius: widget.barBorderRadius,
            ),
            _FrontContainer(
              backgroundColor: widget.progressColor,
              height: widget.barHeight,
              width: x <= (widget.buttonSize/2) ? 0 : (x+widget.buttonSize/2),
              borderRadius: widget.barBorderRadius,
            ),
            AnimatedBuilder(
              animation: opacityProgressTextAnimationController,
              builder: (context, child){
                return Transform.translate(
                  offset: Offset(_moveProgressTextAnimation.value, 0),
                  child: Opacity(
                    opacity: _opacityProgressTextAnimation.value,
                    child: child
                  ),
                );
              }, 
              child: widget.progressText
            ),
            Transform.translate(
              offset: Offset(x, 0.0),
              child: child,
            ),
          ],
        );
      },
      child: GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: 
        AnimatedBuilder(
          animation: scaleAnimationController,
          builder: (context, child){
            return Transform.scale(
              scale: _scaleButtonAnimation.value,
              child: child
            );
          },
          child: _IconButton(
            icon: widget.buttonIcon,
            size: widget.buttonSize,
            borderRadius: widget.buttonBorderRadius,
            color: widget.buttonColor,
          ),
        ) 
      ),
    );
  }
}

class _BackContainer extends StatelessWidget {
  final Widget text;
  final Color backgroundColor;
  final double height;
  final double borderRadius;

  _BackContainer({
    this.text,
    this.backgroundColor,
    this.height,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius) 
      ),
      child: text
    );
  }
}

class _IconButton extends StatelessWidget {
  final double size;
  final Icon icon;
  final Color color;
  final double borderRadius;

  _IconButton({
    this.size,
    this.icon,
    this.color,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: IconButton(
        color: color,
        iconSize: size,
        onPressed: () {},
        icon: icon,
      ),
    );
  }
}

class _FrontContainer extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  final double borderRadius;

  _FrontContainer({
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius) 
      ),
      child: Container(),
    );
  }
}