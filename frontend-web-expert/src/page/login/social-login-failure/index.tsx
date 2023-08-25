import { LOGIN_ROUTE } from "@/router/router";
import { Icon, Text, Outer, Header, Description, BackButton } from "./style";

function SocialLoginFailure() {
  return (
    <Outer>
      <Icon>{":("}</Icon>
      <Text>
        <Header>소셜 로그인 실패</Header>
        <Description>소셜 로그인에 문제가 발생했습니다. 다시 시도해주세요.</Description>
        <BackButton to={LOGIN_ROUTE}>로그인 페이지로</BackButton>
      </Text>
    </Outer>
  );
}

export default SocialLoginFailure;
