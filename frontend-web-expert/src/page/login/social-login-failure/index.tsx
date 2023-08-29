import { LOGIN_ROUTE } from "@/router/router";
import { BackButton } from "./style";
import WarningPage from "@/component/warning-page";

function SocialLoginFailure() {
  return (
    <WarningPage icon=":(" title="소셜 로그인 실패" subtitle="소셜 로그인에 문제가 발생했습니다. 다시 시도해주세요.">
      <BackButton to={LOGIN_ROUTE}>로그인 페이지로</BackButton>
    </WarningPage>
  );
}

export default SocialLoginFailure;
