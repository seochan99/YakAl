import { useState } from "react";
import { Icon, Text, Outer, Header, Description } from "./style";
import useInterval from "@/util/use-interval";

function LoadingPage() {
  const [dotString, setDotString] = useState<string>(".");

  useInterval(() => {
    setDotString(dotString === "..." ? "." : dotString.concat("."));
  }, 1000);

  return (
    <Outer>
      <Icon>{":|"}</Icon>
      <Text>
        <Header>Loading{dotString}</Header>
        <Description>페이지를 불러오는 중입니다. 잠시 기다려 주세요.</Description>
      </Text>
    </Outer>
  );
}

export default LoadingPage;
