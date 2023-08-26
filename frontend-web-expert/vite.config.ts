import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";
import svgr from "vite-plugin-svgr";
// import mkcert from "vite-plugin-mkcert";
import { NodeGlobalsPolyfillPlugin } from "@esbuild-plugins/node-globals-polyfill";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), svgr({ svgrOptions: {} })], // , mkcert()
  resolve: {
    alias: [{ find: "@", replacement: path.resolve(__dirname, "src") }],
  },
  optimizeDeps: {
    esbuildOptions: {
      // Node.js global to browser globalThis
      define: {
        global: "globalThis",
      },
      // Enable esbuild polyfill plugins
      plugins: [
        NodeGlobalsPolyfillPlugin({
          buffer: true,
        }),
      ],
    },
  },
});
