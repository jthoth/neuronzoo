# One Neuron Drawn with Maya Modeler as Object and loaded with vue-babylonjs

![N|Solid](https://static.thenounproject.com/png/1503825-200.png)


[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

This project is a homework, it is part of CC7515  (GPU COMPUTING).
# Description

The purpose of this project was build a shader which simulate an ocean wave movements. However,  I partly did it, because I divert it a little bit because I used the value of each pixel computed by the shader to compute functions activations of the artificial neural networks and update the shader with those results. I also considered the generations of Neural networks to compute the outputs. The models of neurons was built with Maya-Autocad and was exported as an Object. Each shape in the camera was filled with the shader, with some modifications for each stage (input, cellbody, outpu)

**Note**: The code of the shaders are in this path -> **/src/assets/*.glsl**.

### Tech

* [Os Windows]- Windows 10.
* [Node]- JavaScript run-time environment that executes JavaScript code outside of a browser
* [Languaje]- Javascript Es6
* [Web Framwork]- Vuejs
* [Graphs]- vue-babylonjs
* [Glsl]- GLSL

### Installation
homework installation steps. You should install nodejs or only open the url of the project.
For running this project locally follow the next steps:
```sh
$ git clone https://github.com/jthoth/neuronzoo
$ cd neuronzoo
$ npm install
$ npm run serve
```


### ScreenShots
![N|Solid](https://raw.githubusercontent.com/jthoth/neuronzoo/master/public/screenshot.png)


License
----

Apache 2.0
