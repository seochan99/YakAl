import ReactDOM from "react-dom/client";
import App from "./app";

declare global {
  interface Window {
    daum?: any; // 주소지 모듈
    IMP?: any; // 결제 및 인증 모듈
  }
}

document.cookie = "SameSite=None;";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(<App />);
