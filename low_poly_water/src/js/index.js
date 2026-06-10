import * as THREE from "three";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";

// shaders
import vertexShader from "../shaders/vertex.glsl?raw";
import fragmentShader from "../shaders/fragment.glsl?raw";

class World {
  // constructor
  constructor() {
    this.renderer = this.#initRenderer();
    this.scene = this.#initScene();
    this.camera = this.#initPerspectiveCamera();

    this.controls = this.#initControl();
    this.gltfLoader = this.#initGltfLoader();

    this.#init();
  }

  async #init() {
    this.#initLights();
    this.#initBackground();

    await this.#initObjects();

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
    camera.position.set(0, 6, 10);
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

  // Background
  #initBackground() {
    this.scene.background = new THREE.Color(0x141414);
  }
  // Lights
  #initLights() {
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.2);
    this.scene?.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight("#ffffff", 0.75);
    directionalLight.position.set(5, 5, 5);
    directionalLight.castShadow = true;
    directionalLight.shadow.camera.bottom = -12;
    this.scene?.add(directionalLight);
  }

  // Initiate Objects
  async #initObjects() {
    const gridColor = 0xffffff;
    const gridHelper = new THREE.GridHelper(2, 10, gridColor, gridColor);
    gridHelper.material.transparent = true;
    gridHelper.material.opacity = 0.1;
    // this.scene.add(gridHelper);

    const axesHelper = new THREE.AxesHelper(2);
    axesHelper.position.y = 0.2;
    // this.scene.add(axesHelper);

    // meshes
    // const geometry = new THREE.IcosahedronGeometry(1, 1);
    const geometry = new THREE.PlaneGeometry(10, 10, 30, 30);
    // const geometry = new THREE.SphereGeometry(5, 200);
    console.log(geometry.attributes);

    const material = new THREE.ShaderMaterial({
      uniforms: {
        uTime: { value: 0 },
      },
      vertexShader: vertexShader,
      fragmentShader: fragmentShader,
      side: THREE.DoubleSide,
      // wireframe: true,
    });
    // material.uniforms.uTime = { value: 0 };
    this.material = material;

    const waterPlane = new THREE.Mesh(geometry, material);
    waterPlane.rotation.x = Math.PI / 2;
    // waterPlane.rotation.z = -Math.PI / 2;
    this.scene.add(waterPlane);
  }

  // Animate Scene
  #initAnimationLoop() {
    this.renderer.setAnimationLoop((time) => {
      this.controls.update();

      if (this.material.uniforms.uTime) {
        this.material.uniforms.uTime.value = time / 1000;
      }

      this.renderer.render(this.scene, this.camera);
    });
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
