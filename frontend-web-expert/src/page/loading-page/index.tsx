import { useState } from "react";
import useInterval from "@/util/use-interval";
import WarningPage from "@/component/warning-page";

function LoadingPage() {
  const [dotString, setDotString] = useState<string>(".");

  useInterval(() => {
    setDotString(dotString === "..." ? "." : dotString.concat("."));
  }, 1000);

  return (
    <WarningPage icon=":|" title={`Loading${dotString}`} subtitle="페이지를 불러오는 중입니다. 잠시 기다려 주세요." />
  );
}

export default LoadingPage;
