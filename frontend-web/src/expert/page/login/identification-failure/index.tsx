import { LOGIN_ROUTE } from "@/expert/router/router.tsx";
import { BackButton } from "./style.ts";
import WarningPage from "@/expert/component/warning-page";

function IdentificationFailure() {
  return (
    <WarningPage icon=":(" title="본인인증 실패" subtitle="본인인증 과정에서 문제가 발생했습니다. 다시 시도해주세요.">
      <BackButton to={LOGIN_ROUTE}>로그인 페이지로</BackButton>
    </WarningPage>
  );
}

export default IdentificationFailure;
