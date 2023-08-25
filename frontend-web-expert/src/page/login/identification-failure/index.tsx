import { LOGIN_ROUTE } from "@/router/router";
import { Icon, Text, Outer, Header, Description, BackButton } from "./style";

function IdentificationFailure() {
  return (
    <Outer>
      <Icon>{":("}</Icon>
      <Text>
        <Header>본인인증 실패</Header>
        <Description>본인인증 과정에서 문제가 발생했습니다. 다시 시도해주세요.</Description>
        <BackButton to={LOGIN_ROUTE}>로그인 페이지로</BackButton>
      </Text>
    </Outer>
  );
}

export default IdentificationFailure;
