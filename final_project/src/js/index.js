import * as THREE from "three";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { HDRLoader } from "three/addons/loaders/HDRLoader.js";
import { RenderPass } from "three/addons/postprocessing/RenderPass.js";
import { EffectComposer } from "three/addons/postprocessing/EffectComposer.js";
import { UnrealBloomPass } from "three/addons/postprocessing/UnrealBloomPass.js";

// shaders
import vertexShader from "../shaders/vertex.glsl?raw";
import vertexShaderMain from "../shaders/vertex_main.glsl?raw";
import vertexShaderPars from "../shaders/vertex_pars.glsl?raw";
import fragmentShader from "../shaders/fragment.glsl?raw";
import fragmentShaderMain from "../shaders/fragment_main.glsl?raw";
import fragmentShaderPars from "../shaders/fragment_pars.glsl?raw";

class World {
  // constructor
  constructor() {
    this.renderer = this.#initRenderer();
    this.scene = this.#initScene();
    this.camera = this.#initPerspectiveCamera();

    this.controls = this.#initControl();
    this.gltfLoader = this.#initGltfLoader();
    this.hdrTextureLoader = this.#hdrTextureLoader();

    this.#init();
  }

  async #init() {
    this.#initLights();
    this.#initBackground();

    await this.#initObjects();
    this.#createBloomEffect();

    this.#initAnimationLoop();
    this.#initResize();
  }

  // Render
  #initRenderer() {
    const renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.outputColorSpace = THREE.SRGBColorSpace;
    document.body.append(renderer.domElement);
    return renderer;
  }

  // Scene
  #initScene() {
    const scene = new THREE.Scene();
    return scene;
  }

  // Camera
  #initPerspectiveCamera() {
    const camera = new THREE.PerspectiveCamera(
      45,
      window.innerWidth / window.innerHeight,
      0.1,
      1000,
    );
    camera.position.set(0, 3, 5);
    return camera;
  }

  // Orbit Control
  #initControl() {
    const controls = new OrbitControls(this.camera, this.renderer.domElement);
    controls.update();

    return controls;
  }

  // Gltf Loader
  #initGltfLoader() {
    const gltfLoader = new GLTFLoader();
    return gltfLoader;
  }

  // hdr loader
  #hdrTextureLoader() {
    const hdrTextureLoader = new HDRLoader();
    return hdrTextureLoader;
  }

  // Background
  #initBackground() {
    this.scene.background = new THREE.Color(0x141414);
  }
  // Lights
  #initLights() {
    const ambientLight = new THREE.AmbientLight("#7481ff", 0.5);
    this.scene?.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight("#526cff", 0.6);
    directionalLight.position.set(2, 2, 2);
    this.scene?.add(directionalLight);
  }

  // Initiate Objects
  async #initObjects() {
    // const geometry = new THREE.PlaneGeometry(2, 2, 2, 2);
    const geometry = new THREE.IcosahedronGeometry(1, 300);

    const dummyTexture = new THREE.DataTexture(new Uint8Array([0]), 1, 1);
    dummyTexture.needsUpdate = true;

    const material = new THREE.MeshStandardMaterial({
      displacementMap: dummyTexture,
      onBeforeCompile: (shader) => {
        // Store a reference to update uniforms in the animation loop
        material.userData.shader = shader;
        shader.uniforms.uTime = { value: 0 };

        const parsTarget = /*glsl*/ `#include <displacementmap_pars_vertex>`;
        shader.vertexShader = shader.vertexShader.replace(
          parsTarget,
          `${parsTarget}\nuniform float uTime;\n${vertexShaderPars}`,
        );

        const mainTarget = /*glsl*/ `#include <displacementmap_vertex>`;
        shader.vertexShader = shader.vertexShader.replace(
          mainTarget,
          `${mainTarget}\n${vertexShaderMain}`,
        );

        const mainFragmentString = /*glsl*/ `#include <normal_fragment_maps>`;
        shader.fragmentShader = shader.fragmentShader.replace(
          mainFragmentString,
          `${mainFragmentString}\n${fragmentShaderMain}`,
        );

        const parsFragmentString = /*glsl*/ `#include <bumpmap_pars_fragment>`;
        shader.fragmentShader = shader.fragmentShader.replace(
          parsFragmentString,
          `${parsFragmentString}\n${fragmentShaderPars}`,
        );

        console.log(shader.fragmentShader);
      },
    });
    material.userData.shader = null;
    this.material = material;
    // console.log(this.material);

    const organicShape = new THREE.Mesh(geometry, material);
    this.scene.add(organicShape);
  }

  #createBloomEffect() {
    // Effect composer holds all pass
    this.composer = new EffectComposer(this.renderer);

    // represents the original colors of the scene - pass 1
    const renderPass = new RenderPass(this.scene, this.camera);
    this.composer.addPass(renderPass);

    // pass 2
    const bloomPass = new UnrealBloomPass(
      new THREE.Vector2(window.innerWidth, window.innerHeight),
      2, // Strength (increased from 0.1)
      0.05, // Radius
      0.07, // threshold
    );
    this.composer.addPass(bloomPass);

    this.renderer.toneMapping = THREE.ACESFilmicToneMapping;
    // this.renderer.toneMappingExposure = 4;
  }

  // Animate Scene
  #initAnimationLoop() {
    const animate = (time) => {
      this.controls.update();

      if (this.material.userData.shader?.uniforms?.uTime) {
        this.material.userData.shader.uniforms.uTime.value = time / 1000;
      }

      this.composer.render();
      requestAnimationFrame(animate);
    };
    animate(performance.now());
  }

  // Handle Screen Resize
  #initResize() {
    window.addEventListener("resize", () => {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.renderer.setPixelRatio(window.devicePixelRatio);
    });
  }
}

const myWorld = new World();
