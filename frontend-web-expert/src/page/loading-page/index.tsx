import { Icon, Text, Outer, Header, Description } from "./style";

function LoadingPage() {
  return (
    <Outer>
      <Icon>{":|"}</Icon>
      <Text>
        <Header>Loading...</Header>
        <Description>페이지를 불러오는 중입니다. 잠시 기다려 주세요.</Description>
      </Text>
    </Outer>
  );
}

export default LoadingPage;
