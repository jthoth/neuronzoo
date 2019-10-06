
<template >
    <v-container fluid grid-list-xl>
          <v-row>
              <v-col cols="2" md="3">
                <v-card  class="pa-2" raised tile>
                  <v-col  cols="12">
                    <div class="overline mb-4"> <v-icon>mdi-apache-kafka</v-icon>Fractal Brownian Motion Over Neuron Operation</div>
                    <v-select v-model="generation" class="mt-7" label="Generation"
                      item-text="name" item-value="value"
                      :items="generations" outlined >
                    </v-select>
                  <v-select v-model="neuron" label="Neuron"
                    item-text="name" item-value="value"
                    :items="neurons" outlined>
                  </v-select>

                  <label class="overline">Size Input {{size_input}}</label>
                  <v-slider v-model="size_input" :max="5" :min="0" :step="0.25"></v-slider>
                  <label class="overline">Size Cell Body {{size_body}}</label>
                  <v-slider v-model="size_body" :max="5" :min="0" :step="0.25"></v-slider>
                  <label class="overline">Size Output {{size_output}}</label>
                  <v-slider v-model="size_output" :max="5" :min="0" :step="0.25"></v-slider>
                </v-col>
                <label class="overline"> <v-icon>mdi-settings</v-icon> Scroll to zoop up or down and Mouse Control </label>

              </v-card>
            </v-col>
            <v-col cols="8" md="9">
              <v-card class="pa-2" raised tile>
                <Scene>
                  <Property name="clearColor" color="#FFF"></Property>
                  <HemisphericLight></HemisphericLight>
                  <Asset :src="generation.src" :position="[0, 0, 0]" :rotation="[0, 1.5, -2.1]"> </Asset>
                  <Sphere :scaling="[size_body, size_body, size_body]">
                      <Shader name="inline" :vertexShader="vertexShader" :fragmentShader="cellBodyfragmentShader">
                        <Uniform variable="num_octaves" :float="generation.neurons.length"></Uniform>
                      </Shader>
                  </Sphere>
                  <Box v-for="neuron in generation.neurons" :position="neuron"
                  :scaling="[size_input, size_input, size_input]"
                  :rotation="[0, 1.5, -2.1]">
                    <Shader name="inline" :vertexShader="vertexShader" :fragmentShader="inputfragmentShader">
                        <Uniform variable="num_octaves" :float="generation.neurons.length"></Uniform>
                    </Shader>
                  </Box>
                  <Box  :position="generation.output"
                  :scaling="[size_output, size_output, size_output]"
                  :rotation="[0, 1.5, -2.1]">
                      <Shader name="inline" :vertexShader="vertexShader" :fragmentShader="outputfragmentShader">
                        <Uniform variable="num_octaves" :float="generation.neurons.length"></Uniform>
                        <Uniform variable="neuron" :float="neuron"></Uniform>
                      </Shader>
                  </Box >
                </Scene>
              </v-card>
            </v-col>
        </v-row>

</v-container>

</template>

<script>
import { BABYLON } from 'vue-babylonjs';

import VERTEX from '../assets/vertex.glsl';
import input_fragment from '../assets/input_fragment.glsl';
import cell_body_fragment from '../assets/cell_body_fragment.glsl';
import output_fragment from '../assets/out_fragment.glsl';


BABYLON.Effect.ShadersStore['VertexShader'] = VERTEX;

BABYLON.Effect.ShadersStore['inputFragmentShader'] = input_fragment;
BABYLON.Effect.ShadersStore['cellFragmentShader'] = cell_body_fragment;
BABYLON.Effect.ShadersStore['outputFragmentShader'] = output_fragment;


export default{
  name:'Waves',
  data() {
    let generations = [
      {name:'Firsth', value:{src:`${process.env.BASE_URL}v1.obj`, neurons:[[-4.6, -.3, 0],
      [-4.5, .4, -.55]], output:[4, .05, .38]}},
      {name:'Second', value:{src:`${process.env.BASE_URL}v2.obj`, neurons:[[-4.9, -.3, -.1],
      [-5, -.7, .1], [-4.8, 0.15, -.4], [-4.75, .48, -.55]],
      output:[4.0, 1.1, -.3]}},
      {name:'Third', value:{src:`${process.env.BASE_URL}v3.obj`,  neurons:[
      [-3.8, .2, -.35], [-3.89, 1.0, 1.2],
      [-3.6, 2.7, -.15], [-4.4, -2.0, -.45], [-3.4, -1.0, 2.5],
      [-4, -.6, -1.4], [-3.93, 1.0, -2.5]], output:[4.4, .45, .48]}},
    ];

    return {
      size_input:0.35,
      size_body:1.0,
      size_output:0.50,
      generations : generations,
      neurons : [
        {name:'Step', value:1},
        {name:'Sigmoid', value:2},
        {name:'Thangent', value:3},
        {name:'Leaky Integrate and Fire', value:4},
      ],
      generation: generations[1].value,
      neuron: 2,
    }
  },
  methods:{
    loadDataset: function() {

    },
  },
  computed: {
    vertexShader() {
      return VERTEX;
    },
    inputfragmentShader() {
      return input_fragment;
    },
    cellBodyfragmentShader() {
      return cell_body_fragment;
    },
    outputfragmentShader() {
      return output_fragment;
    },
  }
}
</script>
